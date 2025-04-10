<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;


class ReservationExtra extends Model
{
    use HasFactory;
    protected $table = 'ReservationExtras'; // Explicitly set the table name

}
