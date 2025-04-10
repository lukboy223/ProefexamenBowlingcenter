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
        drop table if exists Customers;
        CREATE TABLE Customers (
    Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    AccountId INT UNSIGNED NOT NULL,
    CustomerNr INT NOT NULL,
    IsActief BIT NOT NULL DEFAULT 1,
    Opmerking VARCHAR(250) DEFAULT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT NOW(6),
    updated_at DATETIME(6) NOT NULL DEFAULT NOW(6) ON UPDATE NOW(6),
    primary key (id),
    FOREIGN KEY (AccountId) REFERENCES users(Id)
);
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
