import UIKit

final class OnboardingPageViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private var textLabel: UILabel!

    // MARK: - Public Properties

    var model: OnboardingPage?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextLabel()
    }

}

// MARK: - Configuration

private extension OnboardingPageViewController {

    func setupTextLabel() {
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 32, weight: .regular)
        textLabel.textColor = .secondaryLabel
        textLabel.text = model?.text
    }

}
