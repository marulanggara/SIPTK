@extends('layouts.app')

@section('content')

@if($message = Session::get('success'))
<div class="alert alert-success mt-3" role="alert">
    {{ $message }}
</div>
@endif
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">{{ __('SIPTK') }}</div>

                <div class="card-body">
  


                    <table class="table table-hover mt-2">
                        <thead>
                            <tr>
                                <th>No. </th>
                                <th>Nama Mahasiswa </th>
                                <th>NIM Mahasiswa </th>
                                <th>Semester </th>
                                <th>Jumlah SKS </th>
                                <th>IPK </th>
                                <th>Nomor WA </th>
                            </tr>
                        </thead>


                        <tbody>
                            @php $no = 1; @endphp

                            @foreach ($mahasiswas as $mahasiswa)
                            <tr>
                                <td>{{ $no++ }}</td>
                                <td>{{ $mahasiswa->NamaMaha }}</td>
                                <td>{{ $mahasiswa->NimMaha }}</td>
                                <td>{{ $mahasiswa->Semester }}</td>
                                <td>{{ $mahasiswa->JumlahSks }}</td>
                                <td>{{ $mahasiswa->Ipk }}</td>
                                <td>{{ $mahasiswa->NoWa }}</td>
                                
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

@stop