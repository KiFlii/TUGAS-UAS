<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lapangan extends Model
{
    use HasFactory;

    protected $table = 'lapangan';
    protected $primaryKey = 'id_lapangan';
    
    // Beritahu Laravel bahwa primary key bukan integer auto-increment
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'id_lapangan',
        'nama_lapangan',
        'alamat',
        'jadwal'
    ];
}