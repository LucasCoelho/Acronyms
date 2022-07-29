//
//  AcronymSearchResult.swift
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
