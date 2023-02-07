//
//  StoreModalView.swift
//  GukbapMinister
//
//  Created by TEDDY on 1/18/23.
//

import SwiftUI

struct StoreModalView: View {
  @EnvironmentObject private var mapViewModel: MapViewModel
  @State private var isHeart : Bool = false
  
  var store: Store = .test
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack() {
          Text(store.storeName)
            .font(.title3)
            .bold()
            .padding(.leading, 10)
            .offset(y: 7)
          
          Spacer()
        }
        
        Divider()
          .frame(width: Screen.searchBarWidth, height: 1)
          .overlay(Color.mainColor.opacity(0.5))
        
        NavigationLink(destination: DetailView(store: store)) {
          HStack {
            AsyncImage(url: URL(string: store.storeImages.isEmpty ? "이미지 없음" : store.storeImages[0])) { image in
              image
                .resizable()
            } placeholder: {
              Color.gray.opacity(0.1)
            }
            .frame(width: 90, height: 90)
            .cornerRadius(6)
            .padding(.leading, 10)
            .padding(.bottom, 15)

            VStack{
              HStack(alignment: .top){
                Text(store.storeAddress)
                  .lineLimit(2)
                  .multilineTextAlignment(.leading)
                  .bold()
                  .padding(.leading, 5)
                
                Spacer()
              }
              .padding(.trailing, 20)
              
              HStack {
                Image("Ggakdugi")
                  .resizable()
                  .scaledToFill()
                  .frame(width: 20, height: 20)
                Text(store.countingStar, formatter: NumberFormatter())
                  .font(.footnote)
                  .bold()
                
                Spacer()
              }
              .padding(.leading, 5)
            }
            .padding(.horizontal, 5)
          }
          .background {
            Rectangle()
              .frame(maxWidth: .infinity)
              .frame(height: 120)
              .foregroundColor(Color.white)
              .opacity(0.2)
          }
        }
      }
    }
  }
}

//struct StoreModalView_Previews: PreviewProvider {
//  static var previews: some View {
//    StoreModalView()
//  }
//}
