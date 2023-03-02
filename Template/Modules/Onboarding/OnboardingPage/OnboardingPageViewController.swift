//
//  OnboardingPageViewController.swift
//  Template
//

import UIKit

class OnboardingPageViewController: UIViewController {

    @IBOutlet private var textLabel: UILabel!

    private var model: OnboardingPage

    init(model: OnboardingPage) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextLabel()
    }

}

private extension OnboardingPageViewController {

    func setupTextLabel() {
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 32, weight: .regular)
        textLabel.textColor = .secondaryLabel
        textLabel.text = model.text
    }

}
