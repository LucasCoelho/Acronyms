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
    
    private let baseUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    
    func getAcronyms(for initials: String) async throws -> [AcronymSearchResult] {
        guard let url = URL(string: baseUrl), var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIClientError.invalidURL
        }

        components.queryItems = [URLQueryItem(name: "sf", value: initials)]
        
        guard let componentsUrl = components.url else {
            throw APIClientError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: componentsUrl))

            return try JSONDecoder().decode([AcronymSearchResult].self, from: data)
        } catch {
            throw APIClientError.missingData
        }
    }
}
