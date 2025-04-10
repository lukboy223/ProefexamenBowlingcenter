<x-app-layout>
<body class="bg-gray-100 text-white-800">
    <div class="container mx-auto py-8">
        <h1 class="text-bordeaux text-2xl font-bold text-center mb-6">Score overzicht</h1>

        <!-- Bericht weergeven als een sessie een 'success'-bericht bevat -->
        @if(session()->has('success'))
            <div class="bg-green-100 text-green-800 border border-green-200 p-4 rounded mb-4">
                {{ session('success') }}
            </div>
        @endif

        <!-- Tabel met alle reizen -->
        <div class="overflow-x-auto mx-auto max-w-6xl">
            <table class="table-auto w-full bg-white border-collapse border border-gray-200 shadow-md">
                <thead style="background-color: #001f3d;" class="text-white">
                    <tr>
                        <th class="px-4 py-2 border border-gray-300">Datum reservering</th>
                        <th class="px-4 py-2 border border-gray-300">Naam</th>
                        <th class="px-4 py-2 border border-gray-300">Score</th>
                        <th class="px-4 py-2 border border-gray-300">Aanpassen</th>
                        <th class="px-4 py-2 border border-gray-300">Annuleren</th>
                    </tr>
                </thead>
                <tbody>
                    @if($scores->isEmpty())
                        <tr>
                            <td class="px-4 py-2 border border-gray-300 text-center bg-blue-100 align-middle h-16" colspan="8">Er is geen data beschikbaar.</td>
                        </tr>
                    @else
                    @foreach($scores as $score)
                    <tr class="text-center hover:bg-gray-50">
                        <td class="px-4 py-2 border border-gray-300">{{ $score->created_at ? date('d-m-Y', strtotime($score->created_at)) : 'Geen datum' }}</td>
                        <td class="px-4 py-2 border border-gray-300">{{ $score->FirstName ?? '' }} {{ $score->Infix ?? '' }} {{ $score->LastName ?? '' }}</td>
                        <td class="px-4 py-2 border border-gray-300">{{ $score->Score }}</td>
                        <td class="px-4 py-2 border border-gray-300">
                            <a href="{{ route('scores.edit', $score->Id ?? $score->id) }}" 
                            class="bg-yellow-500 text-white px-2 py-1 rounded text-xs font-medium">Aanpassen</a>
                        </td>
                        <td class="px-4 py-2 border border-gray-300">
                            <form action="{{ route('scores.destroy', $score->Id ?? $score->id) }}" method="POST">
                                @csrf
                                @method('DELETE')
                                <button type="submit" 
                                    class="bg-red-500 text-white px-2 py-1 rounded text-xs font-medium"
                                    onclick="return confirm('Weet je zeker dat je deze score wilt verwijderen?')">
                                    Annuleren
                                </button>
                            </form>
                        </td>
                    </tr>
                    @endforeach
                    @endif
                </tbody>
            </table>
                <!-- Knop naar homepage -->
                <div class="flex justify-end mt-4">
                <a href="/"
                    style="background-color: #001f3d;" 
                    class="text-white px-6 py-2 rounded font-semibold shadow-md transition">Home pagina</a>
            </div>
            <!-- Paginatie Links -->
            <div class="mt-6">
                {{ $scores->links() }}
            </div>
    </div>
    </div>
</x-app-layout>