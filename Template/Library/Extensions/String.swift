//
//  String.swift
//  Template
//

import Foundation

public extension String {

    static func localized(key: String) -> String {
        NSLocalizedString(key, comment: "")
    }

}
