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

                    <div class="table-responsive"> <!-- Wrap your table with the responsive class -->
                        <table class="table table-hover mt-2">
                            <thead>
                                <tr>
                                    <th>Tanggal</th>
                                    <th>Isi</th>
                                </tr>
                            </thead>

                            <tbody>
                                @php $no = 1; @endphp

                                @foreach ($infos as $info)
                                <tr>
                                    <td>{{ $info->TanggalInfo }}</td>
                                    <td>{{ $info->IsiInfo }}</td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

@stop