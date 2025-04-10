<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Contact as Search;
use App\Models\User;
use App\Models\Customer;
use Illuminate\Support\Facades\Log;
use Livewire\Attributes\Validate;

class SearchCustomer extends Component
{
    #[Validate('required')]
    public $searchText = '';
    public $results = [];
    public $selectedId = null; // This will hold the ID of the selected result


    protected $listeners = ['resultSelected' => 'updateSearchBar'];


    public function selectResult($id)
    {
    
        // Check if the ID is null or empty
        if (is_null($id) || empty($id)) {
            Log::error('ID is null or invalid');
            throw new \Exception('ID is null or invalid');
        }else{
            // Find the result by ID and set the search text
            $this->selectedId = $id;
            
            $this->searchText = Search::find($id)->FullName;

        }
  

    }

    public function updatedSearchText($value) 
    {
        $this->reset('results');

        $this->validate();

        $searchTerm = "{$value}%";

        $this->results = Search::where('FullName', 'LIKE', $searchTerm)->get();

    }

    public function clearResults() 
    {
        $this->reset('results', 'searchText');
    }

    public function updateSearchBar($result)
    {
        $this->searchText = $result['FullName'];
        
        // Voeg hier code toe om andere gegevens bij te werken
    }

    public function render()
    {
        return view('livewire.search-customer', [
            'results' => $this->results // Pass the results to the view,
            ,'searchText' => $this->searchText // Pass the search text to the view
        ],);


    }
}
