//
//  WordList.swift
//  Wurdle
//
//  Created by Ben Scheirman on 3/21/22.
//

import Foundation

enum WordList {
    static var random: String {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "words", withExtension: "txt")!
        let data = try! Data(contentsOf: url)
        let lines = String(data: data, encoding: .utf8)!
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map { $0.uppercased() }
        return lines.randomElement()!
    }
}
