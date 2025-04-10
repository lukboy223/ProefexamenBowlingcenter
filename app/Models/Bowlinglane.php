<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Bowlinglane extends Model
{
    use hasfactory;
    protected $table = 'Bowlinglanes'; // Explicitly set the table name
