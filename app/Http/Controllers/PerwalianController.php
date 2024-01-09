<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Perwalian;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class PerwalianController extends Controller
{
    //
    public function index(Perwalian $perwalianModel)
    {
        $perwalians = $perwalianModel->get();

        return view('pages.perwalian.index')
            ->with('perwalians', $perwalians);
    }
    public function create()
    {
        return view('pages.perwalian.add');
    }

    public function store(Request $request)
    {
        $request->validate([
            'NamaMaha' => 'required',
            'NimMaha' => 'required',
            'Semester' => 'required',
            'JumlahSks' => 'required',
            'Ipk' => 'required',
            'TanggalPerwalian' => 'nullable',
            'NoWa' => 'required',
            'NamaDoswal' => 'required',
            'Masalah' => 'required',
            'Rekomendasi'=> 'nullable'


        ]);

        DB::insert('INSERT INTO perwalian(NamaMaha, NimMaha, Semester, JumlahSks, Ipk, TanggalPerwalian, NoWa, NamaDoswal, Masalah, Rekomendasi) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
        [
            $request->NamaMaha,
            $request->NimMaha,
            $request->Semester,
            $request->JumlahSks,
            $request->Ipk,
            date("Y-m-d"), // Add the closing parenthesis for date() function
            $request->NoWa,
            $request->NamaDoswal,
            $request->Masalah,
            $request->Rekomendasi
        ]);


        return redirect()->route('pages.perwalian.index')->with('success', 'Data berhasil disimpan');
    }
}
