<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReservationController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::middleware('auth')->group(function () {
    Route::get('/Reserveringen', [ReservationController::class, 'index'])->name('reservation.index');
    Route::get('/Reserveringen/maken', [ReservationController::class, 'create'])->name('reservation.create');
    Route::post('/reservering/opslaan', [ReservationController::class, 'store'])->name('reservation.store');
    Route::get('/Reserveringen/aanpasen/{id}', [ReservationController::class, 'edit'])->name('reservation.edit');
    Route::delete('/Reserveringen/verwijderen/{id}', [ReservationController::class, 'destroy'])->name('reservation.destroy');

});

require __DIR__.'/auth.php';
