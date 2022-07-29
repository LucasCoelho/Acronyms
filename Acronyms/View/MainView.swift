//
//  MainView.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                searchBarView()
                
                switch vm.state {
                case .loading:
                    loadingView()
                case .failed(_):
                    errorView()
                case .loaded:
                    resultsView()
                case .noResults:
                    noResultsView()
                case .idle:
                    Spacer()
                }
            }
            .navigationTitle("Acronyms App")
        }
    }

    private func searchBarView() -> some View {
        return TextField("Type an acronym here...", text: $vm.searchTerm)
            .searchBarStyle()
            .padding(.horizontal)
            .onReceive(
                vm.$searchTerm
                    .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            ) { initials in
                Task {
                    await vm.getAcronyms(for: initials)
                }
            }
            .onReceive(vm.$searchTerm) { text in
                vm.state = text.isEmpty ? .idle : .loading
            }
    }
    
    private func resultsView() -> some View {
        return ScrollView {
            ForEach(0..<vm.results.count, id: \.self) { index in
                let item = vm.results[index]
                NavigationLink(destination: VariationsView(variations: item.variations ?? [])) {
                    FullFormView(fullForm: item)
                }
            }
        }
    }
    
    private func noResultsView() -> some View {
        Group {
            Spacer()
            Text("No results were found for \(vm.searchTerm)")
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private func loadingView() -> some View {
        Group {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    private func errorView() -> some View {
        Group {
            Spacer()
            Text("Something went wrong.\nPlease try again in a few moments")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
