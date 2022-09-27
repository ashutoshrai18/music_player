import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingPage extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  const NowPlayingPage(
      {super.key, required this.songModel, required this.audioPlayer});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  bool isPlaying = false;
  Duration duration = const Duration();
  Duration position = const Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      widget.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      widget.audioPlayer.play();
      isPlaying = true;
    } catch (e) {
      log(e.toString());
    }
    widget.audioPlayer.durationStream.listen((event) {
      setState(() {
        duration = event!;
      });
    });
    widget.audioPlayer.positionStream.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  void changeToSecond(int second) {
    Duration duration = Duration(seconds: second);
    widget.audioPlayer.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Now Playing",
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.blueAccent),
                // ignore: prefer_const_constructors
                child: Icon(
                  size: 50,
                  Icons.music_note,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(widget.songModel.displayNameWOExt,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.songModel.artist.toString() == "<unknown>"
                  ? "Unknown Artist"
                  : widget.songModel.artist.toString(),
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(position.toString().split(".")[0]),
                Expanded(
                    child: Slider(
                        value: position.inSeconds.toDouble(),
                        min: Duration(microseconds: 0).inSeconds.toDouble(),
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            changeToSecond(value.toInt());
                            value = value;
                          });
                        })),
                Text(duration.toString().split(".")[0]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*  IconButton(onPressed: () {}, icon: Icon(Icons.shuffle)), */
                IconButton(
                    iconSize: 40,
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous,
                    )),
                IconButton(
                    iconSize: 80,
                    onPressed: () {
                      setState(() {
                        if (isPlaying) {
                          widget.audioPlayer.pause();
                        } else {
                          widget.audioPlayer.play();
                        }
                        isPlaying = !isPlaying;
                      });
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                    )),
                IconButton(
                    iconSize: 40,
                    onPressed: () {},
                    icon: Icon(Icons.skip_next, size: 40)),
                // IconButton(
                //     iconSize: 40,
                //     onPressed: () {},
                //     icon: Icon(Icons.restart_alt_sharp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
