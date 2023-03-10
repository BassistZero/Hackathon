import UIKit

extension UIApplication {

    static var firstKeyWindow: UIWindow? {
        return UIApplication.shared.delegate?.window ?? nil
    }

    static func setInitialModule(_ module: UIViewController) {
        firstKeyWindow?.rootViewController = module
    }

}
