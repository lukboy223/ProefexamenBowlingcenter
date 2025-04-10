@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">Scores</div>

                <div class="card-body">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif

                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Persoon</th>
                                    <th>Score</th>
                                    <th>Status</th>
                                    <th>Opmerking</th>
                                    <th>Acties</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($scores as $score)
                                    <tr>
                                        <td>{{ $score->Id ?? $score->id }}</td>
                                        <td>{{ $score->Voornaam ?? '' }} {{ $score->Achternaam ?? '' }}</td>
                                        <td>{{ $score->Score }}</td>
                                        <td>{{ $score->IsActief ? 'Actief' : 'Inactief' }}</td>
                                        <td>{{ $score->Opmerking }}</td>
                                        <td>
                                            <a href="{{ route('scores.show', $score->Id ?? $score->id) }}" class="btn btn-sm btn-info">Details</a>
                                            <a href="{{ route('scores.edit', $score->Id ?? $score->id) }}" class="btn btn-sm btn-primary">Bewerken</a>
                                            <form action="{{ route('scores.destroy', $score->Id ?? $score->id) }}" method="POST" style="display:inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Weet je zeker dat je deze score wilt verwijderen?')">Verwijderen</button>
                                            </form>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="6" class="text-center">Geen scores gevonden</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-center mt-4">
                        {{ $scores->links() }}
                    </div>

                    <div class="mt-3">
                        <a href="{{ route('scores.create') }}" class="btn btn-success">Nieuwe Score Toevoegen</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection