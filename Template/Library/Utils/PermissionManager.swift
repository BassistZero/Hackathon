//
//  PermissionManager.swift
//  Template
//

import AVFoundation

/// Утилита для проверки разрешения на доступ к камере устройства
public enum PermissionManager {
    
    public static func checkCameraPermission(completion: @escaping (_ hasPermission: Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: completion)
        case .denied, .restricted:
            completion(false)
        case .authorized:
            completion(true)
        @unknown default:
            fatalError()
        }
    }
    
}
