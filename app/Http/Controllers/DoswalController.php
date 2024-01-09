<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doswal;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DoswalController extends Controller
{
    public function index(Doswal $doswalModel)
    {
        $doswals = $doswalModel->get();

        return view('doswal.index')
            ->with('doswals', $doswals);
    }
}
