//
//  ContentView.swift
//  Acronyms
//
//  Created by Lucas Coelho on 26/07/22.
//

import SwiftUI

struct ContentView: View {
    let environmentObject = AcronymsEnvironment()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                doRegularWork()
            }
    }
    
    func getAcronyms() async {
        do {
            let acronyms = try await environmentObject.getAcronyms(for: "RMI")
            print(acronyms)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func doRegularWork() {
        Task {
            await getAcronyms()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
