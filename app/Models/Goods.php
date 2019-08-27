<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Goods extends Model
{
    protected $table = 'goods';

    public function goodsCate()
    {
        // return $this->belongsToMany(GoodsCate::class);
        return $this->hasOne(GoodsCate::class, 'id', 'cate_id');
    }

    public function goodsType()
    {
        // return $this->belongsToMany(GoodsType::class);
        // return $this->hasOne(GoodsType::class);
        // return $this->belongsTo(GoodsType::class);
        return $this->hasOne(GoodsType::class, 'id', 'type_id');
    }

    public function goodsBrand()
    {
        // return $this->belongsTo(GoodsBrand::class);
        // return $this->hasOne(GoodsBrand::class);
        return $this->hasOne(GoodsBrand::class, 'id', 'brand_id');
    }
}
