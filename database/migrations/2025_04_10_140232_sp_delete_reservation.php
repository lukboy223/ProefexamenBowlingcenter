<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::unprepared('

        drop procedure if exists sp_delete_reservation;
        create procedure sp_delete_reservation(
            in INReservationId int unsigned
        )
        begin
            delete from People where ReservationId = INReservationId;
            delete from Reservations where Id = INReservationId;
        end
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
