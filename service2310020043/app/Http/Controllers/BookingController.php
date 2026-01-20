<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use Illuminate\Http\Request;

class BookingController extends Controller
{
    // Mengambil semua data produk [cite: 31, 86]
    public function index()
    {
        return Booking::all();
    }

    // Menyimpan data produk baru [cite: 32, 86]
    public function store(Request $request)
    {
        $request->validate([
            'id_booking' => 'required|string',
            'waktu_booking'    => 'required|string',
            'harga_booking'       => 'required|string',
            'bukti_bayar'        => 'required|string',
        ]);

        $booking = Booking::create($request->all());
        return response()->json($booking, 201);
    }

    // Menampilkan detail satu produk [cite: 33, 87]
    public function show($id)
    {
        return Booking::findOrFail($id);
    }

    // Memperbarui data produk [cite: 33, 88]
    public function update(Request $request, $id)
    {
        $booking = Booking::findOrFail($id);
        
        $booking->update($request->all());
        return response()->json($booking, 200);
    }

    // Menghapus data produk [cite: 34, 89]
    public function destroy($id)
    {
        $booking = Booking::findOrFail($id);
        $booking->delete();

        return response()->json(null, 204);
    }
}