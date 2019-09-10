<?php

namespace App\Http\Controllers\Separation;

use App\Addr;
use App\Area;
use App\User;
use Maatwebsite\Excel\Facades\Excel;
use Validator;
use Illuminate\Http\Request;
use DB;
use App\Http\Requests;
use Illuminate\Support\Facades\Input;
use Auth;
use Illuminate\Support\Facades\Redirect;
use App\Http\Controllers\Controller;

class AddrController extends Controller
{
    /**地址管理****************************************************************************************/
    //地址管理：地址列表
    public function addr_list(){
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        // $addrs = Addr::where('user_id',$user->id)->orderBy('id','desc')->paginate(15);
        $addrs = Addr::where('user_id',$user->id)->orderBy('id','desc')->get();
        foreach($addrs as $a){
            // $a->address = "{$a->prov_name}{$a->city_name}{$a->dist_name}{$a->address}";
            $a->longaddress = Area::getAddress($a->prov,$a->city,$a->dist,$a->address);
        }

        $data = [];
        $data['addrs'] = $addrs; 

        return dataResult($data,'',1,200);
    }


    //地址管理：地址详情
    public function addr_detail($id)
    {
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        $addr = Addr::find($id);
        $data = [];
        $data['addr'] = $addr; 

        return dataResult($data,'',1,200);
    }


    /**
     * 创建地址
     *
     * @return Response
     */
    public function store(Request $request)
    {
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        $rules = [
            'name' => 'required | max:255',
            'mobile' => 'digits:11', 
            //'tel' => 'digits_between:4,13'
        ];

        $validator =  Validator::make($request->all(), $rules);

        if ($validator->fails())
        {
            // return Redirect::back()->withErrors($validator);
            return dataResult($validator,'电话信息错误',0,503);
        }

        $addr = new Addr();

        if($request->has('type')){
            $addr->user_id = $request->input("user_id");
        }else{
            $addr->user_id = $user->id;
        }

        $addr->name = $request->input('name');
        $addr->prov = $request->input('prov');
        $addr->city = $request->input('city');
        $addr->dist = $request->input('dist');
        $addr->address = $request->input('address');
        $addr->code = $request->input('code');
        $addr->tel = $request->input('tel');
        $addr->mobile = $request->input('mobile');
        $addr->is_default = $request->input('is_default');
        //用户的默认地址只有一个
        if($addr->is_default == 1){
            Addr::whereRaw('user_id = ? and is_default = 1',[$addr->user_id])->update(['is_default'=>0]);
        }
        $res = $addr->save();
        if($res){
            return dataResult($res,'保存成功',1,200);
        }
        return dataResult($res,'保存失败',0,503);
    }

    /**
     * 更新地址
     *
     * @param  int  $id
     * @return Response
     */
    public function update(Request $request)
    {
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        $id = $request->id;
        if(empty($id)){
            return dataResult('','地址id不能为空',0,503);
        }

        $addr = Addr::find($id);
        $addr->name = Input::get('name');
        $addr->prov = Input::get('prov');
        $addr->city = Input::get('city');
        $addr->dist = Input::get('dist');
        $addr->address = Input::get('address');
        $addr->tel = Input::get('tel');
        $addr->code = Input::get('code');
        $addr->mobile = Input::get('mobile');
        $addr->email = Input::get('email');
        $addr->is_default = Input::get('is_default');
        //用户的默认地址只有一个
        if($addr->is_default == 1){
            Addr::whereRaw('user_id = ? and is_default = 1 and id != ?',[$addr->user_id,$id])->update(['is_default'=>0]);
        }
        $res = $addr->save();

        if($res){
            return dataResult($res,'更新成功',1,200);
        }
        return dataResult($res,'更新失败',0,503);
    }

    /**
     * 更新地址
     *
     * @param  int  $id
     * @return Response
     */
    public function is_default(Request $request)
    {
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        $id = $request->id;
        if(empty($id)){
            return dataResult('','地址id不能为空',0,503);
        }

        $addr = Addr::find($id);
        $user_id = $addr->user_id;
        Addr::whereRaw('user_id = ? and is_default = 1',[$user_id])->update(['is_default'=>0]);
        $res = Addr::where('id',$id)->update(['is_default'=>1]);
        if($res){
            return dataResult($res,'更新成功',1,200);
        }
        return dataResult($res,'更新失败',0,503);
        
    }

    /**
     * 删除地址
     *
     * @return Response
     */
    public function destroy(Request $request)
    {
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,504);
        }
        $ids = $request->ids;
        if(!is_array($ids)){
            $ids = explode(',',$ids);
        }
        if(empty($ids)){
            return dataResult('','地址id不能为空',0,503);
        }
        if(!empty($ids)){
            $res = 0;
            $res = Addr::destroy($ids);
            if($res){
                return dataResult($res,'删除成功',1,200);
            }
            return dataResult($res,'删除失败',0,503);
        }

        return dataResult('','删除失败',0,503);
    }
}
