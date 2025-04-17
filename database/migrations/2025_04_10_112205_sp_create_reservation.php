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
        drop procedure if exists sp_create_reservation;
        create procedure sp_create_reservation(

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
        declare SELreservationsId int unsigned default 0;
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

        insert into reservations
        (CustomerId, ExtrasId, BowlingLaneId, ReservationDate, ReservationTime, AmountOfHours, Price) Values
        (SELCustomerId, INExtraId, INBowlingLaneId, INReservationDate, INReservationTime, INAmountOfHours, INPrice);

        set SELreservationsId = LAST_INSERT_ID();

        insert into People 
        (ReservationId, Adults, Kids) values
        (SELreservationsId, INAdults, INKids);


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
