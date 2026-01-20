class Lapangan {
  final String? id; // Kita gunakan sebagai referensi ID utama di Flutter
  final String? idLapangan;
  final String? namaLapangan;
  final String? alamat;
  final String? jadwal;

  Lapangan({
    this.id,
    this.idLapangan,
    this.namaLapangan,
    this.alamat,
    this.jadwal,
  });

  // Fungsi untuk mengubah JSON dari API Laravel menjadi Object Flutter
  factory Lapangan.fromJson(Map<String, dynamic> json) {
    return Lapangan(
      // Mapping id_lapangan dari database ke variabel id dan idLapangan
      id: json['id_lapangan']?.toString(),
      idLapangan: json['id_lapangan']?.toString(),
      namaLapangan: json['nama_lapangan']?.toString(),
      alamat: json['alamat']?.toString(),
      jadwal: json['jadwal']?.toString(),
    );
  }

  // Fungsi untuk mengubah Object Flutter menjadi JSON untuk dikirim ke API
  Map<String, dynamic> toJson() {
    return {
      'id_lapangan': idLapangan,
      'nama_lapangan': namaLapangan,
      'alamat': alamat,
      'jadwal': jadwal,
    };
  }
}
