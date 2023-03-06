//
//  ExploreCategoryDetailView.swift
//  GukbapMinister
//
//  Created by Martin on 2023/02/08.
//

import SwiftUI
import Kingfisher

struct ExploreCategoryDetailView: View {
    @EnvironmentObject var storesViewModel: StoresViewModel
    var stores: [Store]
    
    let columns: [GridItem] = .init(repeating: .init(.flexible()), count: 2)
    var body: some View {
        ScrollView(.vertical) {
            GeometryReader{ geo in
                let width: CGFloat = geo.size.width
                let gridSize = width / 2
                let imageSize = gridSize * 0.925
                
                LazyVGrid(columns: columns) {
                    ForEach(stores) { store in
                        NavigationLink {
                            DetailView(detailViewModel: DetailViewModel(store: store))
                        } label: {
                            StoreGridItem(store: store, width: gridSize, imageSize: imageSize)
                        }
                    }
                }
            }
        }
        .padding(5)
        
    }
}



struct StoreGridItem: View{
    @Environment(\.colorScheme) var scheme
    
    var store : Store
    var width: CGFloat
    var imageSize: CGFloat
    
    var body: some View{
        
        VStack{
            VStack{
                StoreImageThumbnail(store: store, width: imageSize, height: imageSize, cornerRadius: 10)
                
                VStack{
                    HStack {
                        Text("\(store.storeName)")
                            .fontWeight(.bold)
                            .font(.callout)
                            .lineLimit(1)
                            .foregroundColor(scheme == .light ? .black : .white)
                        Spacer()
                    }
                    

                    HStack {
                        Text("\(store.storeAddress)")
                            .font(.caption2)
                            .lineLimit(1)
                            .foregroundColor(scheme == .light ? .gray : .white)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    

                    HStack{
                        Text("\(store.description)")
                            .font(.caption)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(scheme == .light ? .black : .white)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                }
                .frame(width: imageSize)
            } //VStack
            .frame(width: width, height: 300)
            .padding(1)
            
        } // var body
    }
}


struct ExploreCategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExploreCategoryDetailView(stores: [.test, .test2])
                .environmentObject(StoresViewModel())
        }
    }
}
