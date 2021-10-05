import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  GMSServices.provideAPIKey("AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    // GIDSignIn.sharedInstance().clientID = "612655535636-d1irld1kdjok0jfsbateal6d6krgqk05.apps.googleusercontent.com"
  }

}