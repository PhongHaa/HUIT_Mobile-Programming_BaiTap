import 'package:flutter/material.dart';

class BaiTap7Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // App Bar
              buildAppBar(),
              
              SizedBox(height: 16),
              
              // Album Cover and Song Info
              buildAlbumCard(),
              
              Spacer(),
              
              // Music Player Controls
              buildTimeProgress(),
              
              SizedBox(height: 32),
              
              // Control Buttons
              buildControlButtons(),
              
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.arrow_back, color: Colors.black54),
        ),
        Text(
          'PLAYLIST',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.black54,
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.menu, color: Colors.black54),
        ),
      ],
    );
  }

  Widget buildAlbumCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Album artwork
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://placeholder.com/400x400',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.orangeAccent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_note, size: 60, color: Colors.white70),
                        Text(
                          'Hotel @ Sunset',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: 16),
          
          // Song info and like button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kota The Friend',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Birdie',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTimeProgress() {
    return Column(
      children: [
        // Time display
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0:00',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                Icon(Icons.close, color: Colors.black54),
                SizedBox(width: 16),
                Icon(Icons.repeat, color: Colors.black54),
              ],
            ),
            Text(
              '4:22',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8),
        
        // Progress bar
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Container(
                width: 150, // Adjust for different progress levels
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildControlButton(Icons.skip_previous),
        buildControlButton(Icons.play_arrow, isPlayButton: true),
        buildControlButton(Icons.skip_next),
      ],
    );
  }

  Widget buildControlButton(IconData icon, {bool isPlayButton = false}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        size: isPlayButton ? 42 : 32,
        color: Colors.black87,
      ),
    );
  }
}