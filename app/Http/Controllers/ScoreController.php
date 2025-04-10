<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Score; // Zorg ervoor dat je het juiste pad naar je Score model gebruikt
use Illuminate\Support\Facades\Log;

class ScoreController extends Controller
{
    public function index(Request $request)
    {
        // Variabelen voor paginering
        $perPage = 25;
        $page = $request->input('page', 1);
        $offset = ($page - 1) * $perPage;

        try {
            // Get a more accurate count from the same JOIN used in the stored procedure
            $total = DB::table('reservations')
                ->join('customers', 'reservations.CustomerId', '=', 'customers.Id')
                ->join('contacts', 'customers.AccountId', '=', 'contacts.Id')
                ->join('people', 'reservations.Id', '=', 'people.ReservationId')
                ->join('scores', 'people.Id', '=', 'scores.PeopleId')
                ->where('reservations.IsActief', 1)
                ->where('scores.IsActief', 1)
                ->count();

            // Roep de opgeslagen procedure aan
            $scores = DB::select('CALL GetReservationScores(?, ?)', [$perPage, $offset]);

            // Maak een LengthAwarePaginator object voor paginering
            $scores = new \Illuminate\Pagination\LengthAwarePaginator(
                $scores, 
                $total, 
                $perPage, 
                $page, 
                [
                    'path' => $request->url(),
                    'query' => $request->query(),
                ]
            );

            // Retourneer de view met de scores
            return view('scores.index', ['scores' => $scores]);
        } catch (\Exception $e) {
            // Log de fout voor debugging doeleinden
            Log::error('Error loading scores: ' . $e->getMessage());
            
            // Redirect terug met een foutmelding
            return redirect()->back()->with('error', 
                'Er is iets misgegaan bij het laden van de scores. Probeer het later opnieuw of neem contact op met de beheerder.');
        }
    }

    public function create()
    {
        $people = DB::table('Contacts')
        ->get(['Id', 'FirstName', 'LastName']); // Gebruik de juiste tabel en kolomnamen

        $reservations = DB::table('Reservations as r')
        ->join('Contacts as c', 'r.CustomerId', '=', 'c.Id')
        ->where('r.IsActief', 1) // Als je alleen actieve reserveringen wilt
        ->get(['r.Id as ReservationId', 'r.ReservationDate', 'c.FullName']);

        return view('scores.create', [
            'reservations' => $reservations,
            'people' => $people
        ]);
    }

    public function store(Request $request)
    {
        try {
            // Validate the request data - add Opmerking field
            $validatedData = $request->validate([
                'ReservationId' => 'required|integer|exists:reservations,Id',
                'PeopleId' => 'required|integer|exists:people,Id',
                'Score' => 'required|integer|min:0|max:300',
                'Opmerking' => 'nullable|string|max:255', // Add this line
            ]);

            // Check if this person already has a score
            $existingScore = DB::table('scores')
                ->where('PeopleId', $validatedData['PeopleId'])
                ->where('IsActief', 1) // Make sure this column exists
                ->first();

            if ($existingScore) {
                // Get person name - use correct column names from your database
                $person = DB::table('people')
                    ->where('Id', $validatedData['PeopleId'])
                    ->first();
                    
                // Use a more generic approach for name to handle various column naming
                $firstName = $person->FirstName ?? $person->first_name ?? $person->firstname ?? '';
                $lastName = $person->LastName ?? $person->last_name ?? $person->lastname ?? '';
                $name = trim("$firstName $lastName");
                
                return redirect()->back()
                    ->withInput()
                    ->with('error', "Deze klant heeft al een score. Probeer een andere naam.");
            }

            // Prepare data for insertion with all required fields
            $scoreData = [
                'PeopleId' => $validatedData['PeopleId'],
                'Score' => $validatedData['Score'],
                'Opmerking' => $validatedData['Opmerking'] ?? null,
                'IsActief' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ];

            // Debug before insert
            Log::info('Attempting to insert score data:', $scoreData);

            // Insert the new score into the database
            $inserted = DB::table('scores')->insert($scoreData);
            
            // Debug after insert
            Log::info('Insert result: ' . ($inserted ? 'success' : 'failure'));

            // Redirect with success message
            return redirect()->route('scores.index')
                ->with('success', 'Score is succesvol toegevoegd.');
        } catch (\Exception $e) {
            // Enhanced error logging
            Log::error('Error adding score: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            
            // Redirect with error message
            return redirect()->back()
                ->withInput()
                ->with('error', 'Er is iets misgegaan bij het toevoegen van de score: ' . $e->getMessage());
        }
    }
}
