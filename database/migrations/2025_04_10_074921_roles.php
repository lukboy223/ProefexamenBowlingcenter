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
        drop table if exists Roles;
        CREATE TABLE Roles (
     Id INT UNSIGNED NOT NULL AUTO_INCREMENT
    ,Role VARCHAR(10) NOT NULL
    ,IsActief BIT NOT NULL DEFAULT 1
    ,Opmerking VARCHAR(250) DEFAULT NULL
    ,created_at DATETIME(6) NOT NULL DEFAULT NOW(6)
    ,updated_at DATETIME(6) NOT NULL DEFAULT NOW(6) ON UPDATE NOW(6)
    ,Primary Key (id)
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
