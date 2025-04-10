<x-app-layout>
    <div class="container mx-auto py-8">
        <h1 class="text-2xl font-bold text-center mb-6">Score Bewerken</h1>

        @if(session('error'))
            <div class="bg-red-100 text-red-800 border border-red-200 p-4 rounded mb-4">
                {{ session('error') }}
            </div>
        @endif

        <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-md">
            <form action="{{ route('scores.update', $score->Id) }}" method="POST">
                @csrf
                @method('PUT')
                
                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Reservering</label>
                    <div class="px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                        {{ date('d-m-Y', strtotime($reservation->ReservationDate)) }} - {{ $reservation->FullName }}
                    </div>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Klant</label>
                    <div class="px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                        {{ $person->FirstName ?? $person->first_name ?? '' }} {{ $person->LastName ?? $person->last_name ?? '' }}
                    </div>
                </div>

                <div class="mb-4">
                    <label for="Score" class="block text-gray-700 font-medium mb-2">Score</label>
                    <input type="number" id="Score" name="Score" min="0" max="300" value="{{ old('Score', $score->Score) }}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                           required>
                    @error('Score')
                        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                    @enderror
                </div>

                <div class="flex justify-between">
                    <a href="{{ route('scores.index') }}" 
                       class="bg-gray-500 text-white px-4 py-2 rounded font-medium hover:bg-gray-600">
                        Annuleren
                    </a>
                    <button type="submit" 
                            style="background-color: #001f3d;"
                            class="text-white px-4 py-2 rounded font-medium hover:opacity-90">
                        Opslaan
                    </button>
                </div>
            </form>
        </div>
    </div>
</x-app-layout>