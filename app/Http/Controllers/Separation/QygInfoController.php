<?php


namespace App\Http\Controllers\Separation;

use App\Addr;
use App\Area;
use App\Cart;
use App\Cat;
use App\Comment;
use App\Http\Requests;
use App\Invoice;
use App\Partner;
use App\Order;
use App\Pay;
use App\Product;
use App\ProductNew;
use App\Products;
use App\Shipping;
use App\User;
use App\UsersLog;
use App\Footprint;
use App\Coupon;
use App\QygSeckill;
use Carbon\Carbon;
use Auth;
Use DB;
use Illuminate\Http\Request;
use Session;
use Cache;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Wxtemplate;
use App\Models\MemberCoupon;
use App\Models\ClassMenu;
use App\Http\Controllers\Controller;

class QygInfoController extends Controller
{

    //首页轮播图
    public function index_Poster(Request $request)
    {
        $user = auth('api')->user();
        $company_id = 0;
        if(!empty($user)){
            $company_id = $user->company_id;
        }else{
            $company_id = Area::checkAreaToCompany($request->prov,$request->city,$request->dist);
        }
        $poster = array();
        $qyg_imgs = DB::table('qyg_imgs')->where('company_id',$company_id)->where('site_type','webNew')->first();
        if(!empty($qyg_imgs)){
            //海报图
            $poster  = unserialize($qyg_imgs->poster);
            if(empty($poster)){
                $poster = array();
            }
        }

        $data = [];
        $data['poster'] = $poster; 
        foreach ($data['poster'] as $key => $value) {
            $data['poster'][$key]['img'] = config('app.url').$value['img'];
            $data['poster'][$key]['link'] = !empty($value['link'])?$value['link']:'';
            if( empty($data['poster'][$key]['is_show']) ){
                unset($data['poster'][$key]);
            }
        }

        return dataResult($data,'',1,200);
    }
}
