<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pengumuman extends Model
{
    use HasFactory;

    protected $table = 'pengumuman';
    protected $fillable = ['TanggalInfo', 'IsiInfo'];
    public $timestamps = false; // Sesuaikan berdasarkan kebutuhan Anda
    protected $primaryKey = 'IdInfo'; // Sesuaikan dengan nama kolom primary key
}