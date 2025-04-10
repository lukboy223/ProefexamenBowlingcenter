<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ScoreController;

Route::get('/', function () {
    return view('welcome');
});

// scores
Route::get('/scores', [ScoreController::class, 'index'])->name('scores.index');
Route::get('/scores/create', [ScoreController::class, 'create'])->name('scores.create');
Route::post('/scores', [ScoreController::class, 'store'])->name('scores.store');

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
