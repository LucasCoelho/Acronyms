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

    @Published var state = MainViewState.idle {
        didSet {
            print(state)
        }
    }
    @Published var searchTerm: String = ""
    @Published var results = [FullForm]()
            
    func getAcronyms(for initials: String) async {
        guard !initials.isEmpty else {
            results = []
            state = .idle
            return
        }
        
        do {
            let results = try await api.getAcronyms(for: initials).first?.longForms ?? []
            await MainActor.run {
                if initials == searchTerm {
                    state = .loaded
                    self.results = results
                }
            }
        } catch let error {
            await MainActor.run {
                state = .failed(error)
            }
        }
    }
}
