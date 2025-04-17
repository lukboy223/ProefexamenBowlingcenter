<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReservationController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ScoreController;

Route::get('/', function () {
    return view('welcome');
});

// scores
Route::get('/scores', [ScoreController::class, 'index'])->name('scores.index');
Route::get('/scores/create', [ScoreController::class, 'create'])->name('scores.create');
Route::post('/scores', [ScoreController::class, 'store'])->name('scores.store');
Route::get('/scores/{id}/edit', [ScoreController::class, 'edit'])->name('scores.edit');
Route::put('/scores/{id}', [ScoreController::class, 'update'])->name('scores.update');
Route::delete('/scores/{id}', [ScoreController::class, 'destroy'])->name('scores.destroy');

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::middleware('auth')->group(function () {
    Route::get('/reservation', [ReservationController::class, 'index'])->name('reservation.index');
    Route::get('/Reserveringen/maken', [ReservationController::class, 'create'])->name('reservation.create');
    Route::post('/reservering/opslaan', [ReservationController::class, 'store'])->name('reservation.store');
    Route::get('/Reserveringen/aanpasen/{id}', [ReservationController::class, 'edit'])->name('reservation.edit');
    Route::patch('/Reserveringen/wijzigen/{id}', [ReservationController::class, 'update'])->name('reservation.update');
    Route::delete('/Reserveringen/verwijderen/{id}', [ReservationController::class, 'destroy'])->name('reservation.destroy');

});

require __DIR__.'/auth.php';
