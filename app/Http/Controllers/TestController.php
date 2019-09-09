<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Routing\Router;

use App\Models\Products;

class TestController extends Controller
{
    
    //ceshi
    public function test()
    {
        // $name = app('router')->getRoutes();
        // dd($name);
        $list = Products::where('status',1)->paginate(15);
        dd($list);
    }

}
