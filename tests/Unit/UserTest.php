<?php

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('a user can be created', function () {
    $user = User::factory()->create([
        'name' => 'John Doe',
        'email' => 'johndoe@example.com',
    ]);
});