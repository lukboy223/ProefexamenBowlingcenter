<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Score;
use App\Models\Person;
use App\Models\Contact;
use App\Models\Reservation;
use App\Models\Customer;
// use App\Models\Role;
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
        ]);
        // scores
        Score::factory(200)->create();
        // people
        People::factory(200)->create();
        // contacts
        Contact::factory(200)->create();
        // reservations
        Reservation::factory(200)->create();
        // customers
        Customer::factory(200)->create();
    }
}
