import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart'; // Package untuk menggunakan kamera

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized =
      false; // Tambahkan flag untuk memeriksa apakah kamera terinisialisasi dengan benar
  String _errorMessage = ''; // Tambahkan untuk menampilkan pesan error

  @override
  void initState() {
    super.initState();
    _checkCameraPermission(); // Panggil fungsi pengecekan izin
  }

  // Fungsi untuk memeriksa izin kamera
  Future<void> _checkCameraPermission() async {
    // Meminta izin kamera (gunakan await agar bisa menunggu hasilnya)
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      // Jika izin kamera diberikan, inisialisasi kamera
      _initializeCamera();
    } else {
      // Tampilkan pesan jika izin kamera ditolak
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin kamera diperlukan untuk melanjutkan')),
      );
    }
  }

  // Fungsi untuk menginisialisasi kamera
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras(); // Memperoleh daftar kamera

      if (_cameras != null && _cameras!.isNotEmpty) {
        _controller = CameraController(
          _cameras![0], // Menggunakan kamera pertama
          ResolutionPreset.high,
        );

        // Menunggu inisialisasi kamera selesai
        await _controller?.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized =
                true; // Update flag jika kamera terinisialisasi
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Tidak ada kamera yang tersedia';
        });
      }
    } catch (e) {
      // Tangani error saat inisialisasi kamera
      setState(() {
        _errorMessage = 'Gagal menginisialisasi kamera: $e';
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: _isCameraInitialized
          ? CameraPreview(_controller!) // Menampilkan preview kamera
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : Center(
                  child:
                      CircularProgressIndicator(), // Menampilkan loading saat kamera belum diinisialisasi
                ),
    );
  }
}
