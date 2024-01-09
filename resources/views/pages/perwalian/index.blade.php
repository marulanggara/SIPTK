@extends('layouts.app')

@section('content')

@if($message = Session::get('success'))
<div class="alert alert-success mt-3" role="alert">
    {{ $message }}
</div>
@endif
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header">{{ __('SIPTK') }}</div>

                <div class="card-body">

                    <table class="table table-hover mt-2">
                        <thead>
                            <tr>
                                <th>Nama </th>
                                <th>NIM </th>
                                <th>Dosen Wali </th>
                                <th>Semester </th>
                                <th>JumlahSks </th>
                                <th>IPK </th>
                                <th>Tanggal Perwalian </th>
                                <th>No.WA </th>
                                <th>Masalah Akademik </th>
                                <th>Rekomendasi </th>
                            </tr>
                        </thead>


                        <tbody>
                            @php $no = 1; @endphp

                            @foreach ($perwalians as $perwalian)
                            <tr>
                                <td>{{ $perwalian->NamaMaha }}</td>
                                <td>{{ $perwalian->NimMaha }}</td>
                                <td>{{ $perwalian->NamaDoswal }}</td>
                                <td>{{ $perwalian->Semester }}</td>
                                <td>{{ $perwalian->JumlahSks }}</td>
                                <td>{{ $perwalian->Ipk }}</td>
                                <td>{{ $perwalian->TanggalPerwalian }}</td>
                                <td>{{ $perwalian->NoWa }}</td>
                                <td>{{ $perwalian->Masalah }}</td>
                                <td>{{ $perwalian->Rekomendasi }}</td>

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