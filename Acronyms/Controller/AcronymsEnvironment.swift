//
//  AcronymsEnvironment.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import Foundation

class AcronymsEnvironment: ObservableObject {
    let api = APIClient()
    
    func getAcronyms(for initials: String) async throws -> [AcronymSearchResult] {
        return try await api.getAcronyms(for: initials)
    }
}
