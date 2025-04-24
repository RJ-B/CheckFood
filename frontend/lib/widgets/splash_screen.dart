import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:frontend/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/logo.mp4')
      ..initialize().then((_) {
        setState(() {}); // Toto zajistí, že video se zobrazí po inicializaci
        _controller.play();
      });

    _controller.setLooping(false);

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Bílé pozadí před videem
      body:
          _controller.value.isInitialized
              ? SizedBox.expand(
                // Video pokrývá celou obrazovku
                child: FittedBox(
                  fit:
                      BoxFit
                          .cover, // Video se roztáhne, aby pokrylo celou obrazovku
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
              : Container(), // Žádný načítací kruh, pouze bílá obrazovka
    );
  }
}
