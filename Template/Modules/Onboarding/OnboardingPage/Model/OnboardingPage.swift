//
//  OnboardingPage.swift
//  Template
//

struct OnboardingPage {
    let text: String
}

extension OnboardingPage {

    static var all: [OnboardingPage] {
        Array(1...4)
            .map { OnboardingPage(text: .localized(key: "Onboarding.page.\($0)")) }
    }

}
