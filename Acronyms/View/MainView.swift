//
//  MainView.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import SwiftUI

struct MainView: View {
    private let environmentObject = AcronymsEnvironment()
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type an acronym here...", text: $vm.searchTerm)
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
                        if text.isEmpty {
                            vm.state = .idle
                        } else {
                            vm.state = .loading
                        }
                    }
                
                    switch vm.state {
                    case .loading:
                        Spacer()
                        ProgressView()
                        Spacer()
                    case .failed(_):
                        Spacer()
                        Text("Something went wrong.\nPlease try again in a few moments")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 12))
                        Spacer()
                        
                    case .loaded:
                        if !vm.results.isEmpty {
                            ScrollView {
                                ForEach(0..<vm.results.count, id: \.self) { index in
                                    
                                    let item = vm.results[index]
                                    
                                    VStack {
                                        HStack {
                                            Text(item.fullForm)
                                            
                                            Spacer()
                                            
                                            if item.variations?.isEmpty != true {
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding(.horizontal)
                                        Divider()
                                    }
                                }
                            }
                        } else if !vm.searchTerm.isEmpty {
                            Spacer()

                            Text("No results were found for \(vm.searchTerm)")
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()

                    default:
                        Spacer()
                    }
            }
            .navigationTitle("Acronyms App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
