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
        Schema::create('mahasiswa', function (Blueprint $table) {
            $table->increments('IdMaha');
            $table->string('NamaMaha');
            $table->string('NimMaha');
            $table->integer('Semester');
            $table->integer('JumlahSks');
            $table->double('Ipk');
            $table->string('NoWa');
            $table->unsignedInteger('IdDoswal');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mahasiswa');
    }
};
