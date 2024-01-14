@extends('layouts.app')

@section('content')

@if ($errors->any())
<div class="alert alert-danger">
    <ul>
        @foreach ($errors->all() as $error)
        <li>{{ $error }}</li>
        @endforeach
    </ul>
</div>
@endif

<div class="row justify-content-center">
    <div class="card col-md-8">
        <div class="card-body">

            <h5 class="card-title fw-bolder mb-4 text-center">Pengisian Perwalian</h5>

            <form method="post" action="{{ route('pages.perwalian.store') }}">
                @csrf

                <div class="mb-3">
                    <label for="NamaMaha" class="form-label">Nama Mahasiswa</label>
                    <input type="text" class="form-control" id="NamaMaha" name="NamaMaha">
                </div>

                <div class="mb-3">
                    <label for="NimMaha" class="form-label">NIM Mahasiswa</label>
                    <input type="text" class="form-control" id="NimMaha" name="NimMaha">
                </div>

                <div class="mb-3">
                    <label for="NamaDoswal" class="form-label">Dosen Wali</label>
                    <input type="text" class="form-control" id="NamaDoswal" name="NamaDoswal">
                </div>

                <div class="mb-3">
                    <label for="Semester" class="form-label">Semester</label>
                    <input type="text" class="form-control" id="Semester" name="Semester">
                </div>

                <div class="mb-3">
                    <label for="JumlahSks" class="form-label">Jumlah SKS</label>
                    <input type="text" class="form-control" id="JumlahSks" name="JumlahSks">
                </div>

                <div class="mb-3">
                    <label for="Ipk" class="form-label">IPK</label>
                    <input type="text" class="form-control" id="Ipk" name="Ipk">
                </div>

                <div class="mb-3">
                    <label for="TanggalPerwalian" class="form-label">Tanggal Perwalian</label>
                    <input type="date" class="form-control" id="TanggalPerwalian" name="TanggalPerwalian">
                </div>

                <div class="mb-3">
                    <label for="NoWa" class="form-label">No. WA</label>
                    <input type="text" class="form-control" id="NoWa" name="NoWa">
                </div>

                <div class="mb-3">
                    <label for="uraian">Uraian</label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="uraian" id="Awal Semester" value="Awal Semester" required>
                        <label class="form-check-label" for="Awal Semester">Awal Semester</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="uraian" id="Sebelum UTS" value="Sebelum UTS" required>
                        <label class="form-check-label" for="Sebelum UTS">Sebelum UTS</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="uraian" id="Sebelum UAS" value="Sebelum UAS" required>
                        <label class="form-check-label" for="Sebelum UAS">Sebelum UAS</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="Masalah" class="form-label">Masalah Akademik</label>
                    <textarea class="form-control" id="Masalah" name="Masalah" rows="3"></textarea>
                </div>

                <!-- <div class="mb-3">
                    <label for="Masalah" class="form-label">Rekomendasi</label>
                    <textarea class="form-control" id="Rekomendasi" name="Rekomendasi" rows="3"></textarea>
                </div> -->

                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Tambah</button>
                </div>
            </form>
        </div>
    </div>
</div>

@stop