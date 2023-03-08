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
                    Link(destination: URL(string: "https://goodvibeminister.notion.site/6ae08866cd284f8a8a467ffb585cdc1a")!) {
                        Text("오픈소스")
                    }
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
