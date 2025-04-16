<?php

namespace Database\Factories;

use App\Models\Bowlinglane;
use App\Models\Customer;
use App\Models\Person;
use App\Models\ReservationExtra;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Reservation>
 */
class ReservationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'CustomerId' => Customer::factory(),
            'BowlingLaneId' => Bowlinglane::factory(),           
            'ReservationTime' => fake()->Time(),
            'ReservationDate' => fake()->date(),
            'Price' => fake()->randomFloat(2, 20, 200),
            'AmountOfHours' => fake()->numberBetween(1, 10),
            


        ];
    }
}
