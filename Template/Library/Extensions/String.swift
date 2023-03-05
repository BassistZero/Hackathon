import Foundation

extension String {

    static func localized(key: String) -> String {
        NSLocalizedString(key, comment: "")
    }

}
