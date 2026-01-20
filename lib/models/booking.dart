class Booking {
  final int? id; // Tetap int karena ini biasanya auto-increment ID di database
  final String? idBooking;
  final String? waktuBooking;
  final String? hargaBooking;
  final String? buktiBayar;

  Booking({
    this.id,
    this.idBooking,
    this.waktuBooking,
    this.hargaBooking,
    this.buktiBayar,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id_booking'],
      idBooking: json['id_booking']?.toString(), // Memastikan jadi string
      waktuBooking: json['waktu_booking']?.toString(),
      hargaBooking: json['harga_booking']?.toString(),
      buktiBayar: json['bukti_bayar']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_booking': idBooking,
      'waktu_booking': waktuBooking,
      'harga_booking': hargaBooking,
      'bukti_bayar': buktiBayar,
    };
  }
}
