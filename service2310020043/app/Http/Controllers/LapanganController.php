<?php

namespace App\Http\Controllers;

use App\Models\Lapangan;
use Illuminate\Http\Request;

class LapanganController extends Controller
{
    // 1. Mengambil semua data lapangan
    public function index()
    {
        return response()->json(Lapangan::all(), 200);
    }

    // 2. Menyimpan data lapangan baru
    public function store(Request $request)
    {
        $request->validate([
            'id_lapangan'    => 'required|string|unique:lapangan,id_lapangan',
            'nama_lapangan'  => 'required|string',
            'alamat'         => 'required|string',
            'jadwal'         => 'required|string',
        ]);

        $lapangan = Lapangan::create($request->all());
        return response()->json($lapangan, 201);
    }

    // 3. Menampilkan detail satu lapangan
    public function show($id)
    {
        $lapangan = Lapangan::findOrFail($id);
        return response()->json($lapangan, 200);
    }

    // 4. Memperbarui data lapangan
    public function update(Request $request, $id)
    {
        $lapangan = Lapangan::findOrFail($id);

        $request->validate([
            'nama_lapangan'  => 'required|string',
            'alamat'         => 'required|string',
            'jadwal'         => 'required|string',
        ]);

        $lapangan->update($request->all());
        return response()->json($lapangan, 200);
    }

    // 5. Menghapus data lapangan
    public function destroy($id)
    {
        $lapangan = Lapangan::findOrFail($id);
        $lapangan->delete();

        return response()->json(['message' => 'Data lapangan berhasil dihapus'], 200);
    }
}