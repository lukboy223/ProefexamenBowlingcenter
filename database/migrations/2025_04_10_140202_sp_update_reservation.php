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
        drop procedure if exists sp_update_reservation;
        create procedure sp_update_reservation(

        in givReservationId int unsigned,
        in INContactIdId int unsigned,
        in INBowlingLaneId int unsigned,

        in INReservationDate date,
        in INReservationTime time,
        in INAmountOfHours tinyint unsigned,
        in INPrice decimal(5,2),
        
        in INAdults tinyint unsigned,
        in INKids tinyint unsigned,
        
        in INExtraId int unsigned
        )
        begin

         declare SELCustomerId int unsigned default 0;
        
        select 
        CUST.Id
        into SELCustomerId
        from Contacts as CONT
        
        inner join Users as USER
        on CONT.Id = USER.ContactId
        
        inner join Customers as CUST
        on CUST.UserId = USER.Id

        where CONT.Id = INContactIdId;


        update reservations set
        CustomerId = SELCustomerId,
    BowlingLaneId = INBowlingLaneId,
    ExtrasId = INExtraId,
    ReservationDate =INReservationDate,
    ReservationTime = INReservationTime,
    AmountOfHours = INAmountOfHours,
    Price = INPrice
    where Id = givReservationId;

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
