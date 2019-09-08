<?php

use Illuminate\Routing\Router;

Admin::routes();

Route::group([
    'prefix'        => config('admin.route.prefix'),
    'namespace'     => config('admin.route.namespace'),
    'middleware'    => config('admin.route.middleware'),
], function (Router $router) {

    $router->get('/', 'HomeController@index')->name('admin.home');
    $router->resource('users', UserController::class);
    $router->resource('movies', MovieController::class);
    $router->resource('posts', PostController::class);

    $router->resource('goodsCate', GoodsCateController::class);
    $router->resource('goodsType', GoodsTypeController::class);
    $router->resource('goodsBrand', GoodsBrandController::class);
    $router->resource('goods', GoodsController::class);

    $router->resource('users', UsersController::class);

});
