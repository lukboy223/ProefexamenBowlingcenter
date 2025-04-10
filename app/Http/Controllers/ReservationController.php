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

        $total = DB::table('users')->count();

        // try catch looks if the SP exists
        try{
            $reservations = DB::select('call sp_read_resedrvations(?, ?)', [$perPage, $offset]);

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
}
