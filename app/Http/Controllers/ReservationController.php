<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ReservationController extends Controller
{
    public function index(Request $request) 
    {

        //makes variables for pagination

        $perPage = 25;
        $page = $request->input('page', 1);
        $offset = ($page - 1) * $perPage;

        $total = DB::table('Reservations')->count();

        // try catch looks if the SP exists
        try{
            $reservations = DB::select('call sp_read_reservations(?, ?)', [$perPage, $offset]);
            

        } catch (\Exception $e) {
            //logs the error in the log
            Log::error('error reading reservations: ' . $e->getMessage());
            //makes an empty array if the SP doesn't exist
            $reservations = [];
        }
        
        //paginate

        $reservations = new LengthAwarePaginator($reservations, $total, $perPage, $page, [
            'path' => $request->url(),
            'query' => $request->query(),
        ]);

        //redirect the user to the index page with all the reservations

        return view('Reservation.index', ['reservations' => $reservations]);

    }

    public function create(){

        return view('Reservation.create');
    }

    public function store(Request $request){
        
        $request->validate([
            'CustomerId' => 'required|integer',
            'BowlingLaneId' => 'required|integer|exists:BowlingLanes,id',
            'ReservationDate' => 'required|date',
            'ReservationTime' => 'required|date_format:H:i',
            'AmountOfHours' => 'required|integer|min:1|max:10',
            'Adults' => 'required|integer|min:1|max:8',
            'Kids' => 'required|integer|min:0|max:4',
            'Extra' => 'required|integer| exists:extras,id',
        ]);



        try{
            $reservationDate = $request->input('ReservationDate');
            $reservationTime = $request->input('ReservationTime');
            $amountOfHours = $request->input('AmountOfHours');
    
            $dayOfWeek = date('N', strtotime($reservationDate)); // 1 (Monday) to 7 (Sunday)
            $time = strtotime($reservationTime);
    
            if ($dayOfWeek >= 1 && $dayOfWeek <= 4) {
                // Monday to Thursday
                $pricePerHour = 24.00;
            } elseif ($dayOfWeek >= 5 && $dayOfWeek <= 7) {
                // Friday to Sunday
                if ($time >= strtotime('14:00') && $time < strtotime('18:00')) {
                    $pricePerHour = 28.00;
                } elseif ($time >= strtotime('18:00') && $time <= strtotime('24:00')) {
                    $pricePerHour = 33.50;
                } else {
                    $pricePerHour = 24.00; // Default to weekday price if outside specified times
                }
            } else {
                $pricePerHour = 24.00; // Default price
            }
    
            // Calculate the total price
            $price = $pricePerHour * $amountOfHours;

            DB::select('call sp_create_reservation(?, ?, ?, ?, ?, ?, ?, ?, ?)', [
                $request->input('CustomerId'),
                $request->input('BowlingLaneId'),
                $request->input('ReservationDate'),
                $request->input('ReservationTime'),
                $request->input('AmountOfHours'),
                $price,
                $request->input('Adults'),
                $request->input('Kids'),
                $request->input('Extra')
            ]);

            return redirect()->route('reservation.index')->with('success', 'Reservatie succesvol gemaakt');
        } catch (\Exception $e) {
            //logs the error in the log
            Log::error('error creating reservation: ' . $e->getMessage());
            //redirects the user to the create page with an error message
            return redirect()->route('reservation.create')->with('error', 'Er is iets fout gegaan bij het aanmaken van de reservering');
        }
    }
    public function destroy($id)
    {
        try{
            DB::select('call sp_delete_reservation(?)', [$id]);
            return redirect()->route('reservation.index')->with('success', 'Reservatie succesvol verwijderd');
        } catch (\Exception $e) {
            //logs the error in the log
            Log::error('error deleting reservation: ' . $e->getMessage());
            //redirects the user to the index page with an error message
            return redirect()->route('reservation.index')->with('error', 'Er is iets fout gegaan bij het verwijderen van de reservering');
        }
    }
}
