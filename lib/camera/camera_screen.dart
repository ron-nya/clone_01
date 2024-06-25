import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> initCamera() async {
    // 카메라 권한 요청
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // 카메라 초기화
      var availableCamera = await availableCameras();
      var camera = availableCamera.first;

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } else if (status.isDenied) {
      // 권한이 거부된 경우 처리
      _showPermissionDeniedDialog();
    } else if (status.isPermanentlyDenied) {
      // 권한이 영구적으로 거부된 경우 설정 화면으로 이동하도록 안내
      openAppSettings();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Denied'),
        content:
            const Text('Please enable camera permission in the app settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _onTapPicture() {
    print('hello');
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      setState(() {
        Navigator.pop(context, image);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        Navigator.pop(context, pickedFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Picture'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: _pickImageFromGallery,
          ),
        ],
      ),
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      CameraPreview(_controller),
                      if (_image != null)
                        Positioned(
                          top: 20,
                          right: 20,
                          child: GestureDetector(
                            onTap: _onTapPicture,
                            child: Image.file(
                              File(_image!.path),
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: _takePicture,
        child: const FaIcon(
          FontAwesomeIcons.camera,
        ),
      ),
    );
  }
}
