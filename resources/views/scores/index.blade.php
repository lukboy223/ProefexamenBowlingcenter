<x-app-layout>
<body class="bg-gray-100 text-white-800">
    <div class="container mx-auto py-8">
        <h1 class="text-bordeaux text-2xl font-bold text-center mb-6">Score overzicht</h1>

        <!-- Knop om naar create pagina te gaan -->
        <div class="flex justify-end mx-auto max-w-6xl mb-4">
            <a href="{{ route('scores.create') }}" 
               style="background-color:rgb(255, 255, 255);" 
               class="text-black px-4 py-2 rounded font-semibold shadow-md transition">
                Nieuwe score toevoegen
            </a>
        </div>

        <!-- Bericht weergeven als een sessie een 'success'-bericht bevat -->
        @if(session()->has('success'))
            <div class="bg-green-100 text-green-800 border border-green-200 p-4 rounded mb-4">
                {{ session('success') }}
            </div>
        @endif

        <!-- Bericht weergeven als een sessie een 'error'-bericht bevat -->
        @if(session('error'))
            <div class="alert alert-danger">
                {{ session('error') }}
            </div>
        @endif

        <!-- Tabel met alle reizen -->
        <div class="overflow-x-auto mx-auto max-w-6xl">
            <table class="table-auto w-full bg-white border-collapse border border-gray-200 shadow-md">
                <thead style="background-color:rgb(255, 255, 255);" class="text-white">
                    <tr>
                        <th class="px-4 py-2 text-black border border-gray-300">Datum reservering</th>
                        <th class="px-4 py-2 text-black border border-gray-300">Naam</th>
                        <th class="px-4 py-2 text-black border border-gray-300">Score</th>
                        <th class="px-4 py-2 text-black border border-gray-300">Aanpassen</th>
                        <th class="px-4 py-2 text-black border border-gray-300">Annuleren</th>
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
                        <td class="px-4 py-2 border border-gray-300">{{ date('d-m-Y', strtotime($score->ReservationDate)) }}</td>
                        <td class="px-4 py-2 border border-gray-300">{{ $score->CustomerName }}</td>
                        <td class="px-4 py-2 border border-gray-300">{{ $score->Score }}</td>
                        <td class="px-4 py-2 border border-gray-300">
                            <a href="{{ route('scores.edit', $score->Id) }}" 
                               class="bg-yellow-500 text-white px-2 py-1 rounded text-xs font-medium">Aanpassen</a>
                        </td>
                        <td class="px-4 py-2 border border-gray-300">
                            <form action="{{ route('scores.destroy', $score->Id) }}" method="POST" onsubmit="event.preventDefault(); openDeleteModal(this);">
                                @csrf
                                @method('DELETE')
                                <button type="submit" 
                                    class="bg-red-500 text-white px-2 py-1 rounded text-xs font-medium">
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
                    style="background-color:rgb(255, 255, 255);" 
                    class="text-black px-6 py-2 rounded font-semibold shadow-md transition">Home pagina</a>
            </div>
            <!-- Paginatie Links -->
            <div class="mt-6">
                {{ $scores->links() }}
            </div>

            <!-- Modal for delete confirmation -->
            <div id="deleteConfirmModal" class="fixed inset-0 flex items-center justify-center z-50 hidden">
                <div class="bg-black bg-opacity-50 absolute inset-0"></div>
                <div class="bg-white p-6 rounded-lg shadow-lg z-10 max-w-md w-full">
                    <h3 class="text-lg font-bold mb-4">Bevestiging</h3>
                    <p class="mb-6">Weet je zeker dat je deze score wilt verwijderen?</p>
                    <div class="flex justify-end space-x-3">
                        <button id="cancelDelete" type="button" 
                                class="bg-gray-300 text-gray-800 px-4 py-2 rounded font-medium hover:bg-gray-400" onclick="closeDeleteModal();">
                            Annuleren
                        </button>
                        <button id="confirmDelete" type="button" 
                                class="bg-red-500 text-white px-4 py-2 rounded font-medium hover:bg-red-600" onclick="deleteForm.submit(); closeDeleteModal();">
                            Verwijderen
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for the modal -->
    <script>
        // Store the form that needs to be submitted
        let deleteForm = null;
        
        // Function to open the modal
        function openDeleteModal(form) {
            deleteForm = form;
            document.getElementById('deleteConfirmModal').classList.remove('hidden');
        }
        
        // Function to close the modal
        function closeDeleteModal() {
            deleteForm = null;
            document.getElementById('deleteConfirmModal').classList.add('hidden');
        }
    </script>
</body>
</x-app-layout>