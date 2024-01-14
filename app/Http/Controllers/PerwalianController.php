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

    public function store(Request $request, Perwalian $perwalianModel)
    {
        $request->validate([
            'NamaMaha' => 'required',
            'NimMaha' => 'required',
            'Semester' => 'required',
            'JumlahSks' => 'required',
            'Ipk' => 'required',
            'TanggalPerwalian' => 'nullable|date',
            'NoWa' => 'required',
            'NamaDoswal' => 'required',
            'Masalah' => 'required',
            'uraian' => 'required|in:Awal Semester, Sebelum UTS, Sebelum UAS',
            'Rekomendasi' => 'nullable'
        ]);

        $perwalianModel->create([
            'NamaMaha' => $request->NamaMaha,
            'NimMaha' => $request->NimMaha,
            'Semester' => $request->Semester,
            'JumlahSks' => $request->JumlahSks,
            'Ipk' => $request->Ipk,
            'TanggalPerwalian' => $request->TanggalPerwalian,
            'NoWa' => $request->NoWa,
            'NamaDoswal' => $request->NamaDoswal,
            'Masalah' => $request->Masalah,
            'uraian' => $request->uraian,
            'Rekomendasi' => $request->Rekomendasi,
        ]);

        return redirect()->route('pages.perwalian.index')->with('success', 'Data berhasil disimpan');
    }
}
