import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseMessaging 

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    // GMSServices.provideAPIKey("YOUR KEY")
    GMSServices.provideAPIKey("YOUR KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication,
  didRegisterForRemoteNotificationWithDeviceToken deviceToken: Data){
    Messaging.messaging().apnsToken = deviceToken
      print("Token: \(deviceToken)")
    super.application(application,
    didRegisterForRemoteNotificationWithDeviceToken: deviceToken)
  }
}