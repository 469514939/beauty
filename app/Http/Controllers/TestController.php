<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Routing\Router;

class TestController extends Controller
{
    
    //ceshi
    public function test()
    {
        // $name = Route::getRoutes();
        $name = app('router')->getRoutes();
        dd($name);
    }

}
