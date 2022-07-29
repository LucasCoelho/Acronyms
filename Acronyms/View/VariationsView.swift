//
//  VariationsView.swift
//  Acronyms
//
//  Created by Lucas Coelho on 28/07/22.
//

import SwiftUI

struct VariationsView: View {
    let vm: VariationsViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<vm.variations.count, id: \.self) { index in
                    let item = vm.variations[index]
                    FullFormView(fullForm: item)
                }
            }
        }
        .navigationTitle("Variations")
    }
    
    init(variations: [FullForm]) {
        vm = VariationsViewModel(variations: variations)
    }
}

struct VariationsView_Previews: PreviewProvider {
    static var previews: some View {
        VariationsView(variations:
                        [FullForm(fullForm: "QWERTY", frequency: 2, variations: nil, since: 2022),
                         FullForm(fullForm: "AZERTY", frequency: 1, variations: nil, since: 2022)])
    }
}
