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
        Schema::create('doswal', function (Blueprint $table) {
            $table->id('IdDoswal');
            $table->string('NamaDoswal');
            $table->string('NipDoswal');
            $table->string('NoWa');
            $table->unsignedInteger('IdMaha');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('doswal');
    }
};
