import UIKit

final class ManualViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var barCodeTextField: UITextField!
    @IBOutlet private weak var requestInfoButton: UIButton!

    // MARK: - Private Properties

    private var barCodeLength = 13

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
        requestInfoButton.isEnabled = false

        barCodeTextField.placeholder = .localized(key: "Manual.placeholder")
        barCodeTextField.delegate = self


        configureLabels()
    }

    func configureLabels() {
        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 12)
        configureMessageText()
    }

    func configureMessageText() {
        guard let text = barCodeTextField.text, !text.isEmpty else {
            messageLabel.text = ""
            return
        }

        if text.count < barCodeLength {
            messageLabel.textColor = .systemRed
            var amountText: String

            switch barCodeLength - text.count {
            case 1:
                amountText = "цифру"
            case 2,3,4:
                amountText = "цифры"
            default:
                amountText = "цифр"
            }

            messageLabel.text = "Введите ещё \(barCodeLength - text.count) \(amountText)"
        }

        if text.count == barCodeLength {
            messageLabel.textColor = .systemGreen
            messageLabel.text = "Нажмите 'запросить'"
        }
    }

    func configureRequestButton() {
        guard let text = barCodeTextField.text else { return }

        requestInfoButton.isEnabled = text.count == barCodeLength ? true : false
    }

}

// MARK: - Private Actions

private extension ManualViewController {

    @IBAction func sendBarCode(_ sender: UIButton) {
        let controller = DetailViewController()
        guard let barCode = barCodeTextField.text else { return }

        LocalStorage.appendBarCode(barCode)

        controller.barCode = barCode
        present(controller, animated: true)
    }

}

// MARK: - UITextFieldDelegate

extension ManualViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        configureMessageText()
        configureRequestButton()
        guard let text = textField.text else { return }

        if text.count > barCodeLength {
            textField.deleteBackward()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

}
