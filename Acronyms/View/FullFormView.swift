//
//  FullFormView.swift
//  Acronyms
//
//  Created by Lucas Coelho on 28/07/22.
//

import SwiftUI

struct FullFormView: View {
    let fullForm: FullForm
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(fullForm.fullForm)
                        .bold()
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("Frequency: ") + Text(String(fullForm.frequency)).foregroundColor(.secondary)
                        Spacer()
                        Text("First appeared in ") + Text(String(fullForm.since)).foregroundColor(.secondary)
                    }
                    .font(.system(size: 10, weight: .light))
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                if fullForm.variations?.isEmpty == false {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
    }
}

struct FullFormView_Previews: PreviewProvider {
    static var previews: some View {
        FullFormView(fullForm: FullForm(fullForm: "QWERTY", frequency: 1000, variations: nil, since: 2022))
    }
}
