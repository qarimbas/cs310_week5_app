import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> setCurrentScreen(
    FirebaseAnalytics analytics, String screenName, String className) async {
  await analytics.setCurrentScreen(
      screenName: screenName, screenClassOverride: className);
}

Future<void> setUserId(FirebaseAnalytics analytics, String userID) async {
  await analytics.setUserId(userID);
}

Future<void> logCustomEvent(FirebaseAnalytics analytics, String logName,
    Map<String, dynamic> map) async {
  await analytics.logEvent(
    name: logName,
    parameters: map,
  );
}
