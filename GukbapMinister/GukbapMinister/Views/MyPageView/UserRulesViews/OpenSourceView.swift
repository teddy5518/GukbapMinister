//
//  OpenSourceView.swift
//  GukbapMinister
//
//  Created by 김요한 on 2023/02/13.
//

import SwiftUI

struct OpenSourceView: View {
    var body: some View {
        ScrollView {
            VStack  {
                LazyVStack {
                    Text("오픈소스")
                    
                }
                .font(.caption)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("오픈소스")
                
                
                
            }
        }
        .padding(10)
        
    }
}

struct OpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceView()
    }
}
