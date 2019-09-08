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
use Session;
use Cache;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Wxtemplate;
use App\Models\MemberCoupon;
use App\Models\ClassMenu;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    //修改密码
    public function changePassword(Request $request){
        $user = auth('api')->user();
        if(empty($user)){
            return dataResult('','没有用户信息',0,503);
        }
        $password = $request->password;
        $new_password = $request->new_password;
        $confirm_password = $request->confirm_password;

        if(empty($password)){
            return dataResult('','密码不能为空',0,503);
        }
        if(empty($new_password)){
            return dataResult('','新密码不能为空',0,503);
        }
        if(empty($confirm_password)){
            return dataResult('','确认密码不能为空',0,503);
        }
        if($new_password != $confirm_password){
            return dataResult('','两次密码不一样',0,503);
        }
        if(!Hash::check($password, $user->password)){
            return dataResult('','旧密码错误',0,503);
        }

        $user->password = bcrypt($new_password);
        $user->plaintext_password = $new_password;
        if($user->save()){
            return dataResult('','修改成功',1,200);
        }else{
            return dataResult('','修改失败',0,503);
        }
    }

}
