import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

void main() => runApp(BirthdayApp());

class BirthdayApp extends StatefulWidget {
  @override
  _BirthdayAppState createState() => _BirthdayAppState();
}

class _BirthdayAppState extends State<BirthdayApp> {
  TextEditingController _controller = TextEditingController();
  String displayText = "Enter your birthdate";
  bool isEncoded = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Birthday App")),
        body: SingleChildScrollView( // Make content scrollable
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display GIF
                Image.asset('assets/birthday_cake.gif'),
                SizedBox(height: 20),

                // Input for birthdate
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Enter your birthdate (YYYY-MM-DD)",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Display the encoded/decoded birthdate
                Text(
                  displayText,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),

                // Button to toggle Base64 encoding/decoding
                ElevatedButton(
                  onPressed: _toggleBase64,
                  child: Text("Toggle Base64"),
                ),

                // Button to play birthday song
                ElevatedButton(
                  onPressed: _playMusic,
                  child: Text("Play Birthday Song"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to toggle between the original and Base64-encoded birthdate
  void _toggleBase64() {
    String birthdate = _controller.text; // Get user input from the TextField
    if (birthdate.isEmpty) {
      setState(() {
        displayText = "Please enter a valid birthdate!";
      });
      return;
    }

    setState(() {
      if (isEncoded) {
        // Decode the base64 value back to the original birthdate
        displayText = utf8.decode(base64Decode(displayText));
      } else {
        // Encode the birthdate to base64
        displayText = base64Encode(utf8.encode(birthdate));
      }
      isEncoded = !isEncoded;
    });
  }

  // Method to play the birthday song from the local assets
  void _playMusic() async {
    try {
      // Set the audio source from the assets
      await audioPlayer.setSource(AssetSource('happy_birthday.mp3'));
      await audioPlayer.resume(); // Start playing the audio
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
}


