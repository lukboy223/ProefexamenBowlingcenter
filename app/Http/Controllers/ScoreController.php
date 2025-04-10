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
            // Haal het totaal aantal scores op (voor paginering)
            $total = DB::table('scores')->count();

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

    
    // public function show($id)
    // {
    //     // Call the stored procedure with a specific ID
    //     $score = \DB::select('CALL GetScoresWithPeopleAndContact(?)', [$id]);

    //     // Return the score to a view or as JSON
    //     return response()->json($score);
    // }
    // public function store(Request $request)
    // {
    //     // Validate the request data
    //     $validatedData = $request->validate([
    //         'PeopleId' => 'required|integer',
    //         'Score' => 'required|integer',
    //         'IsActief' => 'required|boolean',
    //         'Opmerking' => 'nullable|string',
    //     ]);

    //     // Insert the new score into the database
    //     \DB::table('scores')->insert($validatedData);

    //     // Return a success response
    //     return response()->json(['message' => 'Score created successfully'], 201);
    // }
    // public function update(Request $request, $id)
    // {
    //     // Validate the request data
    //     $validatedData = $request->validate([
    //         'PeopleId' => 'required|integer',
    //         'Score' => 'required|integer',
    //         'IsActief' => 'required|boolean',
    //         'Opmerking' => 'nullable|string',
    //     ]);

    //     // Update the score in the database
    //     \DB::table('scores')->where('id', $id)->update($validatedData);

    //     // Return a success response
    //     return response()->json(['message' => 'Score updated successfully']);
    // }
    // public function destroy($id)
    // {
    //     // Delete the score from the database
    //     \DB::table('scores')->where('id', $id)->delete();

    //     // Return a success response
    //     return response()->json(['message' => 'Score deleted successfully']);
    // }
}
