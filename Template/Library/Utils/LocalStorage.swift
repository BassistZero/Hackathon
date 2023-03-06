import Foundation

/// Утилита для сохранения локальных настроек пользователя и подобных данных
/// Работат через `UserDefaults`
enum LocalStorage {
    
    private enum Keys: String {
        case isOnboardingFinished
        case favoriteBarCodes
    }
    
    private static var storage: UserDefaults {
        .standard
    }

}

extension LocalStorage {

    static var isOnboardingFinished: Bool {
        get {
            storage.bool(forKey: Keys.isOnboardingFinished.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.isOnboardingFinished.rawValue)
        }
    }

    static func appendBarCode(_ barCode: String) {
        var array: [String] = []

        if favoriteBarCodes != nil {
            array = favoriteBarCodes!
        }

        array.append(barCode)
        storage.set(array, forKey: Keys.favoriteBarCodes.rawValue)
    }

    static func removeBarCode(_ barCode: String) {
        guard let favoriteBarCodes, let index = favoriteBarCodes.firstIndex(of: barCode) else { return }
        var array = favoriteBarCodes
        array.remove(at: index)
        storage.set(array, forKey: Keys.favoriteBarCodes.rawValue)
    }

    static var favoriteBarCodes: [String]? {
        get {
            let array = storage.array(forKey: Keys.favoriteBarCodes.rawValue)
            guard let array else { return nil }

            return array.map { .init(describing: $0) }
        }
    }

}
