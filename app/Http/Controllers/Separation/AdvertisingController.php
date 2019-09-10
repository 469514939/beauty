<?php


namespace App\Http\Controllers\Separation;

use App\Http\Requests;
use App\Models\Advertising;
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

class AdvertisingController extends Controller
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
    public function advertising_list(Request $request){
        $perpage = $request->perpage ?? 10;//每页条数

        $list = Advertising::where('status',1)->orderBy('sort','desc');
        $list = $list->paginate($perpage);
        return dataResult($list,'',1,200);
    }

}
