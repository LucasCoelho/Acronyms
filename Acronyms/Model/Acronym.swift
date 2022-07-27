//
//  Acronym.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import Foundation

struct AcronymSearchResult: Codable {
    let shortForm: String
    let longForms: [FullForm]
    
    enum CodingKeys: String, CodingKey {
        case shortForm = "sf", longForms = "lfs"
    }
}

struct FullForm: Codable {
    let fullForm: String
    let frequency: Int
    let variations: [FullForm]?
    let since: Int
    
    enum CodingKeys: String, CodingKey {
        case fullForm = "lf", frequency = "freq", variations = "vars", since
    }
}
