<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Users extends Model
{
    protected $table = 'users';

    public function wxUsers()
    {
        return $this->hasOne(WxUsers::class, 'user_id', 'id');
    }
    public function profile()
    {
        return $this->hasOne(Profile::class, 'user_id', 'id');
    }
}
