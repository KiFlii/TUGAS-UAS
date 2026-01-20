<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

// Gunakan Anonymous Class (Tanpa nama class 'CreateLapanganTable')
return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lapangan', function (Blueprint $table) {
            // Karena id_lapangan adalah string dan primary key
            $table->string('id_lapangan')->primary();
            $table->string('nama_lapangan');
            $table->string('alamat');
            $table->string('jadwal');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lapangan');
    }
};