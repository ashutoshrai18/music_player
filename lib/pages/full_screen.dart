import 'package:flutter/material.dart';

class AudioPlayPage extends StatefulWidget {
  const AudioPlayPage({super.key});

  @override
  State<AudioPlayPage> createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: CircleAvatar(
              radius: 100,
              child: Icon(Icons.music_note),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
