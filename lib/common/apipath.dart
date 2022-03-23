class APIData {
  // Replace with your domain link : http://example.com/public/

  static const String domainLink = "https://studioflix.tv/";

  static const String domainApiLink = domainLink + "api/";

  // API Link
  static const String loginApi = domainApiLink + "login";
  static const String fbLoginApi = domainApiLink + "fblogin";
  static const String googleLoginApi = domainApiLink + "googlelogin";
  static const String socialLoginApi = domainApiLink + "sociallogin";
  static const String userProfileApi =
      domainApiLink + "userProfile?secret=" + secretKey;
  static const String freeSubscription =
      domainApiLink + "free/subscription?secret=" + secretKey;
  static const String profileApi = domainApiLink + "profile";
  static const String registerApi = domainApiLink + "register";
  static const String allMovies = domainApiLink + "movie?secret=" + secretKey;
  static const String sliderApi = domainApiLink + "slider?secret=" + secretKey;
  static const String allDataApi = domainApiLink + "main?secret=" + secretKey;
  static const String movieTvApi =
      domainApiLink + "movietv?secret=" + secretKey;
  static const String topMenu = domainApiLink + "menu?secret=" + secretKey;
  static Uri verifyOTPApi = Uri.parse(domainApiLink + "verifycode");
  static Uri forgotPasswordApi = Uri.parse(domainApiLink + "forgotpassword");
  static const String resetPasswordApi = domainApiLink + "resetpassword";
  static const String menuDataApi = domainApiLink + "MenuByCategory";
  static const String episodeDataApi = domainApiLink + "episodes/";
  static const String watchListApi =
      domainApiLink + "showwishlist?secret=" + secretKey;
  static const String watchHistory =
      domainApiLink + "watchhistory?secret=" + secretKey;
  static Uri addWatchHistory =
      Uri.parse(domainApiLink + "addwatchhistory?secret=" + secretKey);
  static const String deleteAllWatchHistory =
      domainApiLink + "delete_watchhistory?secret=" + secretKey;
  static const String deleteWatchHistory =
      domainApiLink + "delete_watchhistory/";
  static const String removeWatchlistMovie = domainApiLink + "removemovie/";
  static const String removeWatchlistSeason = domainApiLink + "removeseason/";
  static const String addWatchlist =
      domainApiLink + "addwishlist?secret=" + secretKey;
  static const String checkWatchlistSeason = domainApiLink + "checkwishlist/S/";
  static const String checkWatchlistMovie = domainApiLink + "checkwishlist/M/";
  static const String homeDataApi = domainApiLink + "home?secret=" + secretKey;
  static const String faq = domainApiLink + "faq?secret=" + secretKey;
  static const String userProfileUpdate =
      domainApiLink + "profileupdate?secret=" + secretKey;
  static const String stripeProfileApi =
      domainApiLink + "stripeprofile?secret=" + secretKey;
  static const String stripeDetailApi =
      domainApiLink + "stripedetail?secret=" + secretKey;
  static const String clientNonceApi =
      domainApiLink + "bttoken?secret=" + secretKey;
  static const String sendPaymentNonceApi =
      domainApiLink + "btpayment?secret=" + secretKey;

  static const String stripeUpdateApi = domainApiLink + "stripeupdate/";
  static const String paypalUpdateApi = domainApiLink + "paypalupdate/";

  static const String sendPaystackDetails =
      domainApiLink + "paystack?secret=" + secretKey;
  static const String applyCouponApi = domainApiLink + "applycoupon";
  static const String showScreensApi =
      domainApiLink + "showscreens?secret=" + secretKey;
  static const String screensProfilesApi =
      domainApiLink + "screenprofile?secret=" + secretKey;
  static const String updateScreensApi =
      domainApiLink + "updatescreen?secret=" + secretKey;
  static const String screenLogOutApi = domainApiLink + "logout";
  static const String couponPaymentApi = domainApiLink + "couponpayment";
  static const String notificationsApi =
      domainApiLink + "notifications?secret=" + secretKey;
  static const String sendRazorDetails =
      domainApiLink + "paystore?secret=" + secretKey;
  static const String postVideosRating =
      domainApiLink + "rating?secret=" + secretKey;
  static const String checkVideosRating =
      domainApiLink + "checkrating?secret=" + secretKey;
  static const String downloadCounter =
      domainApiLink + "downloadcounter?secret=" + secretKey;
  static const String postBlogComment =
      domainApiLink + "addcomment?secret=" + secretKey;
  static const String actorMovies = domainApiLink + "detail/";
  static const String applyGeneralCoupon =
      domainApiLink + "verifycoupon?secret=" + secretKey;
  static const String getCoupons = domainApiLink + "coupon?secret=" + secretKey;
  static const String invoice = domainApiLink + "invoice-download/";

  static const String manualPayments =
      domainApiLink + "manualPayment?secret=" + secretKey;
  static const String storeManualPayments =
      domainApiLink + "store/manualPayment?secret=" + secretKey;

// URI Links
  static const String loginImageUri = domainLink + "images/login/";
  static const String logoImageUri = domainLink + "images/logo/";
  static const String landingPageImageUri = domainLink + "images/main-home/";
  static const String movieImageUri = domainLink + "images/movies/thumbnails/";
  static const String movieImageUriPosterMovie =
      domainLink + "images/movies/posters/";
  static const String tvImageUriPosterTv =
      domainLink + "images/tvseries/posters/";
  static const String tvImageUriTv = domainLink + "images/tvseries/thumbnails/";
  static const String profileImageUri = domainLink + "images/user/";
  static const String silderImageUri = domainLink + "images/home_slider/";
  static const String shareSeasonsUri = domainLink + "show/detail/";
  static const String shareMovieUri = domainLink + "movie/detail/";
  static const String blogImageUri = domainLink + "images/blog/";
  static const String menuTabLogoUri = domainLink + "images/menulogos/";
  static const String actorsImages = domainLink + "images/actors/";
  static const String directorsImages = domainLink + "images/directors/";
  static const String appSlider = domainLink + "images/app_slider/";

/*
*           Replace android app ID with your app package name.
*           Replace IOS app ID with your IOS app ID.
*/
  // Replace with your app name
  static const String appName = 'StudioFlix';

  static const String secretKey = "8ff2a9c9-f14e-44aa-b235-0dbdb23ef2fb";

  // Replace with your android app id name
  static const String androidAppId = 'com.studioflix.qubators';
  // Replace with your ios app id name
  static const String iosAppId = 'com.studioflix.qubators';
  static const String shareAndroidAppUrl =
      'https://play.google.com/store/apps/details?id=' + '$androidAppId';

// For notifications
  static const String onSignalAppId = "c5473ddb-60c6-41b5-839b-36aac4beb3c0";

// To play google drive video
  static const String googleDriveApi = "AIzaSyA2AZbuEhBlk0KPZSPMDsQWYC8hOO4fRpw";

// For Player
  static const String tvSeriesPlayer = domainLink + 'watchseason/';
  static const String moviePlayer = domainLink + 'watchmovie/';
  static const String episodePlayer = domainLink + 'watchepisode/';
  static const String trailerPlayer = domainLink + 'movietrailer/';
  static const String tvtrailerPlayer = domainLink + 'tvtrailer/';
}
