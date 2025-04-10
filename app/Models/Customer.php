<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * @extends Model<\Database\Factories\ReservationFactory>
 */
class Customer extends Model
{
    use HasFactory;
    protected $table = 'Customers'; // Explicitly set the table name
}
