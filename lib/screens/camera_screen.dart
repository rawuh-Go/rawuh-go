import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  String _errorMessage = '';
  bool _isSelfieMode =
      false; // Tambahkan variabel untuk melacak mode kamera (depan/belakang)

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  // Fungsi untuk memeriksa izin kamera
  Future<void> _checkCameraPermission() async {
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      _initializeCamera();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Izin kamera diperlukan untuk melanjutkan')),
      );
    }
  }

  // Fungsi untuk menginisialisasi kamera
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();

      if (_cameras != null && _cameras!.isNotEmpty) {
        _controller = CameraController(
          _cameras![_isSelfieMode ? 1 : 0], // Pilih kamera depan atau belakang
          ResolutionPreset.high,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );

        await _controller?.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Tidak ada kamera yang tersedia';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal menginisialisasi kamera: $e';
      });
    }
  }

  // Fungsi untuk menangani pergantian kamera
  void _switchCamera() {
    setState(() {
      _isSelfieMode = !_isSelfieMode;
      _initializeCamera(); // Inisialisasi ulang kamera saat ganti mode
    });
  }

  // Fungsi untuk menangkap gambar
  Future<void> _captureImage() async {
    try {
      if (_controller != null && _controller!.value.isInitialized) {
        final image = await _controller!.takePicture();
        // Proses gambar yang diambil sesuai kebutuhan Anda
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto diambil: ${image.path}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil foto: $e')),
      );
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
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.90),
      body: SafeArea(
        child: Column(
          children: [
            // Back button with text History
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    splashColor:
                        Colors.grey.withOpacity(0.3), // Grey splash effect
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'History Attendance',
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: _isCameraInitialized
                  ? Stack(
                      children: [
                        CameraPreview(_controller!), // Display camera preview
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons
                                      .flip_camera_ios), // Button to flip camera
                                  onPressed: _switchCamera,
                                  color: Colors.white,
                                  iconSize: 36,
                                ),
                                FloatingActionButton(
                                  onPressed:
                                      _captureImage, // Function to capture image
                                  backgroundColor:
                                      const Color(
                                      0xFF2A5867), // Green background color
                                  child: const Icon(Icons.camera, size: 36),
                                ),
                                const SizedBox(
                                    width:
                                        36), // Spacer to separate camera and flip buttons
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : const Center(
                          child:
                              CircularProgressIndicator(), // Loading while camera is not initialized
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
