//
//  FullForm.swift
//  Acronyms
//
//  Created by Lucas Coelho on 28/07/22.
//

import Foundation

struct FullForm: Codable {
    let fullForm: String
    let frequency: Int
    let variations: [FullForm]?
    let since: Int
    
    enum CodingKeys: String, CodingKey {
        case fullForm = "lf", frequency = "freq", variations = "vars", since
    }
}
