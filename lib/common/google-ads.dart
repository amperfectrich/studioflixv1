import 'package:google_mobile_ads/google_mobile_ads.dart';

const String testDevice = 'CCC858A8789C617693316E69996C70B8';
const int maxFailedLoadAttempts = 3;

InterstitialAd? _interstitialAd;
int _numInterstitialLoadAttempts = 0;
final AdRequest request = AdRequest(
  keywords: <String>['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  nonPersonalizedAds: true,
);
Future<void> createInterstitialAd() async {
  InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ));
}

void showInterstitialAd() {
  if (_interstitialAd == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      createInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      createInterstitialAd();
    },
  );
  _interstitialAd!.show();
  _interstitialAd = null;
}
