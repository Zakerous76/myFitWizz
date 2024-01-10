import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseView extends StatefulWidget {
  final Map<String, dynamic> exercise;

  const ExerciseView({super.key, required this.exercise});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // For demonstration purposes, use a sample video URL.
    // You will need to store and use the actual YouTube video ID for your exercises.
    _controller = YoutubePlayerController(
      initialVideoId: widget
          .exercise[ytLinkFieldname], // Replace with actual YouTube video ID.
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise[nameFieldname])),
      body: SingleChildScrollView(
        child: Padding(
          padding: scaffoldPaddingVar,
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
              ListTile(
                title: const Text('Name'),
                subtitle: Text(widget.exercise[nameFieldname]),
              ),
              ListTile(
                title: const Text('Body Part'),
                subtitle: Text(widget.exercise[bodyPartFieldname]),
              ),
              ListTile(
                title: const Text('Category'),
                subtitle: Text(widget.exercise[categoryFieldname]),
              ),
              const Text(
                'Description: \n\n',
                style: TextStyle(height: 1.5),
              ),
              Text(
                widget.exercise[descriptionFieldname],
                style: const TextStyle(
                  height: 1.55,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
