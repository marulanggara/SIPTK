<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Perwalian extends Model
{
    use HasFactory;

    protected $table = 'perwalian';
    public $timestamps = false;
    protected $fillable = ['NamaMaha', 'NimMaha', 'NamaDoswal', 'Semester', 'JumlahSks', 'Ipk', 'TanggalPerwalian', 'NoWa', 'Masalah', 'uraian'];
}
