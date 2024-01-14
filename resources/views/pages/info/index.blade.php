@extends('layouts.app')

@section('content')

@if($message = Session::get('success'))
<div class="alert alert-success mt-3" role="alert">
    {{ $message }}
</div>
@endif
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">{{ __('SIPTK') }}</div>

                <div class="card-body">
                    <div class="table-responsive">
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
                                                <td>
                                                    <p>{{ $info->IsiInfo }}</p>
                                                </td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                    <hr>

                    <!-- Formulir Penambahan Pengumuman -->
                    <form action="{{ route('pages.info.store') }}" method="post">
                        @csrf

                        <div class="form-group">
                            <label for="isi">Isi Pengumuman:</label>
                            <textarea class="form-control" id="isi" name="IsiInfo" rows="3" required></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Tambah Pengumuman</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@stop