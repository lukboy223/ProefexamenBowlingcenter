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
        drop table if exists Contacts;
        CREATE TABLE Contacts (
    Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    Infix VARCHAR(10),
    LastName VARCHAR(50) NOT NULL,
    FullName VARCHAR(110) as (concat_ws(" ", FirstName, Infix, LastName)) stored,
    Phone VARCHAR(10) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    IsActief BIT NOT NULL DEFAULT 1,
    Opmerking VARCHAR(250) DEFAULT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT NOW(6),
    updated_at DATETIME(6) NOT NULL DEFAULT NOW(6) ON UPDATE NOW(6),
    Primary Key (id)
)engine=innoDB;
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
