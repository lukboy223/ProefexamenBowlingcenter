<?php

namespace Database\Factories;

use App\Models\Extra;
use App\Models\Reservation;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
 */
class ReservationExtraFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'ReservationId' => Reservation::factory(),
            'ExtrasId' => Extra::factory()
        ];
    }
}
