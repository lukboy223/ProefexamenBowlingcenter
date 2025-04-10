<x-app-layout>
<body class="bg-gray-100 text-white-800">
    <div class="container mx-auto py-8">
        <h1 class="text-bordeaux text-2xl font-bold text-center mb-6">Scores overzicht</h1>

        <!-- Bericht weergeven als een sessie een 'success'-bericht bevat -->
        @if(session()->has('success'))
            <div class="bg-green-100 text-green-800 border border-green-200 p-4 rounded mb-4">
                {{ session('success') }}
            </div>
        @endif

        <!-- Tabel met alle scores -->
        <div class="overflow-x-auto mx-auto max-w-6xl">
            <table class="table-auto w-full bg-white border-collapse border border-gray-200 shadow-md">
                <thead style="background-color: #001f3d;" class="text-white">
                    <tr>
                        <th class="px-4 py-2 border border-gray-300">Datum</th>
                        <th class="px-4 py-2 border border-gray-300">Naam</th>
                        <th class="px-4 py-2 border border-gray-300">Score</th>
                        <th class="px-4 py-2 border border-gray-300">Acties</th>
                    </tr>
                </thead>
                <tbody>
                    @if($scores->isEmpty())
                        <tr>
                            <td class="px-4 py-2 border border-gray-300 text-center bg-blue-100 align-middle h-16" colspan="4">Er zijn geen scores beschikbaar.</td>
                        </tr>
                    @else
                        @foreach($scores as $score)
                            <tr class="text-center hover:bg-gray-50">
                                <td class="px-4 py-2 border border-gray-300">{{ $scores->created_at ? date('d-m-Y', strtotime($score->created_at)) : 'Geen datum' }}</td>
                                <td class="px-4 py-2 border border-gray-300">{{ $scores->FirstName ?? '' }} {{ $score->Infix ?? '' }} {{ $score->LastName ?? '' }}</td>
                                <td class="px-4 py-2 border border-gray-300">{{ $scores->Score }}</td>
                                <td class="px-4 py-2 border border-gray-300 space-x-2">
                                    <a href="{{ route('scores.show', $score->Id ?? $score->id) }}" 
                                       class="bg-blue-500 text-white px-2 py-1 rounded text-xs font-medium inline-block">Details</a>
                                    <a href="{{ route('scores.edit', $score->Id ?? $score->id) }}" 
                                       class="bg-yellow-500 text-white px-2 py-1 rounded text-xs font-medium inline-block">Bewerken</a>
                                    <form action="{{ route('scores.destroy', $score->Id ?? $score->id) }}" method="POST" class="inline-block">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" 
                                                class="bg-red-500 text-white px-2 py-1 rounded text-xs font-medium"
                                                onclick="return confirm('Weet je zeker dat je deze score wilt verwijderen?')">
                                            Verwijderen
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        @endforeach
                    @endif
                </tbody>
            </table>
            
            <!-- Knoppen onderaan -->
            <div class="flex justify-between mt-4">
                <a href="{{ route('scores.create') }}"
                   style="background-color: #001f3d;"
                   class="text-white px-6 py-2 rounded font-semibold shadow-md transition">
                    Nieuwe Score Toevoegen
                </a>
                <a href="/"
                   style="background-color: #001f3d;" 
                   class="text-white px-6 py-2 rounded font-semibold shadow-md transition">
                    Home pagina
                </a>
            </div>
            
            <!-- Paginatie Links -->
            <div class="mt-6">
                {{ $scores->links() }}
            </div>
        </div>
    </div>
</body>
</x-app-layout>