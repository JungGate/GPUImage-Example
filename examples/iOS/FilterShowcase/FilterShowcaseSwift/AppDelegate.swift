import UIKit
import Alamofire
import AlamofireImage
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        Fabric.with([Crashlytics.self])
        
        if let driveId = UserDefaults.standard.string(forKey: "filter_file_id"){
            GoogleDownloader.downlaod(driveFileId: driveId)
        }
        
//        let driveId = "1R3v0KG2tIBYyc4zqvURQUQGjt6M8CgJU" // custom
//        let driveId = "1H0mcGxk8DLWfcd0OsJoIH3dBtZx7GScR" // origin
        
        return true
    }
}

