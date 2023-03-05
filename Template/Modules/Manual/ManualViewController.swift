import UIKit

final class ManualViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private weak var barCodeTextField: UITextField!
    @IBOutlet private weak var requestInfoButton: UIButton!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
}

// MARK: - Configuration

private extension ManualViewController {

    func setupInitialState() {
        requestInfoButton.setTitle(.localized(key: "RequestData"), for: .normal)
        barCodeTextField.placeholder = "4 627081 051484"
    }

}

// MARK: - Private Actions

private extension ManualViewController {

    @IBAction func sendBarCode(_ sender: UIButton) {
        // TODO: Show Detail Screen
    }

}

// MARK: - Private Methods

private extension ManualViewController {

}
