//
//  APIClient.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import Foundation

struct APIClient {
    
    enum APIClientError: Error {
        case invalidURL
        case missingData
    }
    
    let baseUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    
    func getAcronyms(for initials: String) async throws -> [AcronymSearchResult] {
        
        guard let url = URL(string: baseUrl), var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIClientError.invalidURL
        }

        let queryItem = URLQueryItem(name: "sf", value: initials)
        components.queryItems = [queryItem]
        
        guard let componentsUrl = components.url else {
            throw APIClientError.invalidURL
        }

        let request = URLRequest(url: componentsUrl)

        let (data, _) = try await URLSession.shared.data(for: request)

        return try JSONDecoder().decode([AcronymSearchResult].self, from: data)
    }
}
