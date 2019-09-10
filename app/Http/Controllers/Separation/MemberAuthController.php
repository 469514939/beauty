<?php

namespace App\Http\Controllers\Separation;

use Illuminate\Http\Request;
use DB;
use Session;
use Illuminate\Support\Facades\Hash;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Controllers\Controller;
use App\WxUsers;
use App\Users;

class MemberAuthController extends Controller
{
    // public function __construct()
    // {
    //     // 这里额外注意了：官方文档样例中只除外了『login』
    //     // 这样的结果是，token 只能在有效期以内进行刷新，过期无法刷新
    //     // 如果把 refresh 也放进去，token 即使过期但仍在刷新期以内也可刷新
    //     // 不过刷新一次作废
    //     // $this->middleware('auth:api', ['except' => ['login']]);
    //     $this->middleware('jwt.auth', ['except' => ['login']]);
    //     // 另外关于上面的中间件，官方文档写的是『auth:api』
    //     // 但是我推荐用 『jwt.auth』，效果是一样的，但是有更加丰富的报错信息返回
    // }

    /*注册*/
    public function register(Request $request)
    {

        $password = '123456';
        $openid = trim($request->openid);
        $wxuser = DB::table("wxusers")->where('openid',$openid)->first();
        if(empty($openid)){//已经注册
            return dataResult('','openid不能为空!',0,503);
        }

        if(!empty($wxuser)){//已经注册
            $user = Users::find($wxuser->user_id);
            $request->offsetSet('name', $user->name);
            $request->offsetSet('password', $user->plaintext_password);
            return $this->login($request);
            // return dataResult('','该微信已经注册!',0,503);
        }else{//未注册
            $user = new Users();

            //users表保存数据
            $data =[];
            $data['password'] = bcrypt($password);
            $data['plaintext_password'] = $password;
            $data['ip'] = $request->getClientIp();
            $data['status'] = 1;
            $data['name'] = 'user'.uniqid();;

            //wxusers表保存数据
            $wxuser = new WxUsers();
            $wxuser->wxid = '2000';
            $wxuser->openid = $openid;
            $wxuser->nickname = $request->nickName;
            $wxuser->avatar = $request->avatarUrl;
            $wxuser->gender = $request->gender;
            $wxuser->unionid = $request->unionid;
            $wxuser->city = $request->city;
            $wxuser->province = $request->province;
            $wxuser->country = $request->country;

            DB::beginTransaction();
            if($user = Users::create($data)){
                $wxdata['user_id'] = $user->id;
                if ($res = $user->wxUsers()->save($wxuser)){
                    DB::commit();
                    // $request->offsetSet('name', $user->name);
                    // $request->offsetSet('password', $user->plaintext_password);
                    return $this->login($request);
                } else{
                    DB::rollBack();
                    return dataResult(true,'注册失败!请稍后再试!',0,503);
                }
            }

        }
    }

    /*登陆*/
    public function login(Request $request)
    {   
        $openid = trim($request->openid);
        $wxuser = WxUsers::where('openid',$openid)->first();

        if (empty($wxuser)) {
            return response()->json(dataResult('','用户不存在',0,503));
        }

        $input = array();
        $input['name'] = $wxuser->users->name;
        $input['password'] = $wxuser->users->plaintext_password;
        $token = auth('api')->attempt($input);
        if (!$token) {
            return response()->json(dataResult('','帐号或密码错误',0,503));
        }
        $data = [];
        $data['token'] = $token;
        $m  = config('jwt.ttl');
        $timeOut = strtotime('+'.$m.'minute');
        $data['timeOut'] = $timeOut;
        return dataResult($data,'',1,200);
    }

    /*获取用户信息*/
    public function get_user_details(Request $request)
    {
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        if($user){
            $arr = Area::getAreaArr($user->area_prov,$user->area_city,$user->area_dist);
            $user->prov_name = isset($arr[$user->area_prov])?$arr[$user->area_prov]:'';
            $user->city_name = isset($arr[$user->area_city])?$arr[$user->area_city]:'';
            $user->dist_name = isset($arr[$user->area_dist])?$arr[$user->area_dist]:'';
            if(empty($user->prov_name)){
                $ect = Area::areaList($user->company_id);
                foreach ($ect as $key => $value) {
                    $user->prov_name = $value['n'];
                    $user->prov_id = $key;
                    foreach ($value['s'] as $key => $value) {
                        $user->city_name = $value['n'];
                        $user->city_id = $key;
                        break;
                    }
                    break;
                }
            }
            $user->mobile = !empty($user->mobile)?$user->mobile:null;

            //注析没必要的数据
            // unset($user->id);
        }
        return dataResult($user,'',1,200);
    }



    /*退出*/
    public function logout($forceForever = false)
    {
        // $oldToken = JWTAuth::getToken();//旧token
        // $res = JWTAuth::setToken($oldToken)->invalidate();
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',1,200);
        }
        $res = auth('api')->logout();
        return dataResult($res,'',1,200);
    }

    /*获取token黑名单*/
    public function getBlacklist(Request $request)
    {
        $black = JWTAuth::getBlacklist();
        return dataResult($black,'',1,200);
    }


    /**
     * Refresh a token.
     * 刷新token，如果开启黑名单，以前的token便会失效。
     * 值得注意的是用上面的getToken再获取一次Token并不算做刷新，两次获得的Token是并行的，即两个都可用。
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        $data = [];
        $data['token'] = auth('api')->refresh(true);
        $m  = config('jwt.ttl');
        $timeOut = strtotime('+'.$m.'minute');
        $data['timeOut'] = $timeOut;
        return dataResult($data,'',1,200);
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60
        ]);
    }




}