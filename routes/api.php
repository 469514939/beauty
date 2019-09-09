<?php

use Illuminate\Http\Request;
use Illuminate\Routing\Router;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::group(['middleware' => ['web','cors']], function (Router $router) {
    $router->post('/index_Poster','Separation\QygInfoController@index_Poster');//首页轮播图
    $router->post('/index_Tuijian','Separation\QygInfoController@index_Tuijian');//首页推荐图
    $router->post('/index_Banner','Separation\QygInfoController@index_Banner');//首页横幅图
    $router->post('/index_Service','Separation\QygInfoController@index_Service');//首页服务图
    $router->post('/index_IndexNav','Separation\QygInfoController@index_IndexNav');//首页品牌图
    $router->post('/index_Floor','Separation\QygInfoController@index_Floor');//首页楼层图
    $router->post('/index_Bottom','Separation\QygInfoController@index_Bottom');//底部信息

    $router->post('/index_HotProducts','Separation\QygInfoController@index_HotProducts');//首页热销商品
    $router->post('/index_BrandProducts','Separation\QygInfoController@index_BrandProducts');//首页品牌图
    $router->post('/index_FavoriteProducts','Separation\QygInfoController@index_FavoriteProducts');//首页喜欢图
    $router->post('/index_NewProducts','Separation\QygInfoController@index_NewProducts');//首页最新上架图
    $router->post('/index_TuijianProducts','Separation\QygInfoController@index_TuijianProducts');//首页推荐图
    $router->post('/index_SeckillProducts','Separation\QygInfoController@index_SeckillProductS');//首页秒杀商品

});


Route::group(['middleware' => ['web','cors']], function (Router  $router) {
    $router->post('/login', 'Separation\MemberAuthController@login');
    $router->post('/register', 'Separation\MemberAuthController@register');
    $router->post('/getBlacklist', 'Separation\MemberAuthController@getBlacklist');
    $router->group(['middleware' => 'jwt.auth'], function ($router) {
    $router->post('get_user_details', 'Separation\MemberAuthController@get_user_details');  // 获取用户详情
    $router->post('logout', 'Separation\MemberAuthController@logout');  // 刷新token
    $router->post('refresh', 'Separation\MemberAuthController@refresh');  // 刷新token
    });
});