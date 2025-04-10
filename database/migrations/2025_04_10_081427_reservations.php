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
        drop table if exists Reservations;
        CREATE TABLE Reservations (
    Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    CustomerId INT UNSIGNED NOT NULL,
    BowlingLaneId INT UNSIGNED NOT NULL,
    ReservationDate Date not null,
    ReservationTime time NOT NULL,
    AmountOfHours tinyint unsigned not null,
    Price DECIMAL(5,2) NOT NULL,
    IsActief BIT NOT NULL DEFAULT 1,
    Opmerking VARCHAR(250) DEFAULT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT NOW(6),
    updated_at DATETIME(6) NOT NULL DEFAULT NOW(6) ON UPDATE NOW(6),
    primary key (id),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (BowlingLaneId) REFERENCES BowlingLanes(Id)
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
