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
        Schema::table('perwalian', function (Blueprint $table) {
            //
            $table->enum('uraian', ['Awal Semester', 'Sebelum UTS', 'Sebelum UAS'])->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('perwalian', function (Blueprint $table) {
            //
        });
    }
};
