<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
	protected $table = 'profiles';
    public function users()
    {
        return $this->belongsTo(Users::class, 'id', 'user_id');
    }
}