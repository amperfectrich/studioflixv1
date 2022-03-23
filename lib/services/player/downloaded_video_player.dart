import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import '/common/global.dart';
import 'dart:io';

class DownloadedVideoPlayer extends StatefulWidget {
  DownloadedVideoPlayer(
      {this.taskId, this.name, this.fileName, this.downloadStatus});
  final String? taskId;
  final String? name;
  final String? fileName;
  final dynamic downloadStatus;

  @override
  _DownloadedVideoPlayerState createState() => _DownloadedVideoPlayerState();
}

class _DownloadedVideoPlayerState extends State<DownloadedVideoPlayer>
    with WidgetsBindingObserver {
  TargetPlatform? _platform;
  BetterPlayerController? _betterPlayerController;
  var betterPlayerConfiguration;
  var vFileName;

  @override
  void initState() {
    super.initState();
    setState(() {
      playerTitle = widget.name;
      vFileName = widget.fileName;
    });
    print('local path1: $localPath');
    print('local path2: $localPath/${widget.fileName}');

    initializePlayer();

    Wakelock.enable();

    String os = Platform.operatingSystem;

    if (os == 'android') {
      setState(() {
        _platform = TargetPlatform.android;
      });
    } else {
      setState(() {
        _platform = TargetPlatform.iOS;
      });
    }
  }

  Future<void> initializePlayer() async {
    try {
      int _startAt = 0;
      if (await storage.containsKey(key: '$localPath/$vFileName')) {
        String? s = await storage.read(key: '$localPath/$vFileName');
        _startAt = int.parse(s!);
      }

      var dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        '$localPath/$vFileName',
      );
      betterPlayerConfiguration = BetterPlayerConfiguration(
        startAt: Duration(seconds: _startAt),
        autoPlay: true,
        looping: false,
        fullScreenByDefault: true,
        aspectRatio: 16 / 9,
        subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
          fontSize: 20,
          fontColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        controlsConfiguration: BetterPlayerControlsConfiguration(
          textColor: Colors.white,
          iconsColor: Colors.white,
        ),
      );
      _betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: dataSource,
      );
      _betterPlayerController!.play();

      _betterPlayerController!.videoPlayerController!.addListener(
        () {
          if (currentPositionInSec == 0) setState(() {});
          currentPositionInSec = _betterPlayerController!
              .videoPlayerController!.value.position.inSeconds;
          print('Position in Seconds : $currentPositionInSec');
        },
      );
    } catch (e) {
      print('Better Player Error :-> $e');
    }
  }

  int currentPositionInSec = 0, durationInSec = 0;

  void saveCurrentPosition() {
    durationInSec = _betterPlayerController!
        .videoPlayerController!.value.duration!.inSeconds;
    print('Duration in Seconds :$durationInSec');
    if (currentPositionInSec == durationInSec) {
      storage.write(key: '$localPath/$vFileName', value: '0');
    } else {
      storage.write(
          key: '$localPath/$vFileName', value: '$currentPositionInSec');
    }
  }

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        if (_betterPlayerController != null) _betterPlayerController!.pause();
        debugPrint("Inactive");
        break;
      case AppLifecycleState.resumed:
        if (_betterPlayerController != null) _betterPlayerController!.pause();
        break;
      case AppLifecycleState.paused:
        if (_betterPlayerController != null) _betterPlayerController!.pause();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    saveCurrentPosition();
    _betterPlayerController!.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _betterPlayerController != null
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BetterPlayer(
                      controller: _betterPlayerController!,
                    ),
                  )
                : SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
