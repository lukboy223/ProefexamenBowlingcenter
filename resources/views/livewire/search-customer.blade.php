<div>

    <div class="mt-2">
        <input 
            id="customerSearch"
            type="text" 
            class="p-4 w-full border rounded-md bg-cool-gray-200 text-black"
            wire:model.live.debounce="searchText"
            placeholder="klantnaam zoeken..."
            value="{{ $searchText }}"
        >
    </div>
    <div class="{{ count($results) > 0 ? 'block' : 'hidden' }}">
        <div class="mt-4 absolute w-3/4 bg-[#E7F3FC] dark:bg-gray-800 m-auto mb-5 p-5 rounded shadow-md just">
            <div class="absolute top-0 right-0 pt-2 pr-2">
                <button type="button" wire:click="clearResults">
                    X
                </button>
            </div>
            @if(count($results) === 0)
                <div class="pt-2 text-black dark:text-white">
                    Geen resultaten gevonden
                </div>
            @endif
            @foreach($results as $result)
            <div class="pt-2 text-black dark:text-white" wire:click="selectResult('{{ $result->Id }}')">
                {{$result->FullName}}
            </div>
            @endforeach 
        </div>
        <input type="hidden" id="CustomerId" name="CustomerId" value="{{ $selectedId }}">
    </div>
</div>