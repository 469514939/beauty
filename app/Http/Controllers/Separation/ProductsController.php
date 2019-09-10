<?php


namespace App\Http\Controllers\Separation;

use App\Http\Requests;
use App\Models\Products;
use App\Users;
use Auth;
Use DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Session;
use Cache;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Support\Facades\Input;

class ProductsController extends Controller
{
    public $apiUser;
    public function __construct()
    {
        $this->apiUser = auth('api')->user();
        if(empty($this->apiUser)){
            echo json_encode(dataResult('','没有用户信息',0,504));
            exit();
        }
    }


    /*商品列表*/
    public function products_list(Request $request){
        $perpage = $request->perpage ?? 10;//每页条数
        $key = $request->key ?? '';//搜索

        $list = Products::where('status',1);
        if(!empty($key)){
            $list->where(function($query)use($key){
                $k = "%".$key."%";
                $query->where('product_name','like',$k);
            });
            $list->with([
                'goods' => function ($query)use($key) {
                    $k = "%".$key."%";
                    $query->orWhere('code','like',$k);
                },
            ]);
        }
        $list = $list->paginate($perpage);
        foreach ($list as $key => $value) {
            $value->img = $value->goods->img;
            $value->mainpic = $value->goods->mainpic;
            $value->code = $value->goods->code;
            unset($value->goods);
        }
        return dataResult($list,'',1,200);
    }

    /*商品详情*/
    public function products_info(Request $request){
        $id = $request->id ?? 0;//

        $info = Products::find($id);
        if(empty($info)){
            return dataResult($info,'暂无商品信息',0,503);
        }

        $value->img = $value->goods->img;
        $value->mainpic = $value->goods->mainpic;
        $value->code = $value->goods->code;
        unset($value->goods);
        return dataResult($info,'',1,200);
    }


}
