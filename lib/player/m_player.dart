import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/common/global.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class MyCustomPlayer extends StatefulWidget {
  MyCustomPlayer({this.title, this.url, this.downloadStatus, this.subtitleUrl});

  final String? title;
  final String? url;
  final dynamic downloadStatus;
  final String? subtitleUrl;

  @override
  State<StatefulWidget> createState() {
    return _MyCustomPlayerState();
  }
}

class _MyCustomPlayerState extends State<MyCustomPlayer>
    with WidgetsBindingObserver {
  TargetPlatform? platform;
  BetterPlayerController? _betterPlayerController;
  var betterPlayerConfiguration;
  DateTime? currentBackPressTime;

  dynamic selectedVideoIndex;
  bool showPlayerControls = true;
  void stopScreenLock() async {
    Wakelock.enable();
  }

  //  Handle back press
  Future<bool> onWillPopS() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Navigator.pop(context);
      return Future.value(true);
    }
    return Future.value(true);
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

  BannerAd? _bannerAd;
  AdWidget? adWidget;

  @override
  void initState() {
    super.initState();

    // Ad
    _bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    _bannerAd?.load();
    adWidget = AdWidget(ad: _bannerAd!);

    this.stopScreenLock();
    setState(() {
      playerTitle = widget.title;
    });

    WidgetsBinding.instance!.addObserver(this);

    initializePlayer();

    String os = Platform.operatingSystem;

    if (os == 'android') {
      setState(() {
        platform = TargetPlatform.android;
      });
    } else {
      setState(() {
        platform = TargetPlatform.iOS;
      });
    }
  }

  Future<void> initializePlayer() async {
    try {
      int _startAt = 0;
      if (await storage.containsKey(key: widget.url!)) {
        String? s = await storage.read(key: widget.url!);
        _startAt = int.parse(s!);
      }

      var dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.url!,
        subtitles: BetterPlayerSubtitlesSource.single(
          name: 'Subtitle',
          type: BetterPlayerSubtitlesSourceType.network,
          url: widget.subtitleUrl ??
              "http://www.storiesinflight.com/js_videosub/jellies.srt",
        ),
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
      storage.write(key: widget.url!, value: '0');
    } else {
      storage.write(key: widget.url!, value: '$currentPositionInSec');
    }
  }

  @override
  void dispose() async {
    saveCurrentPosition();
    _betterPlayerController!.dispose();
    Wakelock.disable();

    // Ad
    _bannerAd?.dispose();
    _bannerAd = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: FractionalOffset.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: adWidget,
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: _betterPlayerController != null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BetterPlayer(
                        controller: _betterPlayerController!,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
      onWillPop: onWillPopS,
    );
  }
}
