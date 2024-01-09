<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('perwalian', function (Blueprint $table) {
            $table->id('IdPerwalian');
            $table->string('NamaMaha');
            $table->string('NimMaha');
            $table->integer('Semester');
            $table->integer('JumlahSks');
            $table->double('Ipk');
            $table->date('TanggalPerwalian');
            $table->string('NoWa');
            $table->string('NamaDoswal');
            $table->string('Masalah');
            $table->string('Rekomendasi');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('perwalian');
    }
};
