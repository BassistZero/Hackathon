//
//  MainViewController.swift
//  Template
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private var scanButton: UIButton!
    @IBOutlet private var manualEnterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

}

private extension MainViewController {

    func setupButtons() {
        [scanButton, manualEnterButton].forEach { $0?.configuration = .filled() }
        scanButton.setTitle(.localized(key: "Main.scanCode"), for: .normal)
        manualEnterButton.setTitle(.localized(key: "Main.manualEnter"), for: .normal)
        
    }

    func showNoPermissionAlert() {
        let alert = UIAlertController(
            title: .localized(key: "PermissionAlert.title"),
            message: .localized(key: "PermissionAlert.message"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: .localized(key: "PermissionAlert.ok"), style: .default))
        present(alert, animated: true)
    }

}

private extension MainViewController {

    @IBAction func handleScanPressed() {
        PermissionManager.checkCameraPermission { [weak self] hasPermission in
            if hasPermission {
                // TODO: - открыть экран сканирования кода
            } else {
                self?.showNoPermissionAlert()
            }
        }
        
    }

    @IBAction func handleManualEnterPressed() {
        // TODO: - открыть экран ввода кода с клавиатуры
    }

}
