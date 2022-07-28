//
//  MainViewModel.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import Foundation

class MainViewModel: ObservableObject {
    enum MainViewState {
        case idle
        case loading
        case failed(Error)
        case loaded
    }

    private let api = APIClient()

    @Published var state = MainViewState.idle
    @Published var searchTerm: String = ""
    @Published var results = [FullForm]()
            
    @MainActor func getAcronyms(for initials: String) async {
        guard !initials.isEmpty else {
            results = []
            state = .idle
            return
        }
        
        do {
            results = try await api.getAcronyms(for: initials).first?.longForms ?? []
            state = .loaded
        } catch let error {
            print(error.localizedDescription)
            state = .failed(error)
        }
    }
}
