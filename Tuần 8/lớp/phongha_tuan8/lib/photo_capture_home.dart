import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(PhotoCaptureApp());
}

class PhotoCaptureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Capture & Preview',
      theme: ThemeData(primarySwatch: Colors.green),
      home: PhotoCaptureHome(),
    );
  }
}

class PhotoCaptureHome extends StatefulWidget {
  @override
  _PhotoCaptureHomeState createState() => _PhotoCaptureHomeState();
}

class _PhotoCaptureHomeState extends State<PhotoCaptureHome> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  // Yêu cầu quyền
  Future<void> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  // Chọn ảnh từ gallery
  Future<void> _pickImageFromGallery() async {
    await _requestPermission(Permission.photos);
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Chụp ảnh từ camera
  Future<void> _captureImageFromCamera() async {
    await _requestPermission(Permission.camera);
    final XFile? capturedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (capturedFile != null) {
      setState(() {
        _imageFile = File(capturedFile.path);
      });
    }
  }

  // Xem trước ảnh toàn màn hình
  void _showFullScreenPreview(BuildContext context) {
    if (_imageFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenImage(imageFile: _imageFile!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo Capture & Preview')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? Text('Chưa có ảnh nào được chọn.')
                : GestureDetector(
                  onTap: () => _showFullScreenPreview(context),
                  child: Image.file(_imageFile!, height: 300),
                ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: Text('Chọn ảnh từ Gallery'),
            ),
            ElevatedButton(
              onPressed: _captureImageFromCamera,
              child: Text('Chụp ảnh từ Camera'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget xem trước toàn màn hình
class FullScreenImage extends StatelessWidget {
  final File imageFile;
  FullScreenImage({required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Xem trước')),
      body: Center(child: Image.file(imageFile)),
    );
  }
}
