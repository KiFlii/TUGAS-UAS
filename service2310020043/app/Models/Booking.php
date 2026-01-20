<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    use HasFactory;

    // Nama tabel di database
    protected $table = 'booking'; 
    
    
    // Primary key jika bukan 'id'
    protected $primaryKey = 'id_booking'; 

    // Kolom yang boleh diisi (WAJIB ADA)
    protected $fillable = [
        'id_booking',
        'waktu_booking', 
        'harga_booking', 
        'bukti_bayar'
    ];
}