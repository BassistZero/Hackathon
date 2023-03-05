import Foundation

/// Утилита для сохранения локальных настроек пользователя и подобных данных
/// Работат через `UserDefaults`
enum LocalStorage {
    
    private enum Keys: String {
        case isOnboardingFinished
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

}
