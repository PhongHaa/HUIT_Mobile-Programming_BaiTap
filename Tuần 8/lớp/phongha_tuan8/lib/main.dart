import 'package:flutter/material.dart';
import 'media_picker_home.dart';
import 'photo_capture_home.dart';
import 'video_recorder_home.dart'; 
import 'audio_player_home.dart'; 

void main() {
  runApp(const MediaPickerApp());
}

class MediaPickerApp extends StatelessWidget {
  const MediaPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Picker App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// Giao diện chọn bài tập
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn bài tập'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MediaPickerHome()),
                );
              },
              child: const Text('Bài 1: Media Picker'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhotoCaptureHome()),
                );
              },
              child: const Text('Bài 2: Photo Capture'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoRecorderHome()),
                );
              },
              child: const Text('Bài 3: Video Recorder'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AudioPlayerHome()),
                );
              },
              child: const Text('Bài 4: Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
