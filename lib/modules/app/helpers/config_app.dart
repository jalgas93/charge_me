import 'package:flutter/foundation.dart';

class ConfigApp {
  static const bool enableHttpDebugMessages = !kReleaseMode;

  static const String _urlImageEditing = "https://image-api.photoroom.com/v2/";

  static String get urlImageEditing => _urlImageEditing;
  static const String _urlRemoveBackground = "https://sdk.photoroom.com/v1/";

  static String get urlRemoveBackground => _urlRemoveBackground;
  static const String _urlPhotoRoomPlusPlan = "https://image-api.photoroom.com/v1/";

  static const String _apiUrlMagicEraser = "https://api.magicstudio.com/";

  static String get apiUrlMagicEraser =>_apiUrlMagicEraser;

  static const String _apiUrlSnapEdit = "https://platform.snapedit.app/api/object_removal/v1/";

  static String get apiUrlSnapEdit =>_apiUrlSnapEdit;

  static String get urlPhotoRoomPlusPlan => _urlPhotoRoomPlusPlan;

  static const String _apiKeyPhotoRoom =
      "sandbox_369ce429bdd2ea646d89912f93d73602402adb10";

  static String get apiKeyPhotoRoom => _apiKeyPhotoRoom;

  static const String _apiKeyImageEditing =
      "sandbox_541fb23571c983c59f7673aeebdcc8ba1906fb08";

  static String get apiKeyImageEditing => _apiKeyImageEditing;

  static const String _apiKeySnapEdit = "4e45a9b4dcd21d1e152e2fda61316255488eef075f4c56a8e928a15412e43fc3";

  static String get apiKeySnapEdit => _apiKeySnapEdit;

  static const String _identifierAdmob =
      "ca-app-pub-2726609504522055~2787647220";

  static String get identifierAdmob => _identifierAdmob;

  static const String _identifierBanner =
      "ca-app-pub-2726609504522055/9582122764";

  static String get identifierBanner => _identifierBanner;

  static const String _identifierBannerFull =
      "ca-app-pub-2726609504522055/3593167593";

  static String get identifierBannerFull => _identifierBannerFull;

  static const String _identifierRewarded =
      "ca-app-pub-2726609504522055/9021094374";

  static String get identifierRewarded => _identifierRewarded;

  static const String _identifierRewardedInterstitial =
      "ca-app-pub-2726609504522055/9180876470";

  static String get identifierRewardedInterstitial =>
      _identifierRewardedInterstitial;

  static const String _identifierInterstitial =
      "ca-app-pub-2726609504522055/8154410893";

  static String get identifierInterstitial => _identifierInterstitial;

  static const String _identifierLaunchingApp =
      "ca-app-pub-2726609504522055/8141838229";

  static String get identifierLaunchingApp => _identifierLaunchingApp;

  static const String _identifierExtendedNative =
      "ca-app-pub-2726609504522055/3094086752";

  static String get identifierExtendedNative => _identifierExtendedNative;

  static const entitlementID = 'premium';

  static const footerText =
      """Don't forget to add your subscription terms and conditions.
       Read more about this here:https://www.revenue.com/blog/schedule-2-section-3-8-b""";

  static const appleApiKey = '';
  static const googleApiKey = "goog_TOyuagZXCvPeGWpqecNHcFqoHVa";
  static const amazonApiKey = '';

  static const clientIdMagicEraser = 'duz9BhOK_L9qK52_c27q99peaP9LgL_rlv1OzK43qSk';
  static const clientSecretMagicEraser = 'AFgPTR-FBcSzV9uNKcNnPZ-mJZGcFfiyHO8k32Kuvcw';
}
