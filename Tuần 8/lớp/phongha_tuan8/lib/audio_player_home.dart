import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(SimpleAudioPlayer());
}

class SimpleAudioPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Audio Player',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AudioPlayerHome(),
    );
  }
}

class AudioPlayerHome extends StatefulWidget {
  @override
  _AudioPlayerHomeState createState() => _AudioPlayerHomeState();
}

class _AudioPlayerHomeState extends State<AudioPlayerHome> {
  late AudioPlayer _audioPlayer;
  int _currentSongIndex = 0;
  bool _isPlaying = false;
  // Danh sách các bài hát (từ assets)
  final List<String> _songs = [
    'assets/audios/sample1.mp3',
    'assets/audios/sample2.mp3',
    'assets/audios/sample3.mp3',
  ];
  // Tên bài hát để hiển thị
  final List<String> _songTitles = ['sample1', 'sample2', 'sample3'];
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // Lắng nghe trạng thái phát
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    // Lắng nghe khi bài hát kết thúc
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong(); // Tự động chuyển bài khi hết
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Phát bài hát
  Future<void> _playSong() async {
    await _audioPlayer.play(
      AssetSource(_songs[_currentSongIndex].replaceAll('assets/', '')),
    );
    setState(() {
      _isPlaying = true;
    });
  }

  // Tạm dừng bài hát
  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  // Dừng bài hát
  Future<void> _stopSong() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  // Chuyển sang bài tiếp theo
  void _nextSong() {
    setState(() {
      if (_currentSongIndex < _songs.length - 1) {
        _currentSongIndex++;
      } else {
        _currentSongIndex = 0; // Quay lại bài đầu nếu hết danh sách
      }
      _stopSong(); // Dừng bài hiện tại trước khi phát bài mới
      _playSong();
    });
  }

  // Quay lại bài trước
  void _previousSong() {
    setState(() {
      if (_currentSongIndex > 0) {
        _currentSongIndex--;
      } else {
        _currentSongIndex =
            _songs.length - 1; // Chuyển đến bài cuối nếu đang ở đầu
      }
      _stopSong(); // Dừng bài hiện tại trước khi phát bài mới
      _playSong();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Audio Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị tên bài hát
            Text(
              _songTitles[_currentSongIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Nút điều khiển
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 40),
                  onPressed: _previousSong,
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                  ),
                  onPressed: () {
                    if (_isPlaying) {
                      _pauseSong();
                    } else {
                      _playSong();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop, size: 40),
                  onPressed: _stopSong,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 40),
                  onPressed: _nextSong,
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
