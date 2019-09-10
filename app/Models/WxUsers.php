<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WxUsers extends Model
{
    protected $table = 'wxusers';
    public function users()
    {
        return $this->belongsTo(Users::class, 'id', 'user_id');
    }
}
