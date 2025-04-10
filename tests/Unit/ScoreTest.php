<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\Score;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ScoreTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function een_score_kan_worden_aangemaakt()
    {
        $score = Score::create([
            'PeopleId' => 1,
            'Score' => 150
        ]);

        $this->assertDatabaseHas('scores', [
            'PeopleId' => 1,
            'Score' => 150
        ]);
    }

    /** @test */
    public function een_score_kan_worden_gelezen()
    {
        $score = Score::factory()->create([
            'PeopleId' => 1,
            'Score' => 150
        ]);

        $found = Score::find($score->id);

        $this->assertEquals(150, $found->Score);
    }

    /** @test */
    public function een_score_kan_worden_bijgewerkt()
    {
        $score = Score::factory()->create([
            'PeopleId' => 1,
            'Score' => 150
        ]);

        $score->update(['Score' => 200]);

        $this->assertDatabaseHas('scores', [
            'id' => $score->id,
            'Score' => 200
        ]);
    }

    /** @test */
    public function een_score_kan_worden_verwijderd()
    {
        $score = Score::factory()->create();

        $score->delete();

        $this->assertDatabaseMissing('scores', [
            'id' => $score->id
        ]);
    }
}
