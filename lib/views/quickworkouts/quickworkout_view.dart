import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';

// ignore: must_be_immutable
class QuickWorkoutView extends StatefulWidget {
  final String title;

  String imagePath;

  QuickWorkoutView({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  // ignore: library_private_types_in_public_api
  _QuickWorkoutViewState createState() => _QuickWorkoutViewState();
}

class _QuickWorkoutViewState extends State<QuickWorkoutView> {
  Duration duration = const Duration();
  Timer? timer;
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  void subtractTime() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => subtractTime());
  }

  void resetTimer() {
    setState(() => duration = const Duration());
  }

  void stopTimer() {
    setState(() => timer?.cancel());
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSizeVar = MediaQuery.of(context).size.width * .75;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: scaffoldPaddingVar),
            Image.asset(
              widget.imagePath,
              height: screenSizeVar,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: scaffoldPaddingVar,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTime(),
                    const SizedBox(height: 20),
                    buildTimeInput(),
                    const SizedBox(height: 20),
                    buildButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _hoursController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Hours'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _minutesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Minutes'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _secondsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Seconds'),
          ),
        ),
      ],
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$hours:$minutes:$seconds',
      style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (!isRunning) ...[
          ElevatedButton(
            onPressed: () {
              setState(() {
                final int hours = int.tryParse(_hoursController.text) ?? 0;
                final int minutes = int.tryParse(_minutesController.text) ?? 0;
                final int seconds = int.tryParse(_secondsController.text) ?? 0;
                duration = Duration(
                  hours: hours,
                  minutes: minutes,
                  seconds: seconds,
                );
              });
              startTimer();
            },
            child: const Text('Start Timer'),
          ),
        ],
        if (isRunning) ...[
          ElevatedButton(
            onPressed: stopTimer,
            child: const Text('Pause'),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              stopTimer();
              resetTimer();
            },
            child: const Text('Reset'),
          ),
        ],
      ],
    );
  }
}
