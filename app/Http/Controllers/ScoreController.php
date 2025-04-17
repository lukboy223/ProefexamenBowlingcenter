<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Pagination\LengthAwarePaginator;
use App\Models\Score;

class ScoreController extends Controller
{
    public function index(Request $request)
    {
        $perPage = 25;
        $page = $request->input('page', 1);
        $offset = ($page - 1) * $perPage;

        $total = DB::table('reservations')
            ->join('customers', 'reservations.CustomerId', '=', 'customers.Id')
            ->join('contacts', 'customers.UserId', '=', 'contacts.Id')
            ->join('people', 'reservations.Id', '=', 'people.ReservationId')
            ->join('scores', 'people.Id', '=', 'scores.PeopleId')
            ->where('reservations.IsActief', 1)
            ->where('scores.IsActief', 1)
            ->count();

        $scores = DB::select('CALL GetReservationScores(?, ?)', [$perPage, $offset]);

        $scores = new LengthAwarePaginator($scores, $total, $perPage, $page, [
            'path' => $request->url(),
            'query' => $request->query(),
        ]);

        return view('scores.index', compact('scores'));
    }

    public function create()
    {
        $people = DB::table('Contacts')->get(['Id', 'FirstName', 'LastName']);

        $reservations = DB::table('Reservations as r')
            ->join('Contacts as c', 'r.CustomerId', '=', 'c.Id')
            ->where('r.IsActief', 1)
            ->get(['r.Id as ReservationId', 'r.ReservationDate', 'c.FullName']);

        return view('scores.create', compact('reservations', 'people'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'Score' => 'required|integer|min:0|max:300',
            'PeopleId' => 'required|exists:contacts,Id', // Validate that the person exists
        ]);

        DB::table('scores')->insert([
            'Score' => $validated['Score'],
            'PeopleId' => $validated['PeopleId'],
            'IsActief' => 1,
            'created_at' => now(),
            'updated_at' => now()
        ]);

        return redirect()->route('scores.index')->with('success', 'Score is succesvol toegevoegd.');
    }

    public function edit($id)
    {
        $score = DB::table('scores')->where('Id', $id)->first();

        if (!$score) {
            return redirect()->route('scores.index')->with('error', 'Score niet gevonden.');
        }

        $person = DB::table('people')->find($score->PeopleId) ?? (object)[
            'first_name' => 'Onbekend', 'last_name' => 'Persoon'
        ];

        $reservation = DB::table('reservations as r')
            ->join('customers as cu', 'r.CustomerId', '=', 'cu.Id')
            ->join('contacts as c', 'cu.UserId', '=', 'c.Id')
            ->where('r.Id', $score->ReservationId ?? 0)
            ->select('r.Id as ReservationId', 'r.ReservationDate', 'c.FullName')
            ->first() ?? (object)[
                'ReservationId' => 0, 
                'ReservationDate' => now()->toDateString(), 
                'FullName' => 'Onbekende reservering'
            ];

        return view('scores.edit', compact('score', 'person', 'reservation'));
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'Score' => 'required|integer|min:0|max:300',
        ]);

        $score = DB::table('scores')->where('Id', $id)->where('IsActief', 1)->first();

        if (!$score) {
            return redirect()->route('scores.index')->with('error', 'Score niet gevonden.');
        }

        DB::table('scores')->where('Id', $id)->update([
            'Score' => $validated['Score'],
            'updated_at' => now(),
        ]);

        return redirect()->route('scores.index')->with('success', 'Score is succesvol bijgewerkt.');
    }

    public function destroy($id)
    {
        $score = DB::table('scores')->where('Id', $id)->where('IsActief', 1)->first();

        if (!$score) {
            return redirect()->route('scores.index')->with('error', 'Score niet gevonden of al verwijderd.');
        }

        DB::table('scores')->where('Id', $id)->update([
            'IsActief' => 0,
            'updated_at' => now(),
        ]);

        return redirect()->route('scores.index')->with('success', 'Score succesvol verwijderd.');
    }

}
