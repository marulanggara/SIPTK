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

            <h5 class="card-title fw-bolder mb-3">Pengisian Perwalian</h5>

            <form method="post" action="{{ route('pages.perwalian.store') }}">
                @csrf
                <div class="mb-3">
                    <label for="NamaMaha" class="form-label">Nama </label>
                    <input type="text" class="form-control" id="NamaMaha" name="NamaMaha">
                </div>

                <div class="mb-3">
                    <label for="NimMaha" class="form-label">NIM </label>
                    <input type="text" class="form-control" id="NimMaha" name="NimMaha">
                </div>

                <div class="mb-3">
                    <label for="NamaDoswal" class="form-label">Dosen Wali</label>
                    <input type="text" class="form-control" id="NamaDoswal" name="NamaDoswal">
                </div>
                
                <div class="mb-3">
                    <label for="Semester" class="form-label">Semester </label>
                    <input type="text" class="form-control" id="Semester" name="Semester">
                </div>

                <div class="mb-3">
                    <label for="JumlahSks" class="form-label">Jumlah SKS </label>
                    <input type="text" class="form-control" id="JumlahSks" name="JumlahSks">
                </div>

                <div class="mb-3">
                    <label for="Ipk" class="form-label">IPK </label>
                    <input type="text" class="form-control" id="Ipk" name="Ipk">
                </div>
                
                <div class="mb-3">
                    <label for="TanggalPerwalian" class="form-label">Tanggal Perwalian</label>
                    <input type="text" class="form-control" id="TanggalPerwalian" name="TanggalPerwalian">
                </div>

                <div class="mb-3">
                    <label for="NoWa" class="form-label">No.WA</label>
                    <input type="text" class="form-control" id="NoWa" name="NoWa">
                </div>

                <div class="mb-3">
                    <label for="Masalah" class="form-label">Masalah Akademik</label>
                    <input type="text" class="form-control" id="Masalah" name="Masalah">
                </div>
            
                <div class="text-center">
                    <input type="submit" class="btn btn-primary" value="Tambah" />
                </div>
            </form>
        </div>
    </div>
</div>


@stop