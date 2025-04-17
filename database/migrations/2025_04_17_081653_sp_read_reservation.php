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
        drop procedure if exists sp_read_reservation;
        create procedure sp_read_reservation(
         in givReservationId int
        )
        begin

        select
         RES.Id
        ,CONT.Fullname
        ,RES.ReservationDate
        ,RES.ReservationTime
        ,RES.AmountOfHours
        ,BOWL.LaneNR
        ,POE.Adults
        ,POE.Kids
        ,RES.Price
        ,EX.Name AS ExtraName
        ,Ex.Id as ExtraId



        from Reservations as RES

        inner join customers as CUST
        on RES.CustomerId = CUST.Id

        inner join users as USER
        on CUST.UserId = USER.id

        inner join contacts as CONT
        on USER.ContactId = CONT.Id

        inner join BowlingLanes as BOWL
        on RES.BowlingLaneId = BOWL.Id

        inner join People as POE
        on RES.Id = POE.ReservationId


        inner join extras as EX
        on RES.ExtrasId = EX.Id
        
        where RES.Id = givReservationId;
    
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
