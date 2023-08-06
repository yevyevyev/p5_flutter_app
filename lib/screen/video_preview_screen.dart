import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPreviewScreen extends StatefulWidget {
  const VideoPreviewScreen({super.key, required this.filepath});

  final String filepath;

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final videoPlayerController =
      VideoPlayerController.file(File(widget.filepath));

  late final chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: true,
    looping: true,
    autoInitialize: true,
  );

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  String get filename => widget.filepath.split('/').last;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          filename,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
