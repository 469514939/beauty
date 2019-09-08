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
use Auth;
Use DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Session;
use Cache;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Wxtemplate;
use App\Models\MemberCoupon;
use App\Models\ClassMenu;
use App\Http\Controllers\Controller;
use App\Http\Controllers\WechatpayController as WechatpayController;
use App\Http\Controllers\UnionpayController as UnionpayController;
use App\Http\Controllers\AlipayController as AlipayController;
use App\Dingding;
use App\QygSeckill;
use Carbon\Carbon;
use Illuminate\Support\Facades\Input;

class QygController extends Controller
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



    /**购物车****************************************************************************************/
    //购物车列表
    public function cart_list(){
        $user = $this->apiUser;
        
        $carts = Cart::leftjoin('products','cart.product_id','=','products.id')
        ->leftJoin('store as s', function($join) use($user){
                    $join->on('cart.product_id','=','s.pid')->where('s.cid','=',$user->company_id);
                })
        ->leftJoin('qyg_seckill as qs', function($join) use($user){
                    $join->on('cart.product_id','=','qs.product_id')
                    ->where('qs.start_time','<',Carbon::now())
                    ->where('qs.end_time','>',Carbon::now())
                    ->where('qs.company_id','=',$user->company_id);
                })
        ->leftJoin('company_product_list as cpl',function($join) use($user){
               $join->On('cpl.product_id','=','products.id')
                   ->where('group_label','=','qygo')
                   ->where('cpl.company_id','=',$user->company_id);
           })
            ->select('cart.*','products.price as delprice','products.img_url','products.spec_info',
                'products.cat_id','products.on_sale','s.property','qs.price as seckill_price')
            ->where('cart.user_id',$user->id)
            ->where('batch',7)
            ->where('cpl.product_id','>',0)
            ->get();

        $carts_total = $carts->count();
        $pids = $carts->pluck('product_id')->toArray();
        //$pids = implode(',',$pids);

        $company_id = $user->company_id;
        $count_line = DB::table('orders')->where('user_id',$user->id)->where('order_status','=',1)->whereNull('deleted_at')->sum('total');

        //获取开启规格的商品图片
        $p_Object = new Product();
        
        $spec_img = $p_Object->get_spec_image_list($pids);
        // if(empty($spec_img)){
        //     $spec_img = $p_Object->get_spec_image_list2(implode(',',$pids));
        // }
        foreach ($spec_img as $key => $value) {
            foreach ($value as $k => $v) {
                foreach ($v as $km => $vm) {
                    if(strpos($vm,'www') === false  && !empty($vm)){
                        $spec_img[$key][$k][$km] = 'http://img2.officemate.cn/'.$vm;
                    }
                }
            }
        }
        //获取企业购价格
        // $pids = explode(',',$pids);
        $Qygprice = $p_Object->qygoCompanyPriceChoice($pids,$user->company_id);
        //获取分类折扣
        // $cat_ids = $carts->pluck('cat_id')->toArray();
        // $obj_cat = new \App\Cat();
        // $rate = $obj_cat->getDiscount($cat_ids,$company_id,$count_line);

        //将购物车进行标签分类 直营/订购
        $arr = [];
        $total = 0;
        foreach ($carts as $c) {
            $c->qyg_price = isset($Qygprice[$c->product_id])?$Qygprice[$c->product_id]:$c->price;
            if(!empty($c->seckill_price)){
                $c->qyg_price = $c->seckill_price;
            }
            $c->spec_img = isset($spec_img[$c->product_id])?$spec_img[$c->product_id]:array();
            $c->product_total = bcmul($c->qyg_price , $c->number,2);
            if(strpos($c->img_url,'www') === false && !empty($c->img_url)){
                    $c->img_url= 'http://img2.officemate.cn/'.$c->img_url;
                }
            if(empty($c->img_url) && count($c->spec_img)>0){
                $c->img_url = $c->spec_img['s_url'][0];
                if(empty($c->img_url)){
                    $c->img_url = $c->spec_img['url'][0];
                }
            }
            $c->price_new = $c->qyg_price;
            $total = bcadd($total,bcmul($c->qyg_price , $c->number,2),2);
        }
        $data = [];
        $data['carts'] = $carts; 
        $data['carts_total'] = $carts_total;
        $data['total'] = $total;

        return dataResult($data,'',1,200);
    }
    //加入购物车
    public function add_cart(Request $request){
        $hasGoodIds = [];
        $num = [];
        $user = $this->apiUser;
        
        $user_id = $user->id;
        $pids = $request->input('product_id');
        if(!is_array($pids)){
            $pids = explode(',',$pids);
        }
        $pnums = $request->input('product_nums');
        if(!is_array($pnums)){
            $pnums = explode(',',$pnums);
        }

        $carts = Cart::where('user_id',$user_id)->where('batch',7)->select('product_id','number')->get();

        foreach($carts as $c){
            $hasGoodIds[] = $c->product_id;
            $num[$c->product_id] = $c->number;
        }

        if(empty($pids)){
            return dataResult('','商品信息为空',0,503);
        }

        //查询配置值
        $config_switch = DB::table('admin_configs')->leftJoin('admin_config_list as configList', function ($join)use($user){
                   $join->on('admin_configs.id','=','configList.config_id');
                   $join->where('configList.company_id', '=', $user->company_id);
               })->where('admin_configs.code','inventory_show_switch')
            ->select('admin_configs.*','configList.value','configList.id as lid')
            ->first();
        $config_switch = $config_switch?$config_switch->value:0;//是否显示库存

        $obj_pro = new Product();
        $qygStore = $obj_pro->qygoStoreChoice($pids,$user->company_id,$config_switch);

        $obj_pro = new Product();
        $qygoPrice = $obj_pro->qygoPriceChoice($pids,$user->company_id);//价格选取

        $res = 0;
        $total = 0;
        $number = 0;
        foreach($pids as $k => $pid){
            if(in_array($pid,$hasGoodIds)){
                $scnumber = $num[$pid] + $pnums[$k];
            }else{
                $scnumber = $pnums[$k];
            }
            //检查秒杀商品
            $r_sk = QygSeckill::checkBuyNumber($user->company_id,$pid,$user->id,$scnumber);
            if($r_sk == -2){
                $product = ProductNew::find($pid);
                return dataResult('',$product->name.'秒杀商品库存不足',0,503);
            }elseif($r_sk == -3){
                $product = ProductNew::find($pid);
                return dataResult('',$product->name.'购买超过秒杀商品限购量',0,503);
            }elseif($r_sk == -4){
                $product = ProductNew::find($pid);
                return dataResult('',$product->name.'购买需要达到秒杀商品起购量',0,503);
            }


            if($config_switch > 0 && $r_sk == -1){
                if($pnums[$k] > floor($qygStore[$pid])){
                    $carts = new Cart();
                    return dataResult($qygStore[$pid],'库存不足',0,503);
                }
            }


            if(in_array($pid,$hasGoodIds)){
                $number = $num[$pid] + $pnums[$k];
                $res = Cart::where(['user_id'=>$user_id,'batch'=>7,'product_id'=>$pid])->update(['number'=>$number]);
            }else{
                $cart = new Cart();
                $cart->user_id = $user_id;
                $cart->product_id = $pid;
                $cart->number = $pnums[$k];
                $number = $pnums[$k];

                $product = DB::table('products')
                    ->select('code','name','spec_info','img_url','unit')
                    ->where('id',$pid)
                    ->first();

                if(empty($product))continue;
                $cart->code = $product->code;
                $cart->name = $product->name;
                $cart->price = $qygoPrice[$pid];
                $cart->spec_info = $product->spec_info;
                $cart->img_url = $product->img_url;
                $cart->unit = $product->unit;
                $cart->batch = 7;//企业购自主下单
                $res = $cart->save();
            }
            $total  = bcadd($total,bcmul($qygoPrice[$pid] , $number,2),2);
        }
        if($res){
            return dataResult($total,'加入成功',1,200);
        }else{
            return dataResult('','加入失败',0,503);
        }
        
    }

    //批量移除购物车
    public function cartBatchDelete(Request $request){
        $cids = $request->cids;
        if(!is_array($cids)){
            $cids = explode(',',$cids);
        }
        $res = DB::table('cart')->whereIn('id',$cids)->delete();

        if($res){
            return dataResult($res,'删除成功',1,200);
        }
        return dataResult('','删除失败',1,503);
    }
    //移除购物车
    public function cartDelete(Request $request){
        $id = $request->cid;
        if(Cart::destroy($id)){
            return dataResult('','删除成功',1,200);
        }
        return dataResult('','删除失败',0,503);
    }


    /**商品清单****************************************************************************************/
    //清单列表
    public function qingdan_list(Request $request){
        $user = $this->apiUser;
        
        $key = trim($request->get('key'));
        $cat_id = $request->get('cat_id');
        $search_type = $request->get('search_type');
        $products = DB::table('favorite_list as fl')
            ->leftJoin('products as p','fl.product_id','=','p.id')
            ->leftJoin('store as s', function($join) use($user){
                    $join->on('fl.product_id','=','s.pid')->where('s.cid','=',$user->company_id);
                })
            // ->leftJoin('qyg_seckill as qs', function($join) use($user){
            //             $join->on('fl.product_id','=','qs.product_id')
            //             ->where('qs.start_time','<',Carbon::now())
            //             ->where('qs.end_time','>',Carbon::now())
            //             ->where('qs.company_id','=',$user->company_id);
            //         })
            ->where('fl.user_id',$user->id)
            ->orderBy('fl.created_at','desc');

        $num = $products->count();

        //关键字搜索
        if(!empty($key)){
            $key_words = explode(" ",$key);
            $products = $products->where(function ($query) use($key_words,$search_type){
                foreach($key_words as $k=>$v){
                    if(empty($v)){
                        continue;
                    }
                    if(preg_match("/^\d{6}$/", $v)){
                        $query->orWhere('fl.code','like','%'.$v.'%');
                    }elseif($search_type == 1){
                        $content = Product::getSearchResult($v);
                        $ar = $content?explode(",", $content):[];
                        $v = '%'.$v.'%';
                        $query
                            ->orWhereIn('fl.product_id',$ar)
                            ->orWhere('fl.spec_info','like',$v)
                            ->orWhere('fl.name','like',$v)
                            ->orWhere('fl.code','like',$v);
                    }else{
                        $v = '%'.$v.'%';
                        $query->Where('fl.name','like',$v);
                    }
                }
            });
        }

        //分类筛选
        if($cat_id){
            $products = $products->where(function($query) use($cat_id){
                $query
                    ->orWhere('p.cat_id',$cat_id)
                    ->orWhere('p.cat_path','like','%'.$cat_id.'%');
            });
        }
        $products = $products->select('fl.*','p.cat_id','p.on_sale',
                    DB::raw('(case when b2b_s.qygprice>0 then b2b_s.qygprice else b2b_p.price end) as qyg_price') )
                    ->paginate(10);
        
        $pids = $products->pluck('product_id')->toArray();


        //获取开启规格的商品图片
        $p_Object = new Product();
        $spec_img = $p_Object->get_spec_image_list($pids);
        if(empty($spec_img)){
            $spec_img = $p_Object->get_spec_image_list2(implode(',',$pids));
        }
        foreach ($spec_img as $key => $value) {
            foreach ($value as $k => $v) {
                foreach ($v as $km => $vm) {
                    if(strpos($vm,'www') === false && !empty($vm)){
                        $spec_img[$key][$k][$km] = 'http://img2.officemate.cn/'.$vm;
                    }
                }
            }
        }
        if($user){
            $is_add_qd = DB::table('favorite_list')->where('user_id',$user->id)->whereIn('product_id',$pids)->pluck('id','product_id');
        }


        $products->appends(['key'=>$key,'cat_id'=>$cat_id,'search_type'=>$search_type])->links();

        

        foreach ($products as $c) {
            $c->price_new = $c->qyg_price;
            if($c->qyg_price != $c->price ){
              $c->price_old = $c->price;
            }

            if(strpos($c->img_url,'www') === false && !empty($c->img_url)){
                    $c->img_url= 'http://img2.officemate.cn/'.$c->img_url;
                }
            if(empty($c->img_url) && isset($spec_img[$c->product_id])){
                $c->img_url = $spec_img[$c->product_id]['s_url'][0];
                if(empty($c->img_url)){
                    $c->img_url = $spec_img[$c->product_id]['url'][0];
                }
            }
            if(isset($is_add_qd[$c->product_id])){
                $c->in_favorite = 1;
            }else{
                $c->in_favorite = 0;
            }
        }


        $data = [];
        $data['products'] = $products;
        $data['num'] = $num; 
        $data['key'] = $key;

        return dataResult($data,'',1,200);
    }

    //商品清单导出
    public function ExportQingdan(Request $request){
        set_time_limit(0);
        ini_set('memory_limit', '128M');

        $user = $this->apiUser;

        $key = trim($request->get('key'));
        $cat_id = $request->get('cat_id');
        $search_type = $request->get('search_type');
        $products = DB::table('favorite_list as fl')
            ->leftJoin('products as p','fl.product_id','=','p.id')
            ->leftJoin('store as s', function($join) use($user){
                    $join->on('p.id','=','s.pid')->where('s.cid','=',$user->company_id);
                })
            ->where('fl.user_id',$user->id)
            ->orderBy('fl.created_at','desc');

        $num = $products->count();

        //关键字搜索
        if(!empty($key)){
            $key_words = explode(" ",$key);
            $products = $products->where(function ($query) use($key_words,$search_type){
                foreach($key_words as $k=>$v){
                    if(empty($v)){
                        continue;
                    }
                    if(preg_match("/^\d{6}$/", $v)){
                        $query->orWhere('fl.code','like','%'.$v.'%');
                    }elseif($search_type == 1){
                        $content = Product::getSearchResult($v);
                        $ar = $content?explode(",", $content):[];
                        $v = '%'.$v.'%';
                        $query
                            ->orWhereIn('fl.product_id',$ar)
                            ->orWhere('fl.spec_info','like',$v)
                            ->orWhere('fl.name','like',$v)
                            ->orWhere('fl.code','like',$v);
                    }else{
                        $v = '%'.$v.'%';
                        $query->Where('fl.name','like',$v);
                    }
                }
            });
        }

        //分类筛选
        if($cat_id){
            $products = $products->where(function($query) use($cat_id){
                $query
                    ->orWhere('p.cat_id',$cat_id)
                    ->orWhere('p.cat_path','like','%'.$cat_id.'%');
            });
        }
        $products = $products->select('fl.*','p.cat_id','p.on_sale','p.cat',
                    DB::raw('(case when b2b_s.qygprice>0 then b2b_s.qygprice else b2b_p.price end) as qyg_price')
                    )->get();


        $row = [];
        if(!empty($products)){
            foreach($products as $k=>$o){
                $row[] = ['code'=>$o->code,'name'=>$o->name,'spec_info'=>$o->spec_info,'qyg_price'=>$o->qyg_price,'unit'=>$o->unit,'cat_name'=>$o->cat];
            }
        }
        $data['products'] = $row;
        return dataResult($data,'',1,200);

    }

    //商品列表：加入清单
    public function add_qingdan(Request $request){
        $user = $this->apiUser;
        
        $product_id = $request->input('product_id');
        if(!is_array($product_id)){
            $product_id = explode(',',$product_id);
        }
        $user_id = $user->id;
        $newGood = [];
        $len = count($product_id);
        $obj_pro = new Product();
        $qygPrice = $obj_pro->qygoPriceChoice($product_id,$user->company_id);//价格选取

        foreach($product_id as $pid){
            $hasPro = DB::table('favorite_list')->where(['product_id'=>$pid,'user_id'=>$user_id])->count();
            //已添加清单
            if($hasPro){
                if($len == 1){
                    return dataResult('','已添加清单',0,503);
                }else{
                    continue;
                }
            }

            $products = DB::table('products')->find($pid);

            $newGood[] = [
                'user_id'=>$user_id,
                'product_id'=>$pid,
                'number'=> 1,
                'price'=> $qygPrice[$pid],
                'name'=> $products->name,
                'code'=> $products->code,
                'spec_info'=> $products->spec_info,
                'unit'=> $products->unit,
                'img_url'=> $products->img_url,
                'created_at'=>date('Y-m-d H:i:s')
            ];
        }

        $in = DB::table('favorite_list')->insert($newGood);
        if($in){
            return dataResult('','加入成功',1,200);
        }else{
            return dataResult('','加入失败',0,503);
        }
    }

    //清单列表：移除清单商品
    public function favorite_move_out(Request $request)
    {
        $user = $this->apiUser;
        
        $pids = $request->pids;
        if(!is_array($pids)){
            $pids = explode(',',$pids);
        }
        $res = DB::table('favorite_list')->whereIn('product_id',$pids)->where('user_id',$user->id)->delete();

        return dataResult($res,'',1,200);
    }












    /**购物车下单****************************************************************************************/

    //购物车添加商品到订单
    public function setCIds(Request $request){
        $user = $this->apiUser;
        
        if(Session::has('cids'.$user->id)){
            Session::forget('cids'.$user->id);//先清空购物车id，防止重复使用
        }
        $request->session()->put('cids'.$user->id, $request->cids);

        $c_id = Session::get('cids'.$user->id);
        return dataResult($c_id,'',1,200);
    }

    //订单提交页
    public function order_sure(){
        $user = $this->apiUser;
        
        $company_id = $user->company_id;
        //获取配置信息
        $express = DB::table('express')->where('company_id',$company_id)->first();
        $shipping_way = [];
        if(!empty($express)){
            if(!empty($express->express_way)){
                foreach (unserialize($express->express_way) as $key => $value) {//获取子公司定义的运输方式
                    if($value['is_check']){
                        $shipping_way[] = $value['shipping_id'];
                    }
                }
            }
            //物流公司
            if(empty($shipping_way)){
                $ship = Shipping::where('status',1)->where(function($query) use($company_id){
                    if($company_id == 1){
                        $query->whereIn('id',[1,2,3]);
                    }
                })->get();
            }else{
                $ship = Shipping::where('status',1)->whereIn('id',$shipping_way)->get();
            }

            if(!empty($express->pay_way)){
                //支付方式
                $pay_way = [];
                foreach (unserialize($express->pay_way) as $key => $value) {//获取子公司定义的支付方式
                    if($value['is_check']){
                        $pay_way[] = $value['pay_id'];
                    }
                }
            }
            if(empty($pay_way)){
                $pay_way = $user->company_id == 1?[2,5,9]:[2,4,5,9];
            }

            $express->express_way = unserialize($express->express_way);
            $express->express_shipping = unserialize($express->express_shipping);
            $express->pay_way = unserialize($express->pay_way);
        }else{
            $ship = Shipping::where('status',1)->whereIn('id',$shipping_way)->get();
            $pay_way = $user->company_id == 1?[2,5,9]:[2,4,5,9];
        }

        foreach ($ship as $ks => $vs) {
            $vs->is_free = isset($express)?$express->is_free:'1';
            $vs->mustfee = isset($express)?$express->mustfee:'0';
            $vs->fee = isset($express)?$express->express_shipping[$vs->id]['fee']:'0';
        }
        
        if($user->is_mon){
            // $pay_way[] = 3;//是否月结
            $pay_way = array_merge($pay_way,[3]);
        }
        //移除在线
        if(!$user->pay_online){
            foreach( $pay_way as $k=>$v) {
                if(in_array($v,[2,5,9])){
                    unset($pay_way[$k]);
                    }
            }

        }
        $pay = Pay::where('status',1)->whereIn('id',$pay_way)->get();

        //默认物流跟支付
        //获取用户最近一次下单的支付与运送方式
        $lastOrder = Order::where('user_id',$user->id)->orderBy('created_at','desc')->first();
        if(empty($lastOrder)){//默认为月结与自家物流与发票类型
            $payment = 3;
            $shipping = 2;
            $invoice_type=1;
        }else{
            $payment = $lastOrder->payment;
            $shipping = $lastOrder->shipping;
            $invoice_type = $lastOrder->invoice_type;
        }
        if(!in_array($payment,$pay_way)){
            foreach ($pay_way as $kp => $vp) {
                $payment = $vp;
                break;
            }
        }
        if(empty($invoice_type)){
            $invoice_type = 1;
        }
        $invoice_Code = '';
        //普通发票
        if($user->lock_invoice == 0){
            $invoice_title = empty($lastOrder->invoice_title)?$user->invoice_title:$lastOrder->invoice_title;
        }else{//锁定发票抬头
            $invoice_title = $user->invoice_title;
        }
        if(strstr($invoice_title,'|')){
            $tmp = explode('|',$invoice_title);
            if(count($tmp)>=3){
                $invoice_title = $tmp[0];
                $invoice_Code = $tmp[3];
            }
        }
        //增值发票
        if(empty($lastOrder->invoice_id)){
            $invoice = Invoice::where('user_id',$user->id)->first();
        }else{
            $invoice = Invoice::where('id',$lastOrder->invoice_id)->first();
        }

        //发票锁定
        $lock_type = $user->lock_type;

        //发票抬头锁定
        $lock_invoice = $user->lock_invoice;

        //地址
        $addrs = Addr::where('user_id',$user->id);
        if($user->add_addr == 0){
            $addrs = $addrs->where('is_set',1);
        }
        $addrs = $addrs->orderBy('is_default','desc')->get();

        $region = json_decode(@file_get_contents(public_path("/js/cityData.json")), true);
        foreach ($addrs as $ak => $av) {
            $regionName = '';
            $cityName = '';
            $distName = '';
            foreach ($region as $pk => $pv) {
                if( ($pk == $av->prov) ){
                    $regionName = $pv['n'] ;

                    foreach ($pv['s'] as $ck => $cv) {
                        if( ($ck == $av->city) ){
                            $cityName = $cv['n'];

                            foreach ($cv['s'] as $dk => $dv) {
                                if( ($dk == $av->dist) ){
                                    $distName = $dv['n'];
                                }
                            }
                        }
                    }

                }
            }
            $av->longaddress = $regionName.$cityName.$distName.$av->address;
        }
        

        //购物车商品
        $order_goods = DB::table('cart')
            ->leftjoin('products','cart.product_id','=','products.id')
            ->leftJoin('qyg_seckill as qs', function($join) use($user){
                    $join->on('cart.product_id','=','qs.product_id')
                    ->where('qs.start_time','<',Carbon::now())
                    ->where('qs.end_time','>',Carbon::now())
                    ->where('qs.company_id','=',$user->company_id);
                })
            ->select('cart.*','products.cat_id','products.img_url','products.price as delprice','qs.price as seckill_price')
            ->where('cart.user_id',$user->id)
            ->where('cart.batch',7);

        //获取购物车页面已选商品的自增id
        $c_id = Session::get('cids'.$user->id);
        if($c_id){
            $order_goods = $order_goods->whereIn('cart.id',$c_id);
        }
        $total = clone $order_goods;
        // $order_goods = $order_goods->paginate(15);
        $order_goods = $order_goods->get();
        foreach ($order_goods as $c) {
            if(strpos($c->img_url,'www') === false && !empty($c->img_url)){
                    $c->img_url= 'http://img2.officemate.cn/'.$c->img_url;
                }
            $c->subtotal = bcmul($c->number, $c->seckill_price?$c->seckill_price:$c->price, 2);
        }

        if(empty($order_goods)){
            return dataResult('','没有商品信息',0,503);
        }
        //统计
        $pids = $total->pluck('product_id');
        $cat_ids = $total->pluck('cat_id');
        $total = $total->get();

        //判断是否有库存
        //查询配置值
        $config_switch = DB::table('admin_configs')->leftJoin('admin_config_list as configList', function ($join)use($user){
                   $join->on('admin_configs.id','=','configList.config_id');
                   $join->where('configList.company_id', '=', $user->company_id);
               })->where('admin_configs.code','inventory_show_switch')
            ->select('admin_configs.*','configList.value','configList.id as lid')
            ->first();
        $config_switch = $config_switch?$config_switch->value:0;//是否显示库存

        $obj_pro = new Product();
        $qygStore = $obj_pro->qygoStoreChoice($pids,$user->company_id,$config_switch);

        foreach($order_goods as $k => $v){
            if(!empty($v->seckill_price)){
                $v->price = $v->seckill_price;
            }
            //检查秒杀商品
            $r_sk = QygSeckill::checkBuyNumber($user->company_id,$v->product_id,$user->id,$v->number,1);
            if($r_sk == -2){
                return dataResult('',$v->name.'秒杀商品库存不足',0,503);
            }elseif($r_sk == -3){
                return dataResult('',$v->name.'购买超过秒杀商品限购量',0,503);
            }elseif($r_sk == -4){
                return dataResult('',$v->name.'购买需要达到秒杀商品起购量',0,503);
            }
            if($config_switch > 0  && $r_sk == -1){
                if($v->number > floor($qygStore[$v->product_id]) ){
                    return dataResult('',$v->name.'商品库存不足',0,503);
                }
            }
        }


        $total_price = 0;
        $zj = 0;//总价
        $sf = 0;//实付价
        //获取企业购价格
        $p_Object = new Product();
        $qygPrice = $p_Object->qygoPriceChoice($pids,$user->company_id);



        foreach($total as $og){
            $price = isset($qygPrice[$og->product_id])?$qygPrice[$og->product_id]:$og->delprice;
            if(!empty($og->seckill_price)){
                $price = $og->seckill_price;
            }
            $sf += $price*$og->number;
            $zj += $price*$og->number;

            $zj = round($zj,2);
            $sf = round($sf,2);
        }

        //获取开启规格的商品图片
        $spec_img = $p_Object->get_spec_image_list($pids);
        if(empty($spec_img)){
            $spec_img = $p_Object->get_spec_image_list2(implode(',',$pids));
        }
        foreach ($spec_img as $key => $value) {
            foreach ($value as $k => $v) {
                foreach ($v as $km => $vm) {
                    if(strpos($vm,'www') === false && !empty($vm)){
                        $spec_img[$key][$k][$km] = 'http://img2.officemate.cn/'.$vm;
                    }
                }
            }
        }
        foreach($order_goods as $key=>$p){
            if(empty($p->img_url) && isset($spec_img[$p->product_id])){
                $p->img_url = $spec_img[$p->product_id]['s_url'][0];
                if(empty($p->img_url)){
                    $p->img_url = $spec_img[$p->product_id]['url'][0];
                }
            }
        }

        //可用优惠券
        $coupons = DB::table('qyg_member_coupon')
                   ->where('user_id',$user->id)
                   ->where('company_id',$user->company_id)
                   ->where('deleted_at',NULL)
                   ->where('is_used',0)
                   ->where('start_time','<=',date('Y-m-d'))
                   ->where('end_time','>=',date('Y-m-d'))
                   // ->where('money','<=',$zj)
                   ->orderBy('id','desc')->get();
        $coupon_discount = 0;
        foreach ($coupons as $kc => $vc) {
            if($vc->money > $zj){
                $vc->can_user = 0;
            }else{
                $vc->can_user = 1;
            }
        }
        
        $fee = 0;
        foreach ($ship as $sk => $sv) {
            //月结运费为0
            if($shipping == $sv->id && $sv->is_free==0 ){
                if($zj < $vs->mustfee){
                    $fee = $sv->fee;
                }
            }
        }
        // if($payment == 3){
        //     $fee = 0;
        // }
        $fee = (float)$fee;
        $total = $sf+$fee;
        $total = round($total,2);


        $data = [];
        $data['ship'] = $ship;
        $data['pay'] = $pay;
        $data['order_goods'] = ['data'=>$order_goods];
        $data['addrs'] = $addrs;
        $data['invoice'] = $invoice;
        $data['invoice_type'] = $invoice_type;

        $data['invoice_Code'] = $invoice_Code;
        $data['lock_invoice'] = $lock_invoice;
        $data['invoice_title'] = $invoice_title;
        $data['payment'] = $payment;
        $data['shipping'] = $shipping;
        $data['total_price'] = $total_price;
        $data['lock_type'] = $lock_type;
        $data['zj'] = $zj;
        $data['sf'] = $sf;
        $data['shipping_fee'] = $fee;
        $data['total'] = $total;

        // $data['spec_img'] = $spec_img;
        // $data['qygPrice'] = $qygPrice;
        // $data['discount'] = $discount;
        $data['express'] = $express;
        $data['coupons'] = $coupons;
        $data['coupon_discount'] = $coupon_discount;

        unset($total);
        return dataResult($data,'',1,200);
    }

    //订单提交页
    public function order_sure_calculate(Request $request){
        $user = $this->apiUser;
        
        $company_id = $user->company_id;
        $coupon_id = $request->coupon_id;
        $pay_id = $request->pay_id;
        $shipping_id = $request->shipping_id;

        $express = DB::table('express')->where('company_id',$company_id)->first();
        $shipping_way = [];
        if(!empty($express)){
            if(!empty($express->express_way)){
                foreach (unserialize($express->express_way) as $key => $value) {//获取子公司定义的运输方式
                    if($value['is_check']){
                        $shipping_way[] = $value['shipping_id'];
                    }
                }
            }
            //物流公司
            if(empty($shipping_way)){
                $ship = Shipping::where('status',1)->where(function($query) use($company_id){
                    if($company_id == 1){
                        $query->whereIn('id',[1,2,3]);
                    }
                })->get();
            }else{
                $ship = Shipping::where('status',1)->whereIn('id',$shipping_way)->get();
            }

            if(!empty($express->pay_way)){
                //支付方式
                $pay_way = [];
                foreach (unserialize($express->pay_way) as $key => $value) {//获取子公司定义的支付方式
                    if($value['is_check']){
                        $pay_way[] = $value['pay_id'];
                    }
                }
            }
            if(empty($pay_way)){
                $pay_way = $user->company_id == 1?[2,5,9]:[2,4,5,9];
            }

            $express->express_way = unserialize($express->express_way);
            $express->express_shipping = unserialize($express->express_shipping);
            $express->pay_way = unserialize($express->pay_way);
        }else{
            $ship = Shipping::where('status',1)->whereIn('id',$shipping_way)->get();
            $pay_way = $user->company_id == 1?[2,5,9]:[2,4,5,9];
        }

        foreach ($ship as $ks => $vs) {
            $vs->is_free = isset($express)?$express->is_free:'1';
            $vs->mustfee = isset($express)?$express->mustfee:'0';
            $vs->fee = isset($express)?$express->express_shipping[$vs->id]['fee']:'0';
        }
        
        if($user->is_mon){
            // $pay_way[] = 3;//是否月结
            $pay_way = array_merge($pay_way,[3]);
        }

        
        //购物车商品
        $order_goods = DB::table('cart')
            ->leftjoin('products','cart.product_id','=','products.id')
            ->where('cart.user_id',$user->id)
            ->where('cart.batch',7);

        //获取购物车页面已选商品的自增id
        $c_id = Session::get('cids'.$user->id);
        if($c_id){
            $order_goods = $order_goods->whereIn('cart.id',$c_id);
        }
        $total = clone $order_goods;
        $order_goods = $order_goods
                       ->leftJoin('qyg_seckill', function($join) use($user){
                            $join->on('cart.product_id','=','qyg_seckill.product_id')
                            ->where('qyg_seckill.start_time','<',Carbon::now())
                            ->where('qyg_seckill.end_time','>',Carbon::now())
                            ->where('qyg_seckill.company_id','=',$user->company_id);
                        })
                       ->select('cart.*','products.cat_id','products.img_url','qyg_seckill.seckill_id','qyg_seckill.price as seckill_price')
                       ->get();
        //判断是否有秒杀商品，有秒杀商品不能使用优惠券
        $can_useCoupon = 1;
        foreach ($order_goods as $c) {
            if(strpos($c->img_url,'www') === false && !empty($c->img_url)){
                    $c->img_url= 'http://img2.officemate.cn/'.$c->img_url;
                }
            if(!empty($c->seckill_price)){
                $c->price = $c->seckill_price;
            }
            $c->subtotal = bcmul($c->number, $c->seckill_price?$c->seckill_price:$c->price, 2);
            if($c->seckill_id){
                $can_useCoupon = 0;
            }
        }
        $coupons = DB::table('qyg_member_coupon')->where('deleted_at',NULL)->where('start_time','<=',date('Y-m-d'))->where('end_time','>=',date('Y-m-d'))->where('id',$coupon_id)->first();

        if($can_useCoupon){
            //可用优惠券
            if(empty($coupons) && $coupon_id>0){
                return dataResult('','优惠券不可用',0,503);
            }
        }else{
            if(!empty($coupons) && $coupon_id>0){
                return dataResult('','秒杀商品不可用优惠券',0,503);
            }
        }
        

        //统计
        $pids = $total->pluck('product_id');
        $cat_ids = $total->pluck('cat_id');
        // $total = $total->get();
        $total = $order_goods;

        //判断是否有库存
        //查询配置值
        $config_switch = DB::table('admin_configs')->leftJoin('admin_config_list as configList', function ($join)use($user){
                   $join->on('admin_configs.id','=','configList.config_id');
                   $join->where('configList.company_id', '=', $user->company_id);
               })->where('admin_configs.code','inventory_show_switch')
            ->select('admin_configs.*','configList.value','configList.id as lid')
            ->first();
        $config_switch = $config_switch?$config_switch->value:0;//是否显示库存

        $obj_pro = new Product();
        $qygStore = $obj_pro->qygoStoreChoice($pids,$user->company_id,$config_switch);

        foreach($order_goods as $k => $v){
            //检查秒杀商品
            $r_sk = QygSeckill::checkBuyNumber($user->company_id,$v->product_id,$user->id,$v->number,1);
            if($r_sk == -2){
                return dataResult('',$v->name.'秒杀商品库存不足',0,503);
            }elseif($r_sk == -3){
                return dataResult('',$v->name.'购买超过秒杀商品限购量',0,503);
            }elseif($r_sk == -4){
                return dataResult('',$v->name.'购买需要达到秒杀商品起购量',0,503);
            }
            if($config_switch > 0  && $r_sk == -1){
                if($v->number > floor($qygStore[$v->product_id]) ){
                    return dataResult('',$v->name.'商品库存不足',0,503);
                }
            }
        }

        $total_price = 0;
        $zj = 0;//总价
        $sf = 0;//实付价
        //获取企业购价格
        $p_Object = new Product();
        $qygPrice = $p_Object->qygoPriceChoice($pids,$user->company_id);

        $count_line = DB::table('orders')->where('user_id',$user->id)->where('order_status','=',1)->whereNull('deleted_at')->sum('total');
        //获取分类折扣
        $obj_cat = new Cat();
        $discount = $obj_cat->getDiscount($cat_ids,$user->company_id,$count_line);

        foreach($total as $og){
            $price = $qygPrice[$og->product_id];
            if(!empty($og->seckill_price)){
                $price = $og->seckill_price;
            }
            $rate = $discount[$og->cat_id];
            if(empty($og->hyprice) && $rate!=10){
                $sf = bcadd($sf,bcmul($price*$rate/10,$og->number,2),2);
            }else{
                $sf = bcadd($sf,bcmul($price,$og->number,2),2);
            }
            $zj = bcadd($zj,bcmul($price,$og->number,2),2);

        }

        $fee = 0;
        foreach ($ship as $sk => $sv) {
            //月结运费为0
            if($shipping_id == $sv->id && $sv->is_free==0 ){
                if($zj < $vs->mustfee){
                    $fee = $sv->fee;
                }
            }
        }
        // if($pay_id == 3){
        //     $fee = 0;
        // }

        $total = bcadd($sf, $fee, 2);
        //有优惠券
        $coupon_discount = 0;
        if($coupons){
            if($coupons->money <= $sf){
                $total = bcsub($total,$coupons->value,2);
                $coupon_discount = $coupons->value;
            }else{
                return dataResult('','优惠券不可用',0,503);
            }
        }



        $data = [];
        $data['zj'] = $zj;
        $data['sf'] = $sf;
        $data['coupon_discount'] = $coupon_discount;
        $data['shipping_fee'] = $fee;
        $data['total'] = $total;
        // $data['coupons'] = $coupons;

        

        return dataResult($data,'',1,200);
    }

    /**用户信息管理****************************************************************************************/
    //用户信息
    public function personalInfo(){
        $user = $this->apiUser;
        
        if($user->info_name || $user->info_value){
            $info_name = explode(',',$user->info_name);
            $info_value = explode(',',$user->info_value);
        }else{
            $info_name = [];
            $info_value = [];
        }
        // return view('user_new.info',compact('user','info_name','info_value'));

        $data = [];
        $data['user'] = $user;
        $data['info_name'] = $info_name;
        $data['info_value'] = $info_value;
        return dataResult($data,'',1,200);
    }
    //更新用户信息
    public function personalUpdate(Request $request){
        $user = $this->apiUser;
        

        $info_name = !empty($request->info_name)?implode(',',$request->info_name):'';
        $info_value = !empty($request->info_value)?implode(',',$request->info_value):'';

        $usr = User::find($user->id);
        if(empty($usr)){
            return dataResult('','用户不存在',0,503);
        }
        $usr->realname = $request->realname?$request->realname:$usr->realname;
        $usr->sex = $request->sex?$request->sex:$usr->sex;
        $usr->year = $request->year?$request->year:$usr->year;
        $usr->month = $request->month?$request->month:$usr->month;
        $usr->day = $request->day?$request->day:$usr->day;
        
        $usr->prov = $request->prov?$request->prov:$usr->prov;
        $usr->city = $request->city?$request->city:$usr->city;
        $usr->dist = $request->dist?$request->dist:$usr->dist;

        $usr->company_name = $request->company_name?$request->company_name:$usr->company_name;
        $usr->email = $request->email?$request->email:$usr->email;
        $usr->mobile = $request->mobile?$request->mobile:$usr->mobile;
        $usr->info_name = $info_name?$info_name:$usr->info_name;
        $usr->info_value = $info_value?$info_value:$usr->info_value;

        if($usr->save()){
            return dataResult('','保存成功!',1,200);
        }
        return dataResult('','保存失败！',0,503);
    }

    /**订单管理****************************************************************************************/
    //订单列表
    public function order_list(Request $request){
        $user = $this->apiUser;
        
        $skey = trim($request->input('search_key'));
        $order_status = $request->input('order_status');
        $order_from = $request->input('order_from');
        $type = $request->input('type','');
        $start_time = $request->input('start_time','');
        $end_time = $request->input('end_time','');

        $orders = DB::table('orders as o')
            ->leftJoin('users as u','o.user_id','=','u.id')
            ->leftJoin('order_process as p','o.id','=','p.order_id')
            ->select('o.id','o.order_sn','o.created_at','o.mobile','o.order_method','o.total','o.total_good','o.score','o.payment', 'o.order_status',
                'o.pay_status','o.remark','o.user_id as order_user_id','o.org_id','u.user_code','u.company_name','u.name','o.order_from',
                'u.user_id','o.tel','p.examine_remark','p.chioce_id','u.department','u.id as uid',
                'u.max_amount', 'u.max_times','u.price_limit_type','u.times_limit_type');
        $orders = $orders->where('o.user_id',$user->id)->where('o.deleted_at',NULL);//软删除


        switch ($order_from) {
            case 'qyg':
                $orders = $orders->where('order_from',1);
                break;
            case 'b2b':
                $orders = $orders->where('order_from','<>',1);
                break;
            default:
                # code...
                break;
        }

        //统计
        $total = array();
        for($i=0;$i<=5;$i++){
            $total_orders = clone $orders;//复制sql对象
            if($i == 0){
                $total['all'] = $total_orders->count();
            } elseif($i == 1){//待付款
                $total['pay'] = $total_orders->whereIn('payment',[2,5,9])->where('order_status','<>',2)->where('pay_status',0)->count();
            }elseif($i == 2){//待收货（已发货）
                $total['receive'] = $total_orders->where('order_status',2)->count();
            }
            elseif($i == 3){//待自提
                $total['self'] = $total_orders->where('order_status',2)->where('shipping',7)->count();
            }
            elseif($i == 4){//退换货
                $total['return'] = $total_orders->whereIn('order_status',[7,10])->count();;
            }
            elseif($i == 5){//已完成
                $total['success'] = $total_orders->whereIn('order_status',[1,2,9])->count();;
            }
        }

        switch ($type){//代付款；待收货；待自提
            case 'pay':      //代付款
                $orders = $orders->whereIn('payment',[2,5,9])->where('pay_status',0);
                break;
            case 'receive':   //待收货
                $orders = $orders->where('order_status',2)->where('shipping','<>',7);
                break;
            case 'self':      //待自提
                $orders = $orders->where('order_status',2)->where('shipping',7);
                break;
            case 'return':    //退换货
                $orders = $orders->whereIn('order_status',[7,10]);
                break;
            case 'success':    //成功
                $orders = $orders->whereIn('order_status',[1,2,9]);
                break;
           case 'cancel'://已取消
               $orders = $orders->where('order_status',6);
               break;
            default ://全部订单
        }


        //订单搜索
        if(!empty($skey)) {
            $key = explode(" ", $skey);
            $orders->where(function ($query) use ($key) {
                foreach ($key as $k) {
                    if (empty($k)) {
                        continue;
                    }
                    $query
                        ->orWhere('o.id', 'like', '%' . $k . '%')
                        ->orWhere('o.org_id', 'like', '%' . $k . '%');
                }
            });
        }

        //订单ID存入session
        $o_id = [];
        $tempOid = clone $orders;
        $oids = $tempOid->get();
        foreach($oids as $o){
            $o_id[] = $o->id;
        }
        Session::put('o_id',$o_id);

        $orders = $orders->orderBy('o.id','desc')->paginate(10);

        //订单商品种类
        $OrderGood = [];
        $status_arr = Order::getOrderStatusList2();
        foreach($orders as $o){
            $num = DB::table('order_goods')->where('order_id',$o->id)->count();
            $o->order_method = order_way($o->order_method);
            $o->payment_info = order_payment($o->payment);
            if(in_array($o->order_status,[7,10])){
                $o->order_status_info = !isset($status_arr[$o->order_status])?'':$status_arr[$o->order_status];
            }else{
                $o->order_status_info = Order::getQygOrderStatus($o->order_status,$o->pay_status,$o->payment);
            }
            $OrderGood[$o->id] = $num;
            $o->exportDetail = config('app.url').'order/ExportDetail/'.$o->id;
            $o->source = ($o->order_from == 1)?'qyg':'b2b';
            $o->org_id = empty($o->org_id)?$o->id:$o->org_id;
            $o->b2b_url = $user->b2b_url = config('app.switch_url').'md_login/'.lock_url($user->name).'?return_url='.lock_url(config('app.switch_url').'/user/order_detail/'.$o->id);
            // $o->created_at = date('Y-m-d H:i:s',$o->created_at);
        }
        //分页参数
        $orders->appends(['order_status' => $request->input('order_status'),'search_key' => $request->input('search_key')])->links();

        $data = [];
        $data['orders'] = $orders;
        $data['total'] = $total;
        $data['skey'] = $skey;
        $data['start_time'] = $start_time;
        $data['end_time'] = $end_time;
        $data['OrderGood'] = $OrderGood;

        $data['uid'] = $user->id;
        $data['order_status'] = $order_status;


        return dataResult($data,'',1,200);
    }

    /**
     * [order_detail 订单详情]
     * @Author   andy
     * @DateTime 2019-07-15T16:31:29+0800
     * @param    Request                  $request [description]
     * @return   [type]                            [description]
     */
    public function order_detail(Request $request){
        $order_id = $request->order_id;
        $order_detail = DB::table('orders as o')
            ->leftJoin('users as u','o.user_id','=','u.id')
            ->leftJoin('invoice as i','o.user_id','=','i.user_id')
            ->select('o.id', 'o.contact','o.mobile','o.prov','o.city','o.dist','o.address','o.total','o.invoice_type','o.invoice_title','o.remark','o.tel','o.order_method','o.order_status','o.updated_at','o.po_num','o.company_id',
                'o.payment','o.shipping','o.score','u.user_id','o.specify_time','o.org_id','i.company_name','i.tax_code','i.address as iaddr','i.phone','i.bank_name','i.bank_account','o.pay_status',
                'o.logistics_bill','o.logistics_com','o.store_name','o.backtype','o.return_total','o.return_score','o.return_title','o.return_img', 'o.return_remark','o.kemu_id','o.total_price','o.shipping_fee')
            ->where('o.id',$order_id)
            ->first();

        if(empty($order_detail))
            return "订单不存在!";

        //因为要更新发货量信息,所以优先在这里处理
        $order = new Order();
        //物流信息
        // $Logistics = $order->SelfLogistics($order_id, $order_detail->company_id,$order_detail->org_id);
        // $LogisticsUrl = '';
        // if($order_detail->shipping == 3){
        //     $LogisticsUrl = $order->LogisticsFollow($order_detail->logistics_com,$order_detail->logistics_bill);
        // }
        $Logistics = $order->orderTrack($order_detail->org_id);
        
        $order_goods = DB::table('order_goods as og')
            ->leftJoin('products as p','og.product_id','=','p.id')
            ->select('og.code','og.name','og.send_number','og.price','og.point','og.number','og.discount','p.unit','p.cat_id','p.spec_info','p.id')
            ->where('og.order_id',$order_id)
            ->whereNull('og.isreturn')
            ->get();

        //退货商品详情
        $refund_goods = DB::table('order_goods as og')
            ->leftJoin('products as p','og.product_id','=','p.id')
            ->select('og.code','og.name','og.price','og.point','og.number','og.return_number','p.unit','p.cat_id','p.spec_info','p.id')
            ->where('og.order_id',$order_id)
            ->whereNotNull('og.isreturn')
            ->get();

        //退货凭证
        $return_img = $order_detail->return_img;
        $return_img = empty($return_img)?'':explode('|',$return_img);

        $order_detail->order_status_info = Order::getQygOrderStatus($order_detail->order_status,$order_detail->pay_status,$order_detail->payment);
        $order_detail->payment = order_payment($order_detail->payment);
        $order_detail->order_method = order_way($order_detail->order_method);
        $order_detail->invoice_type = invoice_type($order_detail->invoice_type);

        switch ($order_detail->shipping) {
            case 2:
                $order_detail->shipping_way = '办公伙伴配送';
                break;
            case 3:
                $order_detail->shipping_way = '第三方物流';
                break;
            case 7:
                $order_detail->shipping_way = '自提';
                break;

            default:
                $order_detail->shipping_way = '';
                break;
        }
        $order_detail->buy_total = round($order_detail->total-$order_detail->return_total,2);
        $order_detail->buy_total_price = round($order_detail->total_price-$order_detail->return_total,2);

        $order_detail->address = Area::getAddress($order_detail->prov,$order_detail->city,$order_detail->dist,$order_detail->address);

        $hasProcess = false;

        $coupon = DB::table('qyg_order_coupon_user as ocu')->leftJoin('qyg_member_coupon as mp','ocu.coupon_id','=','mp.id')->where('ocu.order_id',$order_id)->select('mp.id','mp.name','mp.value','mp.money','mp.description')->first();

        $data = [];
        $data['order_id'] = $order_id;
        $data['order_detail'] = $order_detail;
        $data['order_goods'] = $order_goods;
        $data['refund_goods'] = $refund_goods;

        $data['hasProcess'] = $hasProcess;
        // $data['choiceName'] = $choiceName;
        $data['Logistics'] = $Logistics;
        // $data['LogisticsUrl'] = $LogisticsUrl;
        $data['return_img'] = $return_img;
        $data['coupon'] = $coupon;

        return dataResult($data,'',1,200);
    }









    //重置密码
    public function resetPassword($id,Request $request){
        if($request->input('role') == 'admin'){
            $rules = [
                'password' => 'required|min:6|confirmed'
            ];

            $validator =  Validator::make($request->all(), $rules);

            if ($validator->fails())
            {
                // return redirect('/admin#sate')->withErrors($validator);
                return dataResult($validator,'修改出错',0,503);
            }

            $admin = Admin::find($id);
            $admin->password = bcrypt($request->input('password'));

            if($admin->save()){
                return dataResult(1,'修改完毕',1,200);
            }
        }elseif($request->input('role') == 'user'){
            $rules = [
                'password' => 'required|min:6|confirmed'
            ];

            $validator =  Validator::make($request->all(), $rules);

            if ($validator->fails())
            {
                // return redirect('/home#sate')->withErrors($validator);
                return dataResult($validator,'修改出错',0,503);
            }

            $user = User::find($id);
            $user->password = bcrypt($request->input('password'));
            if($user->save()){
                return dataResult(1,'修改完毕',1,200);
            }
        }

        return dataResult(1,'',1,200);
    }


    //优惠券列表
    public function coupons_show(Request $request){
        $user = $this->apiUser;
        
        $type = $request->type;
        $totalArr = array();
        $coupons = DB::table('qyg_member_coupon')->where('user_id',$user->id)->where('company_id',$user->company_id)->where('deleted_at',NULL);//软删除

        for($i=0;$i<=2;$i++){
            $total_coupons = clone $coupons;//复制sql对象
            if($i == 0){
                $totalArr['enable'] = $total_coupons->where('is_used',0)->where('end_time','>=',date('Y-m-d'))->count();
            } elseif($i == 1){//待付款
                $totalArr['disable'] = $total_coupons->where('is_used',1)->count();
            }elseif($i == 2){//待收货（已发货）
                $totalArr['overdue'] = $total_coupons->where('end_time','<',date('Y-m-d'))->count();
            }
        }

        switch ($type){//未使用，已使用，过期
            case 'all':      //未使用
                break;
            case 'enable':      //未使用
                $coupons = $coupons->where('is_used',0)->where('end_time','>=',date('Y-m-d'));
                break;
            case 'disable':   //已使用
                $coupons = $coupons->where('is_used',1);
                break;
            case 'overdue':      //过期
                $coupons = $coupons->where('end_time','<',date('Y-m-d'));
                break;
            default ://全部订单
        }



        // $coupons = $coupons->orderBy('id','desc')->paginate(10);

        // //分页参数
        // $coupons->appends(['type'=>$type])->links();
        $coupons = $coupons->orderBy('id','desc')->get();

        $data = [];
        $data['type'] = $type;
        // $data['coupons'] = $coupons;
        $data['coupons']['data'] = $coupons;
        $data['totalArr'] = $totalArr;

        return dataResult($data,'',1,200);

    }


    //商品信息对比
    public function ProductInfoCompare(Request $request)
    {
        $user = $this->apiUser;
        

        $productList = $request->productList;
        $pids = explode(',',$productList);
        if(empty($pids)){
            return dataResult('','请输入商品id',0,503);
        }
        $company_id = $user->company_id;
        $products = DB::table('company_product_list as cpl')
                    ->leftJoin('products as p','p.id','=','cpl.product_id')
                    ->where('cpl.company_id',$company_id)
                    ->where('cpl.group_label','qygo')
                    ->whereIn('p.id',$pids)
                    ->select('p.id','p.img_url','p.price','p.name','cpl.product_id','p.spec_info','p.code','p.cat','p.brand')
                    ->get();

        $pids = array_unique($pids);
        $p_Object = new Product();
        //获取商品企业购价格
        $goodPrice = $p_Object->qygoPriceChoice($pids,$company_id);
        //获取开启规格的商品图片
        $spec_img = $p_Object->get_spec_image_list($pids);
        if(empty($spec_img)){
            $spec_img = $p_Object->get_spec_image_list2(implode(',',$pids));
        }
        foreach ($spec_img as $key => $value) {
            foreach ($value as $k => $v) {
                foreach ($v as $km => $vm) {
                    if(strpos($vm,'www') === false){
                        $spec_img[$key][$k][$km] = 'http://img2.officemate.cn/'.$vm;
                    }
                }
            }
        }

        //图片和价格放进商品数组
        foreach ($products as $key => $value) {
            $products[$key]->spec_image = isset($spec_img[$value->product_id])?$spec_img[$value->product_id]:array();
            if(strpos($products[$key]->img_url,'www') === false){
                    $products[$key]->img_url = 'http://img2.officemate.cn/'.$products[$key]->img_url;
                }
            $products[$key]->qyg_price = isset($goodPrice[$value->product_id])?$goodPrice[$value->product_id]:0;
        }

        $data = [];
        $data[] = $products;


        return dataResult($data,'',1,200);
    }







    //企业购下单，生成订单
    public function submitOrder(Request $request){
        $user = $this->apiUser;
        
        $time = time();
        $start_time   = $request->input('start_time');
        $coupon_id   = $request->input('coupon');
        $specify_time = empty($start_time)?0:strtotime($start_time);
        $addr = Addr::find($request->addr_id);
        $coupon = MemberCoupon::find($coupon_id);

        if($coupon){
            if(strtotime($coupon->start_time) > time()){
                return dataResult('','当前优惠券未到使用时间',0,503);
            }
        }

        //获取购物车已选商品的自增id
        $cids = Session::get('cids'.$user->id);
        $cObject = DB::table('cart')
            ->leftJoin('products','cart.product_id','=','products.id')
            ->leftJoin('qyg_seckill', function($join) use($user){
                            $join->on('cart.product_id','=','qyg_seckill.product_id')
                            ->where('qyg_seckill.start_time','<',Carbon::now())
                            ->where('qyg_seckill.end_time','>',Carbon::now())
                            ->where('qyg_seckill.company_id','=',$user->company_id);
                        })
            ->select('cart.*','products.cat_id','products.price as delprice','qyg_seckill.price as seckill_price')
            ->where('cart.user_id',$user->id)
            ->where('cart.batch',7);//企业购自主下单
        if(!empty($cids)){
            $cObject = $cObject->whereIn('cart.id',$cids);
        }
        $pids = $cObject->pluck('cart.product_id');
        $cat_ids = $cObject->pluck('products.cat_id');
        $cart = $cObject->get();

        // //验证
        if(empty($addr))                       return dataResult('','订单收货地址为空',0,503);
        if(empty($cart))                       return dataResult('','订单的商品为空',0,503);
        if(empty($request->logis))             return dataResult('','配送方式没有选择',0,503);
        if(empty($request->zf))                return dataResult('','支付方式没有选择',0,503);
        if($specify_time&&$specify_time<$time) return dataResult('','指定送货时间不能选择过去',0,503);
        if($addr->dist == 0)                   return dataResult('','订单收货地址3级区域信息不完善',0,503);
        //当选择货到付款时判断子公司区域是否覆盖到该点
        if($request->zf == 4){
            //子公司管理区域
            $cpy_area = User::getCompanyArea($user->company_id);
            $areaIds = array_keys($cpy_area);
            $addr_send = [];
            $addr_send[] = $addr->prov;
            $addr_send[] = $addr->city;
            $addr_send[] = $addr->dist;
            $hasSend=array_intersect($areaIds,$addr_send);
            if(count($hasSend) == 0){
                return dataResult('','该区域暂时不支持货到付款',0,503);
            }
        }



        //生成订单
        $order = new Order();
        $order->user_id       = $user->id;
        $order->company_id    = $user->company_id;
        $order->contact       = $addr->name;
        $order->tel           = $addr->tel;
        $order->mobile        = $addr->mobile;
        $order->prov          = $addr->prov;
        $order->city          = $addr->city;
        $order->dist          = $addr->dist;
        $order->address       = $addr->address;
        $order->is_distribute = 1;//订单是否锁定子公司配送,地址不能更改，只能主帐号或业务员改
        $order->specify_time  =  $specify_time;
        $order->remark        = '快采订单。'.$request->remark;
        $order->sap           = $user->sap;//测试订单
        $order->order_method  = 2;//下单方式：自主下单
        $order->invoice_type  = !empty($request->fp)?$request->fp:0;
        $order->store         = $request->store;//自提门店保存
        $order->store_name    = $request->store_name;
        $order->order_from    = 1;//记录订单来源为企业购订单
        $order->payment       = $request->zf;
        $order->shipping      = $request->logis;
        $order->pay_status    = 0;
        $order->admin_id      = 0;
        $order->created_at    = $time;
        $order->updated_at    = $time;
        $order->ip            = $request->ip();

        //发票保存
        // if($request->fp==3 && !$request->is('mobile/*')){//增值发票保存
        if($request->fp==3){//增值发票保存
            $inv_info = [
                'user_id'      => $user->id,
                'company_name' => preg_replace('/\s/', '',$request->input('unitName')),
                'tax_code'     => preg_replace('/\s/', '',$request->input('invoice_Code')),
                'address'      => preg_replace('/\s/', '',$request->input('regaddr')),
                'phone'        => preg_replace('/\s/', '',$request->input('regtel')),
                'bank_name'    => preg_replace('/\s/', '',$request->input('openAccount')),
                'bank_account' => preg_replace('/\s/', '',$request->input('accountNumber')),
            ];
            if(empty($request->unitName)){
                // return ['status'=>'-13','message'=>'请填写单位名称!'];
                return dataResult('','请填写单位名称',0,503);
            }
            if(empty($request->invoice_Code)){
                // return ['status'=>'-13','message'=>'请填写识别码!'];
                return dataResult('','请填写识别码',0,503);
            }
            if(empty($request->regaddr)){
                // return ['status'=>'-13','message'=>'请输入注册地址!'];
                return dataResult('','请输入注册地址',0,503);
            }
            if(empty($request->regtel)){
                // return ['status'=>'-13','message'=>'请输入电话号码!'];
                return dataResult('','请输入电话号码',0,503);
            }
            if(empty($request->openAccount)){
                // return ['status'=>'-13','message'=>'请输入开户银行!'];
                return dataResult('','请输入开户银行',0,503);
            }
            if(empty($request->accountNumber)){
                // return ['status'=>'-13','message'=>'请输入银行账户!'];
                return dataResult('','请输入银行账户',0,503);
            }

            if(empty($request->input('invoice_id'))){
                $invoice = new Invoice();
                $inv_id  = $invoice -> insertGetId($inv_info);
            }else{
                Invoice::where('id', $request->input('invoice_id'))->update($inv_info);
                $inv_id = $request->input('invoice_id');
            }
            $order->invoice_id = $inv_id;
            if(empty($user->company_name)){
                $user->company_name = $inv_info['company_name'];
                $user->save();
            }
        }elseif($request->fp==2){//普通发票保存
            $invoice_title = preg_replace('/\s/', '',$request->input('invoice_header'));
            $company_name = preg_replace('/\s/', '',$request->input('invoice_header'));
            $invoice_Code  = preg_replace('/\s/', '',$request->input('invoice_Code'));
            $invoice_title = $invoice_title.'|||'.$invoice_Code.'||||';
            $order->invoice_title = $invoice_title;

            if(empty($request->invoice_header)){
                // return ['status'=>'-13','message'=>'请填写发票抬头!'];
                return dataResult('','请填写发票抬头',0,503);
            }
            if(empty($request->invoice_Code)){
                // return ['status'=>'-13','message'=>'请填写纳税人识别码!'];
                return dataResult('','请填写纳税人识别码',0,503);
            }

            if(empty($user->company_name)){
                $user->company_name = $company_name;
                $user->save();
            }
        }


        $inArr = [];
        $total_price = 0;
        $obj_cat = new Cat();
        $obj_pro = new Product();
        
        $count_line = DB::table('orders')->where('user_id',$user->id)->where('order_status','=',1)->whereNull('deleted_at')->sum('total');
        $discont   = $obj_cat->getDiscount($cat_ids,$user->company_id,$count_line);//获取商品折扣


        //查询配置值
        $config_switch = DB::table('admin_configs')->leftJoin('admin_config_list as configList', function ($join)use($user){
                   $join->on('admin_configs.id','=','configList.config_id');
                   $join->where('configList.company_id', '=', $user->company_id);
               })->where('admin_configs.code','inventory_show_switch')
            ->select('admin_configs.*','configList.value','configList.id as lid')
            ->first();

        $config_switch = $config_switch?$config_switch->value:0;//是否显示库存

        $qygPrice = $obj_pro->qygoPriceChoice($pids,$user->company_id);
        $qygStore = $obj_pro->qygoStoreChoice($pids,$user->company_id,$config_switch);

        foreach($cart as $k=>$c){
            //计算商品总价
            // $unit_price = $qygPrice[$c->product_id];
            $unit_price = isset($qygPrice[$c->product_id])?$qygPrice[$c->product_id]:$c->delprice;
            if(!empty($c->seckill_price)){
                $unit_price = $c->seckill_price;
            }
            if($unit_price <= 0){
                // return ['status'=>'-8','message'=>'商品单价为0'];
                return dataResult('','商品单价为0',0,503);
            }
            if($config_switch > 0){
                if($c->number > floor($qygStore[$c->product_id])){
                    return dataResult('',$c->name.'库存为'.floor($qygStore[$c->product_id]).',下单商品数量不能超过库存',0,503);
                }
            }
            

            $rate = $discont[$c->cat_id];
            //$isHy   = DB::table('product_list')->where('product_id',$c->product_id)->where('user_id',$user->id)->where('is_contract',1)->first();
            if($rate!=10){//不是合约商品且设置了折扣
                $total_price += $unit_price*$c->number*$rate/10;
                $unit_price = $unit_price*$rate/10;
            }else{
                $total_price += $unit_price*$c->number;
                $rate = 0;
            }

            //记录商品信息
            $inArr[$k] = [
                'product_id' => $c->product_id,
                'code'       => $c->code,
                'name'       => $c->name,
                'price'      => $unit_price,
                'point'      => $c->score,
                'number'     => $c->number,
                'discount'   => $rate,//折扣
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
            ];
        }

        $express = DB::table('express')->where('company_id',$user->company_id)->first();
        $shipping_fee = 0;
        if(!empty($express) && $express->is_free ==0){
            $mustfee = $express->mustfee;
            if($mustfee>$total_price){
                $shipping_fee = floatval(unserialize($express->express_shipping)[$request->logis]['fee']);
            }else{
                $shipping_fee = 0;
            }
        }
        $order->shipping_fee  = $shipping_fee;

        //使用优惠券
        if($coupon){
            if($coupon->money <= $total_price && $total_price >= $coupon->value){
                $total_price = $total_price - $coupon->value;
            }
        }

        $order->total = $total_price + $shipping_fee;
        $order->total_price = $total_price;

        $partner_id = $user->partner_id;
        $partner = Partner::find($partner_id);
        $yj_vip = $user->vip;//超级月结权限


        $order->partner_id = $partner_id;
//        $order->order_status = 3; //审批通过(无需审批)
//        $order->examined_at  = time();//保存审批通过时间
        $order->order_status = 5;//设置待审核状态

        if($order->save()){
            $i = 0;
            //保存订单商品
            foreach($inArr as $k=>$v){
                $inArr[$k]['order_id'] = $order->id;
                $i++;
            }
            DB::table("order_goods")->insert($inArr);
            
            $order->total_good = $i;
            $order->save();

            //统计用户下单信息
            Order::UpdateUserOrderCount($user->id);

            //修改优惠券状态
            if($coupon){
                $coupon->is_used = 1;
                $coupon->used_times = $coupon->used_times+1;
                $coupon->save();

                $arr = array();
                $arr['order_id'] = $order->id;
                $arr['coupon_id'] = $coupon->id;
                $arr['coupon_name'] = $order->name;
                $arr['usetime'] = date('Y-m-d H:i:s');
                DB::table('qyg_order_coupon_user')->insert($arr);
            }

            //添加操作记录
            $users_log = new UsersLog();
            $users_log->op_id   = $user->id;
            $users_log->op_name = $user->name;
            $users_log->op_type = '自主下单';
            $users_log->module  = 'orders';
            $users_log->ip      = $request->ip();
            $users_log->alttime = time();
            $users_log->remark  = '自主下单成功，订单id:'.$order->id;
            $users_log->parm    = serialize($request->all());
            $users_log->save();

            
        }

        //清空购物车
        $cObject->delete();

        //企业购无需审核订单,直接转存
        $order->trans($order->id,2);

        $order = Order::find($order->id);
        if($order->payment == 3 || $order->payment == 4){
                //发送微信模板消息
                $temdata = [];
                $templateid = '179OLjZbMTlS_u8BEAh6Q9Rn6fKYHrROVdNEDi3ZNF4';//下单成功通知
                $uid = $order->user_id;
                $temdata['first'] = '尊敬的用户，您的订单下单成功';
                $temdata['keyword1'] = $order->org_id;
                $temdata['keyword2'] = $order->total;
                $temdata['keyword3'] = Pay::getPaymentName($order->payment);
                $temdata['remark'] = '感谢您的支持，请注意查收';
                $temdata['uid'] = $uid;
                $temdata['templateid'] = $templateid;
                $temdata['url'] = url('/mobile/personal');
                http_post(url('/wechat/senWxtemplate'),$temdata);

                foreach ($inArr as $key => $value) {
                    if($order->group_activity_id){
                        //拼团订单
                        Order::change_pt_virtual_store($value['product_id'],$user->company_id,$value['number'],$order->id);
                    }else{
                        Order::change_virtual_store($value['product_id'],$user->company_id,$value['number'],$order->id);
                        }
                }
                
            }
        unset($inArr);
        $data = array();
        $data['order_id'] = $order->id;
        return dataResult($data,'订单提交成功!请及时完成支付。',1,200);
    }


    //修改下单页时候的商品数量
    public function changeNumber(Request $request){
        $user = $this->apiUser;
        
        $res = Cart::where('id',$request->id)->update(['number'=>$request->number]);
        if($res){
            return dataResult($res,'修改成功',1,200);
        }
        return dataResult($res,'修改失败',0,503);
    }


    //取消订单
    public function ordercancel(Request $request){
        $user = $this->apiUser;
        
        $id = $request->order_id;
        $order = DB::table('orders')->where('id',$id)->select('user_id','order_status')->first();
        if(empty($order)){
            return dataResult('','订单不存在',0,503);
        }
        $order_status = $order->order_status;
        if($order_status == 2 || $order_status == 12){//发货了，不能再点取消订单；
            return dataResult('','不能再点取消订单',0,503);
        }else{
            $coupon = DB::table('qyg_order_coupon_user')->where('order_id',$id)->first();
            //取消订单优惠券可以继续使用
            if($coupon){
                DB::table('qyg_member_coupon')->where('id',$coupon->coupon_id)->update(['is_used'=>0]);
            }
            
            Order::where('id',$id)->update(['order_status'=>6,'updated_at'=>time()]);
            //更新用户下单信息
            Order::UpdateUserOrderCount($order->user_id);

            //添加操作记录
            $users_log = new UsersLog();
            $users_log->op_id = $user->id;
            $users_log->op_name = $user->name;
            $users_log->op_type = '取消订单';
            $users_log->module = 'orders';
            $users_log->ip = $_SERVER['SERVER_ADDR'];
            $users_log->alttime = time();
            $users_log->remark = '取消订单成功，订单Id：'.$id;
            $users_log->parm = serialize(Input::all());
            $users_log->save();

            //发送钉钉信息
            Dingding::cancelOrderSendDDMesage($id);

            return dataResult('','取消成功',1,200);
        }
    }


    //确认收货
    public function delivSure(Request $request){
        $user = $this->apiUser;
        
        $id = $request->order_id;
        $bool = Order::where('id','=',$id)->update([
            // 'deliver_sure'=>2,
            'order_status'=>9,
            'updated_at'=>time(),
            'received_at'=>time()
        ]);
        if($bool){

            //添加操作记录
            $users_log = new UsersLog();
            $users_log->op_id = $user->id;
            $users_log->op_name = $user->name;
            $users_log->op_type = '确认收货';
            $users_log->module = 'order';
            $users_log->ip = $_SERVER['SERVER_ADDR'];
            $users_log->alttime = time();
            $users_log->remark = '确认收货，订单ID：'.$id;
            $users_log->parm = serialize(Input::all());
            $users_log->save();

            return dataResult('','收货成功',1,200);
        }else{
            $msg['code'] = 0;
            $msg['message'] = "收货失败";
            return dataResult('','收货失败',0,503);
        }
        return dataResult('','收货失败',0,503);
    }

    //删除订单
    public function deleteOrder(Request $request){
        $user = $this->apiUser;
        
        $id = $request->order_id;
        $bool = Order::destroy($id);
        if($bool){
            //添加操作记录
            $users_log = new UsersLog();
            $users_log->op_id = $user->id;
            $users_log->op_name = $user->name;
            $users_log->op_type = '删除订单';
            $users_log->module = 'order';
            $users_log->ip = $_SERVER['SERVER_ADDR'];
            $users_log->alttime = time();
            $users_log->remark = '执行了删除订单操作，订单ID：'.$id;
            $users_log->parm = serialize(Input::all());
            $users_log->save();
            return dataResult('','删除成功',1,200);
        }else{
            return dataResult('','删除失败',0,503);
        }
        return dataResult('','删除失败',0,503);
    }

    //恢复已删除订单
    public function orderRestore(Request $request){
        $user = $this->apiUser;

        $id = $request->order_id;
        $order = DB::table('orders')->where('id',$id)->select('user_id','order_status')->first();
        if(empty($order)){
            return dataResult('','订单不存在',0,503);
        }
        $bool = DB::table('orders')->where('id','=',$id)->update(['updated_at'=>time(),'deleted_at'=>null]);
        if($bool){
            //添加操作记录
            $users_log = new UsersLog();
            $users_log->op_id = $user->id;
            $users_log->op_name = $user->name;
            $users_log->op_type = '恢复删除订单';
            $users_log->module = 'order';
            $users_log->ip = $_SERVER['SERVER_ADDR'];
            $users_log->alttime = time();
            $users_log->remark = '执行了恢复删除订单操作，订单ID：'.$id;
            $users_log->parm = serialize(Input::all());
            $users_log->save();
            return dataResult('','恢复成功',1,200);
        }else{
            return dataResult('','恢复失败',0,503);
        }
        return dataResult('','恢复失败',0,503);
    }


    //完成订单
    public function finishOrder(Request $request){
        $id = $request->order_id;
        $bool = Order::where('id','=',$id)->update(['order_status'=>1,'updated_at'=>time(),'finished_at'=>time()]);

        $order_from = Order::find($id)->order_from;
        if($bool && $order_from == 2){//国网订单投妥
            $logistics_bill = current(DB::table('orders')->where('org_id',$id)->pluck('logistics_bill'));
            if(empty($logistics_bill)){
                return -2;//未发货或发货单号为空
            }
            $api = new ApiGWSC();
            $res = $api->signedInfoReceipt($id,$logistics_bill,3);

            if($res['resultCode'] == '00'){
                $update = [
                    'status' => 'finish',
                ];
                DB::connection('mysql_ecstore')->table('sdb_b2c_orders')->where('order_id',$id)->update($update);
            }
        }

        if($bool){
            $op_user = Auth::guard('admin')->user();
            //添加操作记录
            $users_log = new UsersLog();
            $users_log->op_id = $op_user->id;
            $users_log->op_name = $op_user->name;
            $users_log->op_type = '订单管理';
            $users_log->module = 'order';
            $users_log->ip = $_SERVER['SERVER_ADDR'];
            $users_log->alttime = time();
            $users_log->remark = '执行了完成订单的操作，订单id：'.$id;
            $users_log->parm = serialize(Input::all());
            $users_log->save();

            return dataResult('','完成订单成功',1,200);
        }else{
            return dataResult('','完成订单失败',0,503);
        }

        return dataResult('','完成订单失败',0,503);
    }


    //订单退款退货
    public function refund_show(Request $request){
        $order_id = $request->order_id;
        $order_detail = DB::table('orders')
            ->where('id',$order_id)
            ->select('id','contact','order_method','created_at','payment','total_price','org_id')
            ->first();
        $order_goods = DB::table('order_goods as og')
            ->leftJoin('products as p','og.product_id','=','p.id')
            ->select('og.price','og.point','og.number','og.product_id','p.code','p.name','p.unit','p.spec_info')
            ->where('og.order_id',$order_id)
            ->get();
        $coupon = DB::table('qyg_order_coupon_user as qocu')
            ->leftJoin('qyg_member_coupon as qmc','qocu.coupon_id','=','qmc.id')
            ->where('qocu.order_id',$order_id)
            ->first();

//        $order_detail->created_at = date('Y-m-d H:i:s',$order_detail->created_at);
        $order_detail->payment = order_payment($order_detail->payment);
        $order_detail->org_id = empty($order_detail->id)?$order_detail->id:$order_detail->org_id;
        $data = [];

        $orderMethod = Order::getOrderMethod();//下单方式
        $paymentStatus = Order::getOrderPayment();//支付方式

        $order_detail = json_decode(json_encode($order_detail),true);

        $order_detail['paymentTxt'] = empty($paymentStatus[$order_detail['payment']]) ? '--' : $paymentStatus[$order_detail['payment']];
        $order_detail['orderMethodTxt'] = empty($orderMethod[$order_detail['order_method']]) ? '--' : $orderMethod[$order_detail['order_method']];
        $order_detail['created_at'] = Carbon::createFromTimestamp($order_detail['created_at'])
            ->toDateTimeString();

        foreach ($order_goods as $k => $order_good){
            $order_goods[$k]->spec_info = !empty($order_good->spec_info) ? $order_good->spec_info : '';
            $order_goods[$k]->totalPrice = floatval($order_good->price * $order_good->number);
        }

        $data['order_detail'] = $order_detail;
        $data['order_goods'] = $order_goods;
        $data['order_id'] = $order_id;
        $data['coupon'] = !empty($coupon) ? $coupon : [];
        return dataResult($data,'',1,200);
    }

    //退货退款
    public function refund(Request $request){
        $imgs = $request->input('rimg');
        $drawback = $request->input('drawback');
        $oid = $request->input('order_id');
        $pids = $request->input('product_id');
        if(!is_array($pids)){
            $pids = explode(',',$pids);
        }
        $total = 0;
        $saveImg = '';
        if($drawback && empty($pids)){
            return dataResult('','请选择退款商品',0,503);
        }
        //计算退款金额
        $goods = DB::table('order_goods')->where('order_id',$oid)->select('price','number');
        if($drawback){//部分退款
            $goods = $goods->whereIn('product_id',$pids);
        }
        $goods = $goods->get();

        //优惠券
        $coupon = DB::table('qyg_order_coupon_user as qocu')
        ->leftJoin('qyg_member_coupon as qmc','qocu.coupon_id','=','qmc.id')
        ->where('qocu.order_id',$oid)
        ->first();

        //详情
        $order_detail = DB::table('orders')
        ->where('id',$oid)
        ->select('contact','order_method','created_at','payment','total_price')
        ->first();

        //上传图片
        $format = ['gif','jpg','png','bmp'];
        $fileName = date('Ymd');
        if(!empty($imgs)){
            $base64 = explode(',', $imgs); ;
            $imgs = base64_decode($base64[1]);

            $extension = 'png';

            $imgName = time() . $oid . '.' . $extension;
            Storage::disk("refund")->put('uploads/' . $fileName . '/' . $imgName,$imgs);
            $saveImg .= 'uploads/' .$fileName . '/' . $imgName . '|';
        }

        //统计退回总额
        foreach ($goods as $g) {
            $total += $g->price*$g->number;
        }
        if($coupon && $order_detail){
            $total = $total * ($order_detail->total_price/($order_detail->total_price+$coupon->value));
        }
        $upArr=[
            'order_status'=>7,
            'return_title'=>$request->input('return_title'),
            'return_remark'=>$request->input('return_remark'),
            'return_img'=>$saveImg,
            'backtype'=>$drawback,
            'updated_at'=>time(),
            'return_total'=>$total
        ];

        //保存退货订单
        Db::beginTransaction();
        $order = Order::where('id',$oid)->update($upArr);
        if($order){
            //保存退货清单
            $err_msg = '';
            if (is_array($pids)){
                foreach ($pids as $pid){
                    $num = DB::table('order_goods')->where('order_id',$oid)->where('product_id',$pid)->value('number');
                    $res = DB::table('order_goods')
                        ->where('order_id',$oid)
                        ->where('product_id',$pid)
                        ->update(['isreturn'=>0,'return_number'=>$num]);
                    if(!$res){
                        $err_msg .= $pid.',';
                    }
                }
            }

            if(!empty($err_msg)){
                DB::rollBack();
                return dataResult('','退货物品:'.$err_msg.'保存失败',0,503);
            }else{
                DB::commit();
                //发送钉钉信息
                Dingding::returnOrderSendDDMesage($oid);

                //发送微信模板消息
                $order = Order::find($oid);
                $temdata = [];
                $templateid = 'Tvi9KICEC5esx9yJgZY7JCPtdtgv6hxxWlMQcpXj3kA';//退款申请通知
                $uid = $order->user_id;
                $temdata['first'] = '尊敬的用户，您的订单已经操作退货申请';
                $temdata['keyword1'] = $order->org_id;
                $temdata['keyword2'] = $total;
                $temdata['remark'] = '感谢您的支持，如有任何疑问请与在线客服联系';
                $temdata['uid'] = $uid;
                $temdata['templateid'] = $templateid;
                $temdata['url'] = url('/mobile/personal');
                http_post(url('/wechat/senWxtemplate'),$temdata);

                return dataResult('','已提交退货单',1,200);

            }
        }else{
            return dataResult('','提交退货单失败',0,503);
        }
    }

    //检查待支付订单是否有已下架商品
    function checkOrderOnsale(Request $request){
        $user = $this->apiUser;
        
        $order_id = $request->order_id;
        $order_goods = DB::table('order_goods as og')
            ->leftJoin('products as p','og.product_id','=','p.id')
            ->leftJoin('company_product_list as cpl',function($join) use($user){
               $join->On('cpl.product_id','=','p.id')
                   ->where('group_label','=','qygo')
                   ->where('cpl.company_id','=',$user->company_id);
           })
            ->select('og.code','og.name','og.send_number','og.price','og.point','og.number','og.discount','p.unit','og.number','p.spec_info','p.on_sale','cpl.company_id')
            ->where('og.order_id',$order_id)
            ->whereNull('og.isreturn')
            ->get();
        $data['canSale'] = 1;
        $data['checkStatus'] = 1;
        $products = array();
        foreach ($order_goods as $key => $value) {
            if($value->on_sale == "false" || empty($value->company_id)){
                $data['canSale'] = 0;
                $product['name'] = $value->name;
                $product['code'] = $value->code;
                $product['on_sale'] = $value->on_sale;
                array_push($products, $product);
            }
        }
        $data['products'] = $products;
        if($order->group_activity_id){
            //拼团订单
            $res = Order::check_pt_virtual_store($order_id);
        }else{
            $res = Order::check_virtual_store($order_id);
        }
        $data['checkInfo'] = $res;
        if(!empty($res)){
            $data['checkStatus'] = 0;
            $data['canSale'] = 0;
        }
        return dataResult($data,'',$data['canSale'],200);
    }

    //判断是否支付成功
    public function is_paid(Request $request){
        $body = $request->order_no;
        $payment = $request->payment;
        $status = 0;
        $error = 200;
        if($payment == 5){//微信
            $status = DB::table('wechat_pay_log')->where('status',1)->where('body',$body)->value('status');
        }elseif($payment == 2){//支付宝
            $status =DB::table('alipay_log')->where('status',1)->where('order_id',$body)->value('status');
        }elseif($payment == 9){//银联
            $status =DB::table('unionpay_log')->where('status',1)->where('order_id',$body)->value('status');
        }
        if(empty($status)){
            $status = 0;
            $error = 503;
        }
        
        return dataResult($status,$body,$status,$error);
    }

    //在线支付
    public function to_pay(Request $request){
        $order_id = $request->order_id;
        $user_id = $request->user_id;
        $return_url = $request->return_url;
        $order_detail = DB::table('orders')
            ->where('id',$order_id)
            ->select('contact','order_method','created_at','payment','total_price')
            ->first();
        if(empty($order_detail)){
            return dataResult('','不存在订单',0,503);
        }
        if(!in_array($order_detail->payment,[2,5,9])){
            return dataResult('','不是在线支付订单',0,503);
        }
        Session::put('return_url'.$order_id,$return_url);
        $status = 0;
        if($order_detail->payment == 5){//微信
            return WechatpayController::pay_api($request);
        }elseif($order_detail->payment == 2){//支付宝
            return AlipayController::pay_api($request);
        }elseif($order_detail->payment == 9){//银联
            return UnionpayController::pay_api($request);
        }
        return dataResult('','请求失败',0,503);
    }

    /**
     * [uploadUserImg 上传用户头像]
     * @Author   andy
     * @DateTime 2019-06-10T16:33:29+0800
     * @param    Request                  $request [description]
     * @return   [type]                            [description]
     */
    public function uploadUserImg(Request $request)
    {
        $user = $this->apiUser;
        $img = $request->img;

        $img_path = base64_image_content($img,'qyg/poster');
        if($img_path){//新的图片
            $imgpath = $user->imgpath;
            if(file_exists($imgpath)){//删除旧图
                unlink($imgpath);
            }
            $up_arr = [
                'imgpath'=>$img_path,
            ];
            $res = DB::table('users')->where('id',$user->id)->update($up_arr);
            return dataResult('','上传成功',1,200);
        }

        return dataResult('','请求失败',0,503);
    }


    //订单详情导出
    public function ExportDetail(Request $request){
        $user = $this->apiUser;
        set_time_limit(0);
        ini_set('memory_limit', '128M');

        if(!empty($request->input('ids'))){//多选
            $order_id = $request->input('ids');
        }else if($request->order_id){//单选
            $order_id = (array)$request->order_id;
        }else{//筛选或不选
            $order_id = Session::get('o_id');
        }
        $row = array();
        $row2 = array();
        $data = array();
        $order_detail = DB::table('order_goods as og')
            ->leftJoin('orders as o', 'og.order_id', '=', 'o.id')
            ->leftJoin('products as p', 'og.product_id', '=', 'p.id')
            ->leftJoin('users as u', 'o.user_id', '=', 'u.id')
            ->select('o.org_id','og.id','o.created_at','og.code', 'og.name as g_name', 'p.unit','p.spec_info','og.price', 'og.number',
                'og.send_number','og.return_number', 'og.point', 'og.number','u.user_code','u.name','u.company_name','o.prov','o.city','o.dist',
                'o.address','o.specify_time','o.contact','og.isreturn','o.order_status');
        if(!empty($order_id)){
            $order_detail = $order_detail->whereIn('o.id', $order_id);
        }else{
            $order_detail = $order_detail->where('o.user_id', $user->id);
        }


        //订货
        $o_goods = clone $order_detail;
        $o_goods = $o_goods->whereNull('og.isreturn')->get();
        //退货
        $r_goods = clone $order_detail;
        $r_goods = $r_goods->whereNotNull('og.isreturn')->get();


        if(!empty($o_goods)){
            $dinghuo = ['订单号','订单时间','商品编码','商品名称','商品单位','商品规格','价格','订单数量','发货数量','小计金额','客户编码','收货人','收货地址','送达时间','公司名称','用户名'];
            foreach($o_goods as $k=>$o){
                $o_id = empty($o->org_id)?$o->id:$o->org_id;
                $address=Area::getAddress($o->prov,$o->city,$o->dist,$o->address);
                $c_time = date('Y-m-d H:i',$o->created_at);
                $specify_time = !empty($o->specify_time) ? date('Y-m-d H:i',$o->specify_time) : '';
                $user_code = $o->user_code;
                $contact = $o->contact;
                $company_name =  $o->company_name;
                $name = $o->name;
                $price=$o->price;
                $total=$price*$o->number;
                $good_name = $o->g_name;
                $unit = $o->unit;
                $spec_info = $o->spec_info;
                $row[] = ['order_id'=>$o_id,'created_at'=>$c_time,'good_code'=>$o->code,'good_name'=>$good_name,'unit'=>$unit,'spec_info'=>$spec_info,'price'=>$price, 'number'=>$o->number,'send_number'=>$o->send_number,'price'=>$total,'user_code'=>$user_code,'contact'=>$contact,'address'=>$address,'specify_time'=>$specify_time,'company_name'=>$company_name,'user_name'=>$name];
            }
        }

        if(!empty($r_goods)){
            $tuihuo=   ['订单号','订单时间','商品编码','商品名称','商品单位','商品规格','价格','订单数量','退货数量','小计金额','客户编码','退货人','地址','公司名称','会员用户名'];
            foreach($r_goods as $k=>$o){
                $o_id = empty($o->org_id)?$o->id:$o->org_id;
                $address=Area::getAddress($o->prov,$o->city,$o->dist,$o->address);
                $c_time = date('Y-m-d H:i',$o->created_at);
                $user_code = $o->user_code;
                $contact = $o->contact;
                $company_name = $o->company_name;
                $name = $o->name;
                $price=$o->price;
                $total=$price*$o->number;
                $good_name = $o->g_name;
                $unit = $o->unit;
                $spec_info = $o->spec_info;

                $row2[] = ['order_id'=>$o_id,'created_at'=>$c_time,'good_code'=>$o->code,'good_name'=>$good_name,'unit'=>$unit,'spec_info'=>$spec_info,'price'=>$price, 'number'=>$o->number,'return_number'=>$o->return_number,'total'=>$total,'user_code'=>$user_code,'contact'=>$contact,'address'=>$address, 'company_name'=>$company_name,'user_name'=>$name];
            }
        }
        $data['dinghuo'] = $row;
        $data['tuihuo'] = $row2;
        return dataResult($data,'',1,200);
    }


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
       // $pids = implode(',',$pids);

        $Qygprice = Product::getQygpriceOnLoadByPid($user->company_id,$pids);

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

        foreach ($products as $key => $c) {
            $c->price_new = isset($Qygprice[$c->code])?$Qygprice[$c->code]:$c->price;
            $c->spec_img = isset($spec_img[$c->product_id])?$spec_img[$c->product_id]:array();
            if(strpos($c->img_url,'www') === false && !empty($c->img_url)){
                    $c->img_url= 'http://img2.officemate.cn/'.$c->img_url;
                }
            if(empty($c->img_url) && count($c->spec_img)>0){
                $c->img_url = $c->spec_img['s_url'][0];
                if(empty($c->img_url)){
                    $c->img_url = $c->spec_img['url'][0];
                }
            }
        }



        $data = array();
        $data['products'] = $products;
        return dataResult($data,'',1,200);
    }

    //批量移除购物车
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
    //移除购物车
    public function footPrintDelete(Request $request){
        $id = $request->cid;
        if(DB::table('footprint')->where('id',$id)->delete()){
            return dataResult('','删除成功',1,200);
        }
        return dataResult('','删除失败',0,503);
    }



    /**
     * [order_has_del_list 已删除订单列表]
     * @Author   andy
     * @DateTime 2019-07-15T16:32:40+0800
     * @param    Request                  $request [description]
     * @return   [type]                            [description]
     */
    public function order_has_del_list(Request $request){
        $user = $this->apiUser;

        $skey = trim($request->input('search_key'));
        $order_status = $request->input('order_status');
        $type = $request->input('type','');
        $start_time = $request->input('start_time','');
        $end_time = $request->input('end_time','');

        $orders = DB::table('orders as o')
            ->leftJoin('users as u','o.user_id','=','u.id')
            ->leftJoin('order_process as p','o.id','=','p.order_id')
            ->select('o.id','o.order_sn','o.created_at','o.mobile','o.order_method','o.total','o.total_good','o.score','o.payment', 'o.order_status',
                'o.pay_status','o.remark','o.user_id as order_user_id','o.org_id','u.user_code','u.company_name','u.name',
                'u.user_id','o.tel','p.examine_remark','p.chioce_id','u.department','u.id as uid',
                'u.max_amount', 'u.max_times','u.price_limit_type','u.times_limit_type');
        $orders = $orders->where('o.user_id',$user->id)->whereNotNull('o.deleted_at');//软删除

        //统计
        $total = array();
        for($i=0;$i<=5;$i++){
            $total_orders = clone $orders;//复制sql对象
            if($i == 0){
                $total['all'] = $total_orders->count();
            } elseif($i == 1){//待付款
                $total['pay'] = $total_orders->whereIn('payment',[2,5,9])->where('order_status','<>',2)->where('pay_status',0)->count();
            }elseif($i == 2){//待收货（已发货）
                $total['receive'] = $total_orders->where('order_status',2)->count();
            }
            elseif($i == 3){//待自提
                $total['self'] = $total_orders->where('order_status',2)->where('shipping',7)->count();
            }
            elseif($i == 4){//退换货
                $total['return'] = $total_orders->whereIn('order_status',[7,10])->count();;
            }
            elseif($i == 5){//已完成
                $total['success'] = $total_orders->whereIn('order_status',[1,2,9])->count();;
            }
        }

        switch ($type){//代付款；待收货；待自提
            case 'pay':      //代付款
                $orders = $orders->whereIn('payment',[2,5,9])->where('pay_status',0);
                break;
            case 'receive':   //待收货
                $orders = $orders->where('order_status',2)->where('shipping','<>',7);
                break;
            case 'self':      //待自提
                $orders = $orders->where('order_status',2)->where('shipping',7);
                break;
            case 'return':    //退换货
                $orders = $orders->whereIn('order_status',[7,10]);
                break;
            case 'success':    //成功
                $orders = $orders->whereIn('order_status',[1,2,9]);
                break;
           case 'cancel'://已取消
               $orders = $orders->where('order_status',6);
               break;
            default ://全部订单
        }

        //订单搜索
        if(!empty($skey)) {
            $key = explode(" ", $skey);
            $orders->where(function ($query) use ($key) {
                foreach ($key as $k) {
                    if (empty($k)) {
                        continue;
                    }
                    $query
                        ->orWhere('o.id', 'like', '%' . $k . '%')
                        ->orWhere('o.org_id', 'like', '%' . $k . '%');
                }
            });
        }

        //订单ID存入session
        $o_id = [];
        $tempOid = clone $orders;
        $oids = $tempOid->get();
        foreach($oids as $o){
            $o_id[] = $o->id;
        }
        Session::put('o_id',$o_id);

        $orders = $orders->orderBy('o.id','desc')->paginate(10);

        //订单商品种类
        $OrderGood = [];
        foreach($orders as $o){
            $num = DB::table('order_goods')->where('order_id',$o->id)->count();
            $o->order_method = order_way($o->order_method);
            $o->payment_info = order_payment($o->payment);
            $o->order_status_info = Order::getQygOrderStatus($o->order_status,$o->pay_status,$o->payment);
            $OrderGood[$o->id] = $num;
            // $o->created_at = date('Y-m-d H:i:s',$o->created_at);
            $o->exportDetail = config('app.url').'order/ExportDetail/'.$o->id;
            $o->org_id = empty($o->org_id)?$o->id:$o->org_id;
        }
        //分页参数
        $orders->appends(['order_status' => $request->input('order_status'),'search_key' => $request->input('search_key')])->links();

        $data = [];
        $data['orders'] = $orders;
        $data['total'] = $total;
        $data['skey'] = $skey;
        $data['start_time'] = $start_time;
        $data['end_time'] = $end_time;
        $data['OrderGood'] = $OrderGood;

        $data['uid'] = $user->id;
        $data['order_status'] = $order_status;


        return dataResult($data,'',1,200);
    }



    //申请为合约用户
    public function apply_HY(Request $request){
        $user = $this->apiUser;
        $address = Area::getAddress($user->prov,$user->city,$user->dist,$user->address);
        if(in_array($user->is_admin,[1,2])){
            return dataResult('','用户已经是合约用户',0,503);
        }
        $array=[
            'username'=>$user->realname,
            'position'=>'非合约用户',
            'company_name'=>'无',
            'address'=>$address,
            'company_size'=>0,
            'company_type'=>0,
            'phone'=>$user->mobile,
            'email'=>!empty($user->email)?$user->email:'',
            'limit'=>0,
            'know_way'=>0,
            'remark'=>'',
            'cpy_id'=>$user->company_id ,
            'uid'=>$user->id
        ];
        $res = DB::table('register_user')->insert($array);
        if($res){
            return dataResult('','申请成功',1,200);
        }
    }

    /**
     * [apply_info 合约申请状态]
     * @Author   andy
     * @DateTime 2019-07-26T15:14:34+0800
     * @return   [type]                   [description]
     */
    public function apply_info(Request $request){
        $user = $this->apiUser;
        $data = array();
        $apply = DB::table('users as u')
            ->leftJoin('register_user as ru', function($join) use($user){
                    $join->on('u.id','=','ru.uid');
                })
            ->where('u.id',$user->id)
            ->select('ru.status')
            ->orderBy('ru.id','desc')
            ->first();
        if(!empty($apply)){
            if(is_null($apply->status)){
                $apply->status_info = '无审核';
            }elseif($apply->status == 0){
                $apply->status_info = '待审核';
            }elseif($apply->status == 1){
                $apply->status_info = '审核通过';
                $data['b2b_url'] = config('app.switch_url').'md_login/'.lock_url($user->name);
            }elseif($apply->status == 2){
                $apply->status_info = '审核不通过';
            }
        }else{
            $apply->status = null;
            $apply->status_info = '无审核';
        }
        $data['apply'] = $apply;
        return dataResult($data,'',1,200);
    }


    //支付成功查询
    public function pay_success(Request $request){
        $id = $request->id;
        $order = DB::table('orders')->where('org_id',$id)->select('pay_status','total','id','order_method','org_id')->first();
        if(empty($order)){
            return dataResult('','订单不存在',0,503);
        }
        $order->org_id = !empty($order->org_id)?$order->org_id:$order->id;
        $data = [];
        if($order->pay_status == 1){
            $data['apply'] = $apply;
            return dataResult($data,'支付成功',1,200);
        }else{
            $data['apply'] = $apply;
            return dataResult($data,'该订单未支付',0,503);
        }
    }


    //数据分析报表
    public function report_data(Request $request)
    {
        set_time_limit(0);
        $user = $this->apiUser;
        $company_id = $user->company_id;

        $data  = [];
        $total_money = 0;

        $key                = empty($request->input('key'))?'':$request->input('key');
        $start_time         = empty($request->input('start_time'))?'':$request->input('start_time');
        $end_time           = empty($request->input('end_time'))?'':$request->input('end_time');
        $check_type         = empty($request->input('check_type'))?'11':$request->input('check_type');//11本周12上周21本月22上月
        $perPage            = empty($request->input('perPage'))?'20':$request->input('perPage');//页数

        $data['key']        = $key;
        $data['start_time'] = $start_time;
        $data['end_time']   = $end_time;
        $data['check_type']   = $check_type;
        $data['perPage']   = $perPage;

        $s_status_arr = [1,2,3,5,9,12];
        $r_status_arr = [7,10];
        $all_status_arr = [1,2,3,5,7,9,10,12];
        $online_pay_arr = [2,5,9,10];//线上支付方式
        $offline_pay_arr = [3,4];//线下支付方式

        $s_status_str = implode(',',$s_status_arr);
        $r_status_str = implode(',',$r_status_arr);
        $all_status_str = implode(',',$all_status_arr);
        $online_pay_str = implode(',',$online_pay_arr);
        $offline_pay_str = implode(',',$offline_pay_arr);

        $arr_check_type = [];
        $arr_check_type['11'] = '上周';
        $arr_check_type['12'] = '本周';
        $arr_check_type['21'] = '上月';
        $arr_check_type['22'] = '本月';


        switch ($check_type) {
            case '11':
                //本周第一天
                $BeginDate= Carbon::now()->subWeek()->startOfWeek()->toDateTimeString();
                //本周最后一天
                $LastDate = Carbon::now()->subWeek()->endOfWeek()->toDateTimeString();
                break;
            case '12':
                //上周第一天
                $BeginDate= Carbon::now()->startOfWeek()->toDateTimeString();
                //上周最后一天
                $LastDate = Carbon::now()->endOfWeek()->toDateTimeString();
                break;
            case '21':
                //本月第一天
                $BeginDate= Carbon::now()->subMonth()->startOfMonth()->toDateTimeString();
                //本月最后一天
                $LastDate = Carbon::now()->subMonth()->endOfMonth()->toDateTimeString();
                break;
            case '22':
                //上月第一天
                $BeginDate= Carbon::now()->startOfMonth()->toDateTimeString();
                //上月最后一天
                $LastDate = Carbon::now()->endOfMonth()->toDateTimeString();
                break;
            
            default:
                $BeginDate = '';
                $LastDate = '';
                break;
        }

        //当时间不为空
        if(!empty($start_time) && !empty($end_time)){
            $check_type = 0;
            $data['check_type']   = $check_type;
            $BeginDate = $start_time;
            $LastDate = $end_time;
        }else{
            $data['start_time'] = '';
            $data['end_time']   = '';
        }
        


        //销售额统计
        $startTimeYear = strtotime($BeginDate);
        // $lastTimeYear = strtotime($LastDate);
        $lastTimeYear = Carbon::parse($LastDate)->endOfDay()->timestamp;
// dd($startTimeYear,$lastTimeYear);
        //计算两个时间相差的月份
        $date_arr = diffDate($startTimeYear,$lastTimeYear);
        $month = $date_arr['year']*12 + $date_arr['month'];
        //超过1年半就提醒日期跨度大
        if($month>11){
            // return redirect()->back()->withErrors('日期跨度不能超过一年');
            return dataResult('','日期跨度不能超过一年',0,503);
        }

        //3个月内还是用日期
        if($month<3){
            $report_detail = DB::table('orders as o')
                    ->leftJoin('users as u','u.id','=','o.user_id')
                    ->whereBetween('o.created_at',[$startTimeYear,$lastTimeYear])
                    ->where('o.created_at','>',0)
                    ->whereNull('o.deleted_at')
                    ->whereIn('o.order_status',$all_status_arr)
                    ->where(['o.order_from'=>1])
                    ->where(['u.id'=>$user->id])
                    ->groupBy(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%Y-%m-%d')"))
                    ->select(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%Y-%m-%d') AS times"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($r_status_str) THEN return_total END) AS return_total_money"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN total END) AS total_money"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($r_status_str) THEN 1 END) AS return_count"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN 1 END) AS buy_count"));
            $report_detail_list = Cache::remember('report_detail'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail,$data)
                {
                    $report_detail = $report_detail->paginate($data['perPage']);
                    return $report_detail;
                });

            $report_detail_all = DB::table('orders as o')
                    ->leftJoin('users as u','u.id','=','o.user_id')
                    ->whereBetween('o.created_at',[$startTimeYear,$lastTimeYear])
                    ->where('o.created_at','>',0)
                    ->whereNull('o.deleted_at')
                    ->whereIn('o.order_status',$all_status_arr)
                    ->where(['o.order_from'=>1])
                    ->where(['u.id'=>$user->id])
                    ->groupBy(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%Y-%m-%d')"))
                    ->select(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%Y-%m-%d') AS times"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($r_status_str) THEN return_total END) AS return_total_money"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN total END) AS total_money"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($r_status_str) THEN 1 END) AS return_count"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN 1 END) AS buy_count"));
            $report_detail_all = Cache::remember('report_detail_all'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail_all,$data)
                {
                    $report_detail_all = $report_detail_all->get();
                    return $report_detail_all;
                });

            $report_detail_save_list = DB::table('order_goods as og')
                    ->leftJoin('orders','og.order_id','=','orders.id')
                    ->leftJoin('users as u','u.id','=','orders.user_id')
                    ->leftJoin('products as products','products.id','=','og.product_id')
                    ->where(['orders.order_from'=>1])
                    ->where('orders.deleted_at',NULL)
                    ->whereBetween('orders.created_at',[$startTimeYear,$lastTimeYear])
                    ->whereIn('orders.order_status',$s_status_arr)
                    ->whereRaw("( b2b_orders.pay_status =1 or b2b_orders.payment in ($offline_pay_str) )")
                    ->groupBy(DB::raw("FROM_UNIXTIME(b2b_orders.created_at, '%Y-%m-%d')"))
                    ->where(['u.id'=>$user->id])
                    ->select(DB::raw("FROM_UNIXTIME(b2b_orders.created_at, '%Y-%m-%d') AS times"),
                        DB::raw("sum( (b2b_products.price - b2b_og.price)* b2b_og.number) as save_money"));
            $report_detail_save_list = Cache::remember('report_detail_save_list'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail_save_list,$data)
                {
                    // $report_detail_save_list = $report_detail_save_list->get();
                    $report_detail_save_list = $report_detail_save_list->pluck('save_money','times');
                    return $report_detail_save_list;
                });
        }else{
            $report_detail = DB::table('orders as o')
                    ->leftJoin('users as u','u.id','=','o.user_id')
                    // ->whereRaw(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%Y-%m') > FROM_UNIXTIME(date_sub(curdate(), INTERVAL 12 MONTH),'%Y-%m')"))
                    ->whereBetween('o.created_at',[$startTimeYear,$lastTimeYear])
                    ->where('o.created_at','>',0)
                    ->whereNull('o.deleted_at')
                    ->whereIn('o.order_status',$all_status_arr)
                    ->where(['o.order_from'=>1])
                    ->where(['u.id'=>$user->id])
                    ->groupBy(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%m')"))
                    ->select(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%m') AS times"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($r_status_str) THEN return_total END) AS return_total_money"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN total END) AS total_money"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($r_status_str) THEN 1 END) AS return_count"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN 1 END) AS buy_count"));

            $report_detail_list = Cache::remember('report_detail'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail,$data)
                {
                    $report_detail = $report_detail->paginate($data['perPage']);
                    return $report_detail;
                });

            $report_detail_all = DB::table('orders as o')
                    ->leftJoin('users as u','u.id','=','o.user_id')
                    // ->whereRaw(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%Y-%m') > FROM_UNIXTIME(date_sub(curdate(), INTERVAL 12 MONTH),'%Y-%m')"))
                    ->whereBetween('o.created_at',[$startTimeYear,$lastTimeYear])
                    ->where('o.created_at','>',0)
                    ->whereNull('o.deleted_at')
                    ->whereIn('o.order_status',$all_status_arr)
                    ->where(['o.order_from'=>1])
                    ->where(['u.id'=>$user->id])
                    ->groupBy(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%m')"))
                    ->select(DB::raw("FROM_UNIXTIME(b2b_o.created_at, '%m') AS times"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($r_status_str) THEN return_total END) AS return_total_money"),
                        DB::raw("sum(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN total END) AS total_money"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($r_status_str) THEN 1 END) AS return_count"),
                        DB::raw("count(CASE WHEN b2b_o.order_status in ($s_status_str) AND (b2b_o.pay_status =1 or b2b_o.payment in ($offline_pay_str) ) THEN 1 END) AS buy_count"));
            $report_detail_all = Cache::remember('report_detail_all'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail_all,$data)
                {
                    $report_detail_all = $report_detail_all->get();
                    return $report_detail_all;
                });


            $report_detail_save_list = DB::table('order_goods as og')
                    ->leftJoin('orders','og.order_id','=','orders.id')
                    ->leftJoin('users as u','u.id','=','orders.user_id')
                    ->leftJoin('products as products','products.id','=','og.product_id')
                    ->where(['orders.order_from'=>1])
                    ->where('orders.deleted_at',NULL)
                    ->whereBetween('orders.created_at',[$startTimeYear,$lastTimeYear])
                    ->whereIn('orders.order_status',$s_status_arr)
                    ->whereRaw("( b2b_orders.pay_status =1 or b2b_orders.payment in ($offline_pay_str) )")
                    ->groupBy(DB::raw("FROM_UNIXTIME(b2b_orders.created_at, '%m')"))
                    ->where(['u.id'=>$user->id])
                    ->select(DB::raw("FROM_UNIXTIME(b2b_orders.created_at, '%m') AS times"),
                        DB::raw("sum( (b2b_products.price - b2b_og.price)* b2b_og.number) as save_money"));
            $report_detail_save_list = Cache::remember('report_detail_save_list'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail_save_list,$data)
                {
                    $report_detail_save_list = $report_detail_save_list->get();
                    return $report_detail_save_list;
                });
        }


        $report_detail_fenlei = DB::table('order_goods as og')
                ->leftJoin('orders','og.order_id','=','orders.id')
                ->leftJoin('users as u','u.id','=','orders.user_id')
                ->leftJoin('products as products','products.id','=','og.product_id')
                ->where(['orders.order_from'=>1])
                ->where('orders.deleted_at',NULL)
                ->whereBetween('orders.created_at',[$startTimeYear,$lastTimeYear])
                ->whereIn('orders.order_status',$s_status_arr)
                ->whereRaw("( b2b_orders.pay_status =1 or b2b_orders.payment in ($offline_pay_str) )")
                ->groupBy('products.cat_id')
                ->where(['u.id'=>$user->id])
                ->orderBy('total_money','DESC')
                ->select(DB::raw("sum(b2b_og.number) as buy_num"),
                    DB::raw("sum(b2b_og.price * b2b_og.number) as total_money"),
                    DB::raw("sum( (b2b_products.price - b2b_og.price)* b2b_og.number) as save_money"),
                    'products.cat_id','products.cat');
        $report_detail_fenlei = Cache::remember('report_detail_fenlei'.$user->company_id.'_'.$month, $minutes = 1, function() use($report_detail_fenlei,$data)
            {
                $report_detail_fenlei = $report_detail_fenlei->get();
                return $report_detail_fenlei;
            });
        $arr_all = [];
        $arr_all['buy_count'] = 0;
        $arr_all['return_count'] = 0;
        $arr_all['total_money'] = 0;
        $arr_all['return_total_money'] = 0;
        $arr_all['save_money'] = 0;

        foreach ($report_detail_all as $key => $value) {
            $arr_all['buy_count'] = $arr_all['buy_count'] + $value->buy_count;
            $arr_all['return_count'] = $arr_all['return_count'] + $value->return_count;
            $arr_all['total_money'] = $arr_all['total_money'] + $value->total_money;
            $arr_all['return_total_money'] = $arr_all['return_total_money'] + $value->return_total_money;
        }
        foreach ($report_detail_fenlei as $key => $value) {
            $arr_all['save_money'] = $arr_all['save_money'] + $value->save_money;
        }
        
        //显示时浮点异常问题，转字符串传输
        $total_money = round($arr_all['total_money'],2);
        $return_total_money = round($arr_all['return_total_money'],2);
        $save_money = round($arr_all['save_money'],2);
        $arr_all['total_money'] = strval($total_money);
        $arr_all['return_total_money'] = strval($return_total_money);
        $arr_all['save_money'] = strval($save_money);

        foreach ($report_detail_list as $key => $value) {
            if(isset($report_detail_save_list[$value->times])){
                $value->save_money = $report_detail_save_list[$value->times];
                if($value->save_money < 0){
                    $value->save_money = 0;
                }
            }else{
                $value->save_money = 0;
            }
        }

        foreach ($report_detail_all as $key => $value) {
            if(isset($report_detail_save_list[$value->times])){
                $value->save_money = $report_detail_save_list[$value->times];
                if($value->save_money < 0){
                    $value->save_money = 0;
                }
            }else{
                $value->save_money = 0;
            }
        }

        $data['arr_all'] = $arr_all;
        $data['list_all'] = $report_detail_all;
        $data['list'] = $report_detail_list;
        $data['fenlei'] = $report_detail_fenlei;
        $data['arr_check_type'] = $arr_check_type;
        // $data['report_detail_save_list'] = $report_detail_save_list;
        return dataResult($data,'',1,200);
    }


}
