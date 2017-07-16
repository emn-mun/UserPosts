import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.tintColor = .darkGray
        
        let usersHandler = UsersController(connection: RemoteConnection())
        window?.rootViewController = UINavigationController(rootViewController: UsersViewController(usersHandler: usersHandler))
        
        return true
    }

}

