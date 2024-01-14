<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pengumuman;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class PengumumanController extends Controller
{
    //
    public function index(Pengumuman $pengumuman)
    {
        $infos = $pengumuman->get();

        return view('pages.info.index')
            ->with('infos', $infos);
    }

    // public function create()
    // {
    //     return view('pages.info.add');
    // }

    public function store(Request $request, Pengumuman $pengumuman)
    {
        $request->validate([
            'TanggalInfo' => 'nullable',
            'IsiInfo' => 'required',
        ]);

        $pengumuman->create([
            'TanggalInfo' => $request->TanggalInfo,
            'IsiInfo' => $request->IsiInfo,
        ]);

        return redirect()->route('pages.info.index')->with('success', 'Data berhasil disimpan');
    }
}
