<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class WxUsers extends Model
{
    protected $table = 'wxusers';

    protected $fillable = ['wxid'];

    public function users()
    {
        return $this->hasOne(Users::class, 'id', 'uid');
    }
}
