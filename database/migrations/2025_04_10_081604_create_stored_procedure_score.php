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
                Scores.Id,  -- Add this line to include the Score ID
                Reservations.ReservationDate, 
                Reservations.ReservationTime,
                Contacts.FullName AS CustomerName, 
                Scores.Score
            FROM Reservations
            INNER JOIN Customers ON Reservations.CustomerId = Customers.Id
            INNER JOIN Contacts ON Customers.UserId = Contacts.Id
            INNER JOIN People ON Reservations.Id = People.ReservationId
            INNER JOIN Scores ON People.Id = Scores.PeopleId
            WHERE Reservations.IsActief = 1 AND Scores.IsActief = 1
            LIMIT givLIMIT OFFSET givOFFSET;
        END
    ');

    DB::unprepared('
    DROP PROCEDURE IF EXISTS GetActiveReservations;
');

        DB::unprepared('
        CREATE PROCEDURE GetActiveReservations()
        BEGIN
            SELECT 
                r.Id as ReservationId, 
                r.ReservationDate, 
                c.FullName
            FROM Reservations r
            INNER JOIN Contacts c ON r.CustomerId = c.Id
            WHERE r.IsActief = 1;
        END
    ');
        
        DB::unprepared('
        DROP PROCEDURE IF EXISTS GetReservationById;
    ');

        DB::unprepared('
        CREATE PROCEDURE GetReservationById(IN reservationId INT)
        BEGIN
            SELECT 
                r.Id as ReservationId, 
                r.ReservationDate, 
                c.FullName
            FROM Reservations r
            INNER JOIN Customers cu ON r.CustomerId = cu.Id
            INNER JOIN Contacts c ON cu.UserId = c.Id
            WHERE r.Id = reservationId;
        END
    ');

    DB::unprepared('
        DROP PROCEDURE IF EXISTS CheckExistingScore;
    ');

        DB::unprepared('
        CREATE PROCEDURE CheckExistingScore(IN personId INT)
        BEGIN
            SELECT * FROM scores 
            WHERE PeopleId = personId
            AND IsActief = 1;
        END
    ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::unprepared('DROP PROCEDURE IF EXISTS GetReservationScores');
        DB::unprepared('DROP PROCEDURE IF EXISTS GetActiveReservations');
        DB::unprepared('DROP PROCEDURE IF EXISTS GetReservationById');
        DB::unprepared('DROP PROCEDURE IF EXISTS CheckExistingScore');
    }
};