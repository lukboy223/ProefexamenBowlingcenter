<?php

namespace Database\Factories;

use App\Models\Reservation;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Person>
 */
class PersonFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'ReservationId' => Reservation::factory(),  // This assumes you have a Reservation model and factory
            'Adults' => $this->faker->numberBetween(1, 10), // Random number between 1 and 10
            'Kids' => $this->faker->numberBetween(0, 10), // Random number between 0 and 10
        ];
    }
}
