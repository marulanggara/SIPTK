<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Mahasiswa;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class MahasiswaController extends Controller
{
    public function index(Mahasiswa $mahasiswaModel)
    {
        $mahasiswas = $mahasiswaModel->get();

        return view('mahasiswa.index')
            ->with('mahasiswas', $mahasiswas);
    }
}
