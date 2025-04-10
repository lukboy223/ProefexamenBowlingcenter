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
        DROP PROCEDURE IF EXISTS GetScoresWithPeopleAndContact;
    ');
        DB::unprepared('
            CREATE PROCEDURE GetScoresWithPeopleAndContact()
            BEGIN
                SELECT 
                    scores.id,
                    contacts.FirstName,
                    contacts.Infix,
                    contacts.LastName,
                    contacts.FullName,
                    scores.Score,
                    scores.IsActief,
                    scores.Opmerking,
                    scores.created_at,
                    scores.updated_at
                FROM scores
                INNER JOIN people ON scores.PeopleId = people.id  -- Join met people tabel
                INNER JOIN contacts ON contacts.id = people.id;  -- Koppel contacts via de id van people
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