<x-app-layout>
    <div class="container mx-auto py-8">
        <h1 class="text-2xl font-bold text-center mb-6">Nieuwe Score Toevoegen</h1>

        @if(session('error'))
            <div class="bg-red-100 text-red-800 border border-red-200 p-4 rounded mb-4">
                {{ session('error') }}
            </div>
        @endif

        <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-md">
            <form action="{{ route('scores.store') }}" method="POST">
                @csrf
                
                <div class="mb-4">
                    <!-- <label for="ReservationId" class="block text-gray-700 font-medium mb-2">Reservering</label>
                    <select id="ReservationId" name="ReservationId" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required>
                        <option value="">Selecteer een reservering</option>
                        @foreach($reservations as $reservation)
                            <option value="{{ $reservation->ReservationId }}" {{ old('ReservationId') == $reservation->ReservationId ? 'selected' : '' }}>
                                {{ date('d-m-Y', strtotime($reservation->ReservationDate)) }} - {{ $reservation->FullName }}
                            </option>
                        @endforeach
                    </select>
                    @error('ReservationId')
                        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                    @enderror
                </div>

                <div class="mb-4">
                    <label for="PeopleId" class="block text-gray-700 font-medium mb-2">Klant</label>
                    <select id="PeopleId" name="PeopleId" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required>
                        <option value="">Selecteer een klant</option>
                        @foreach($people as $person)
                            <option value="{{ $person->Id }}" {{ old('PeopleId') == $person->Id ? 'selected' : '' }}>
                                {{ $person->FirstName ?? $person->firstname ?? $person->first_name ?? 'Unknown' }} 
                                {{ $person->LastName ?? $person->lastname ?? $person->last_name ?? '' }}
                            </option>
                        @endforeach
                    </select>
                    @error('PeopleId')
                        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                    @enderror
                </div> -->

                <div class="mb-4">
                    <label for="PeopleId" class="block text-gray-700 font-medium mb-2">Klant</label>
                    <select id="PeopleId" name="PeopleId" 
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required>
                        <option value="">Selecteer een klant</option>
                        @foreach($people as $person)
                            <option value="{{ $person->Id }}" {{ old('PeopleId') == $person->Id ? 'selected' : '' }}>
                                {{ $person->FirstName ?? $person->firstname ?? $person->first_name ?? 'Unknown' }} 
                                {{ $person->LastName ?? $person->lastname ?? $person->last_name ?? '' }}
                            </option>
                        @endforeach
                    </select>
                    @error('PeopleId')
                        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                    @enderror
                </div>

                <div class="mb-4">
                    <label for="Score" class="block text-gray-700 font-medium mb-2">Score</label>
                    <input type="number" id="Score" name="Score" min="0" max="300" value="{{ old('Score') }}"
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
