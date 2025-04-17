{{-- layout --}}
<x-app-layout>

    {{-- title on the top of the screen --}}
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            reservatie wijzigen
        </h2>
    </x-slot>

    @if (session('error'))

    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative w-3/4 m-auto text-center my-6" role="alert">
        <h3 class="block sm:inline">{{ session('error') }}</h3>
       
    </div>
    @endif
    <div class="overflow-x-auto">
        <form action="{{ route('reservation.update', $Reservation[0]->Id) }} " method="post"
            class="w-3/4 bg-white dark:bg-gray-800 m-auto mt-5 mb-5 p-5 rounded shadow-md just">
            @method('patch')
            @csrf

            <label for="SearchCustomerName">Klantnaam</label>
            @livewire('search-customer')

            <label for="BowlingLaneId">Bowlinglaan type</label>
            <select name="BowlingLaneId" id="BowlingLaneId" class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2"
                required>
                <option value="nothing" selected>Selecteer een baan</option>
                <option value="1" @if($Reservation[0]->LaneNR >= 6) selected @endif class="w-full">normale baan</option>
                <option value="2" @if($Reservation[0]->LaneNR <= 7) selected @endif class="w-full">baan met automatische hekjes</option>
            </select>
            @error('BowlingLaneId')
            <p class="text-red-500">{{ $message }}</p>
            @enderror


            <label for="ReservationDate">Datum</label>
            <input type="date" name="ReservationDate" id="ReservationDate" placeholder="" value="{{ old('ReservationDate', $Reservation[0]->ReservationDate) }}"
                class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2" required>
            @error('ReservationDate  ')
            <p class="text-red-500">{{ $message }}</p>
            @enderror

            <label for="ReservationTime">Tijd</label>
            <input type="time" name="ReservationTime" id="ReservationTime" placeholder="" value="{{ old('ReservationTime', $Reservation[0]->ReservationTime) }}"
                class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2" required>
            @error('ReservationTime')
            <p class="text-red-500">{{ $message }}</p>
            @enderror

            <label for="AmountOfHours">Aantal uren</label>
            <input type="number" name="AmountOfHours" id="AmountOfHours" placeholder="2" value="{{ old('AmountOfHours', $Reservation[0]->AmountOfHours) }}"
                class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2" required>
            @error('AmountOfHours')
            <p class="text-red-500">{{ $message }}</p>
            @enderror

            <label for="Adults">Aantal volwassenen</label>
            <input type="number" name="Adults" id="Adults" placeholder="2" value="{{ old('Adults', $Reservation[0]->Adults) }}"
                class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2" required>
            @error('Adults')
            <p class="text-red-500">{{ $message }}</p>
            @enderror
            <label for="Kids">Aantal kinderen</label>
            <input type="number" name="Kids" id="Kids" placeholder="2" value="{{ old('Kids', $Reservation[0]->Kids) }}"
                class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2" required>
            @error('Kids')
            <p class="text-red-500">{{ $message }}</p>
            @enderror

            <label for="Extra">Extra's</label>
            <select name="Extra" id="Extra" class="w-full p-2 rounded border border-gray-300 dark:border-gray-700 mb-2"
                required>
                <option value="null" selected>Selecteer een extra</option>
                <option value="1"@if($Reservation[0]->ExtraId = 1) selected @endif class="w-full">Snackpakket basis</option>
                <option value="2"@if($Reservation[0]->ExtraId = 2) selected @endif class="w-full">Snackpakket luxe</option>
                <option value="3"@if($Reservation[0]->ExtraId = 3) selected @endif class="w-full">Kinderpartij</option>
                <option value="4"@if($Reservation[0]->ExtraId = 4) selected @endif class="w-full">Vrijgezellenfeest</option>
            </select>
            @error('Extra')
            <p class="text-red-500">{{ $message }}</p>
            @enderror

            
            
            <button type="submit"
                class="bg-green-700 text-white p-2 rounded hover:bg-green-800 dark:hover:bg-green-900">Opslaan</button>
        </form>

        <div class="w-full justify-center flex my-6">
            {{-- button to create a new user --}}
            <a href="{{ route('reservation.index') }}"
                class="bg-blue-700 text-white p-2 rounded hover:bg-blue-800 dark:hover:bg-blue-900">Terug naar
                overzicht</a>

        </div>
    </div>



</x-app-layout>