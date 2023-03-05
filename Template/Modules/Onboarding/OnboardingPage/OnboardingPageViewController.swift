import UIKit

final class OnboardingPageViewController: UIViewController {

    // MARK: - Private Outlets

    @IBOutlet private var textLabel: UILabel!

    // MARK: - Private Properties

    private var model: OnboardingPage

    // MARK: Inits

    init(model: OnboardingPage) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        textLabel.text = model.text
    }

}
