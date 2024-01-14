<?php

use App\Http\Controllers\DoswalController;
use App\Http\Controllers\MahasiswaController;
use App\Http\Controllers\PengumumanController;
use App\Http\Controllers\PerwalianController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// Route::get('/', function () {
// return view('welcome');
// });





Route::get('/', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::middleware(['auth'])->group(function () {
    Route::get('/mahasiswa', [MahasiswaController::class, 'index'])->name('mahasiswa.index');

    Route::get('/doswal', [DoswalController::class, 'index'])->name('doswal.index');
    
    Route::get('/info', [PengumumanController::class, 'index'])->name('pages.info.index');
    // Route::get('/info/add', [PengumumanController::class, 'create'])->name('pages.info.add');
    Route::post('/info/store', [PengumumanController::class, 'store'])->name('pages.info.store');

    Route::get('/perwalian', [PerwalianController::class, 'index'])->name('pages.perwalian.index');
    Route::get('/perwalian/add', [PerwalianController::class, 'create'])->name('pages.perwalian.add');
    Route::post('/perwalian/store', [PerwalianController::class, 'store'])->name('pages.perwalian.store');
});
Auth::routes();