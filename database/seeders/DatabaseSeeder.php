<?php

namespace Database\Seeders;

use App\Models\Person;
use App\Models\Reservation;
use App\Models\ReservationExtra;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('cookie123')
        ]);

        // Reservation::factory(200)->create();
        Person::factory(100)->create();
        ReservationExtra::factory(100)->create();
    }
}
