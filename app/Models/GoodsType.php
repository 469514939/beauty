<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GoodsType extends Model
{
    protected $table = 'goodstype';

    public static function options()
    {
    	$info = GoodsType::get();
    	$arr = [];
    	foreach ($info as $key => $value) {
    		$arr[$value->id] = $value->name;
    	}
    	return $arr;
    }

}
