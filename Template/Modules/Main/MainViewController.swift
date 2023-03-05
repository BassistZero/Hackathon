import UIKit

final class MainViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private weak var scanButton: UIButton!
    @IBOutlet private weak var manualEnterButton: UIButton!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

}

// MARK: - Configuration

private extension MainViewController {

    func setupButtons() {
        [scanButton, manualEnterButton].forEach { $0?.configuration = .filled() }
        scanButton.setTitle(.localized(key: "Main.scanCode"), for: .normal)
        manualEnterButton.setTitle(.localized(key: "Main.manualEnter"), for: .normal)
    }

}

// MARK: - Private Actions

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
        let controller = ManualViewController()
        present(controller, animated: true)
    }

}

// MARK: - Private Methods

private extension MainViewController {

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
