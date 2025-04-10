<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::unprepared('
        DROP PROCEDURE IF EXISTS GetReservationScores;
    ');
    
        DB::unprepared('
        CREATE PROCEDURE GetReservationScores(IN givLIMIT INT, IN givOFFSET INT)
        BEGIN
            SELECT 
                Reservations.ReservationDate, 
                Reservations.ReservationTime,
                Contacts.FullName AS CustomerName, 
                Scores.Score
            FROM Reservations
            INNER JOIN Customers ON Reservations.CustomerId = Customers.Id
            INNER JOIN Contacts ON Customers.AccountId = Contacts.Id
            INNER JOIN People ON Reservations.Id = People.ReservationId
            INNER JOIN Scores ON People.Id = Scores.PeopleId
            WHERE Reservations.IsActief = 1 AND Scores.IsActief = 1
            LIMIT givLIMIT OFFSET givOFFSET;
        END
    ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::unprepared('DROP PROCEDURE IF EXISTS GetScoresWithPeopleAndContact');
    }
};