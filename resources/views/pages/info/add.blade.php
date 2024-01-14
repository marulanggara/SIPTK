<!-- @extends('layouts.app')

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

            <form method="post" action="{{ route('pages.info.store') }}">
                @csrf
                <div class="mb-3">
                    <label for="TanggalInfo" class="form-label">Tanggal Pengumuman </label>
                    <input type="text" class="form-control" id="TanggalInfo" name="TanggalInfo">
                </div>

                <div class="mb-3">
                    <label for="IsiInfo" class="form-label">Isi Pengumuman </label>
                    <input type="text" class="form-control" id="IsiInfo" name="IsiInfo">
                </div>

                <div class="text-center">
                    <input type="submit" class="btn btn-primary" value="Kirim" />
                </div>
            </form>
        </div>
    </div>
</div>


@stop -->