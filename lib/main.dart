import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/lapangan_view.dart'; // Import view yang baru dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi Booking Lapangan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Menggunakan warna teal sesuai dengan tema view lapangan Anda
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // Mengarahkan halaman awal ke LapanganView
      home: LapanganView(),
    );
  }
}
