import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

String _authStatus = 'Unknown';

Future<void> initPlugin() async { // 앱추적
  // Show tracking authorization dialog and ask for permission
  final status = await AppTrackingTransparency.requestTrackingAuthorization();

  // Now you can safely initialize admob and start to show ads. Admob should use
  // advertising identifier automatically.
  // FirebaseAdMob.instance.initialize(...)

  // If the system can show an authorization request dialog
  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.notDetermined) {
    // Show a custom explainer dialog before the system dialog
    // await showCustomTrackingDialog(context);
    // Wait for dialog popping animation
    await Future.delayed(const Duration(milliseconds: 200));
    // Request system's tracking authorization dialog
    await AppTrackingTransparency.requestTrackingAuthorization();
  }

  final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  print("UUID: $uuid");
  // try{
  //   final TrackingStatus status =
  //   await AppTrackingTransparency.trackingAuthorizationStatus;
  //   setState(() => _authStatus = '$status');
  //   // If the system can show an authorization request dialog
  //   if (status == TrackingStatus.notDetermined){
  //     await Future.delayed(const Duration(milliseconds: 200));
  //     final TrackingStatus status =
  //     await AppTrackingTransparency.requestTrackingAuthorization();
  //     setState(() => _authStatus = '$status');
  //   }
  // } on PlatformException{
  //   setState(() => _authStatus = 'PlatformException was thrown');
  // }
  //
  // final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  // print("UUID: $uuid");
}