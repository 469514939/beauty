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
    $router->post('/products_list','Separation\ProductsController@products_list');//商品列表
    $router->post('/products_info','Separation\ProductsController@products_info');//商品详情

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