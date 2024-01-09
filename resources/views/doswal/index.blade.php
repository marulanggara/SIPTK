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
                                <th>Nama Dosen </th>
                                <th>NIP Dosen </th>
                                <th>Nomor WA </th>
                            </tr>
                        </thead>


                        <tbody>
                            @php $no = 1; @endphp

                            @foreach ($doswals as $doswal)
                            <tr>
                                <td>{{ $no++ }}</td>
                                <td>{{ $doswal->NamaDoswal }}</td>
                                <td>{{ $doswal->NipDoswal }}</td>
                                <td>{{ $doswal->NoWa }}</td>

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