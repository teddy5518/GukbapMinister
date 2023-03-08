//
//  StoreImagesTabView.swift
//  GukbapMinister
//
//  Created by Martin on 2023/03/02.
//

import SwiftUI

import Kingfisher
import FirebaseStorage

struct StoreImagesTabView: View {
    @Environment(\.colorScheme) var scheme

    @Binding var showDetail: Bool
    
    var store: Store
    
    var body: some View {
        TabView {
            if store.storeImages.isEmpty {
                Image("DetailViewWallpaper")
                    .resizable()
                    .scaledToFill()
            } else {
                ForEach(store.storeImages, id: \.self){ urlString in
                    Button(action: {
                        showDetail.toggle()
                    }){
                        KFImage.url(URL(string:urlString))
                            .placeholder {
                                Gukbaps(rawValue: store.foodType.first ?? "순대국밥")?.placeholder
                                    .resizable()
                                    .scaledToFill()
                            }
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
        }
        .frame(height:Screen.maxWidth * 0.8)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
    
    
    
}



