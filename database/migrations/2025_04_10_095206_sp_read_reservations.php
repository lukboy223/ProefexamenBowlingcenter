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
        drop procedure if exists sp_read_reservations;
        create procedure sp_read_reservations(
         in givLIMIT int
        ,in givOFFSET int
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
        ,GROUP_CONCAT(EX.Name SEPARATOR ", ") AS ExtraName



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

        inner join Reservation_extras as REEX
        on RES.id = REEX.ReservationId

        inner join extras as EX
        on REEX.ExtrasId = EX.Id

        group by 
         RES.Id, 
        CONT.Fullname, 
        RES.ReservationDate, 
        RES.ReservationTime, 
        RES.AmountOfHours, 
        BOWL.LaneNR, 
        POE.Adults, 
        POE.Kids, 
        RES.Price
        
        order by RES.ReservationDate
        limit givLIMIT offset givOFFSET;



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
