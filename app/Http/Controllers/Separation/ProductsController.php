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
        $page = $request->page ?? 10;//每页条数
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
        $list = $list->paginate($page);
        foreach ($list as $key => $value) {
            # code...
        }
        return dataResult($list,'',1,200);
    }

    /*商品详情*/
    public function products_info(Request $request){
        $id = $request->id ?? 10;//每页条数

        $info = Products::find($id);
        return dataResult($info,'',1,200);
    }


    



    //足迹列表
    public function FootPrint_list(Request $request){
        $user = $this->apiUser;
        $key = trim($request->get('key'));
        $cat_id = $request->get('cat_id');
        $search_type = $request->get('search_type');
        $products = DB::table('footprint as fl')
            ->leftJoin('products as p','fl.product_id','=','p.id')
            ->where('fl.user_id',$user->id)
            ->where('fl.updated_at','>',strtotime(Carbon::now()->subMonth(1)->timezone('Asia/Shanghai')->format('Y-m-d H:i:s')))
            ->orderBy('fl.created_at','desc');

        //分类筛选
        if($cat_id){
            $products = $products->where(function($query) use($cat_id){
                $query
                    ->orWhere('p.cat_id',$cat_id)
                    ->orWhere('p.cat_path','like','%'.$cat_id.'%');
            });
        }
        $products = $products->select('fl.*','p.cat_id','p.on_sale','p.code','p.price','p.spec_info','p.img_url','p.name')->paginate(8);
        $pids = $products->pluck('product_id')->toArray();


        //获取开启规格的商品图片
        $p_Object = new Product();
        $spec_img = $p_Object->get_spec_image_list($pids);

        foreach ($spec_img as $key => $value) {
            foreach ($value as $k => $v) {
                foreach ($v as $km => $vm) {
                    if(strpos($vm,'www') === false  && !empty($vm)){
                        $spec_img[$key][$k][$km] = 'http://img2.officemate.cn/'.$vm;
                    }
                }
            }
        }

        $data = array();
        $data['products'] = $products;
        return dataResult($data,'',1,200);
    }

    //批量移除足迹
    public function footPrintBatchDelete(Request $request){
        $cids = $request->cids;
        if(!is_array($cids)){
            $cids = explode(',',$cids);
        }
        $res = DB::table('footprint')->whereIn('id',$cids)->delete();

        if($res){
            return dataResult($res,'删除成功',1,200);
        }
        return dataResult('','删除失败',1,503);
    }
    //移除足迹
    public function footPrintDelete(Request $request){
        $id = $request->cid;
        if(DB::table('footprint')->where('id',$id)->delete()){
            return dataResult('','删除成功',1,200);
        }
        return dataResult('','删除失败',0,503);
    }


}
