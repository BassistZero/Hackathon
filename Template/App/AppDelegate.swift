import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.5)
        launchApp()
        return true
    }

}

// MARK: - Configuration

private extension AppDelegate {

    func launchApp() {
        initializeRootView()
        let initialModule = LocalStorage.isOnboardingFinished ? MainViewController() : OnboardingViewController()
        UIApplication.setInitialModule(initialModule)
    }

    func initializeRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }

}
