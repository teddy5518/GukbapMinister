//
//  StoreModalView.swift
//  GukbapMinister
//
//  Created by TEDDY on 1/18/23.
//

import SwiftUI
import Kingfisher

struct StoreModalView: View {
    // 다크 모드 지원
    @Environment(\.colorScheme) var scheme
    var store: Store?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                storeTitle
                divider
                    .padding(.top, 10)
                
                HStack(alignment: .top) {
                    if let store {
                        NavigationLink {
                            DetailView(detailViewModel: DetailViewModel(store: store))
                        } label: {
                            StoreImageThumbnail(store: store, size: 90, cornerRadius: 6)
                        }
                    }
                    VStack(alignment: .leading){
                        Menu {
                            Button {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = store?.storeAddress
                            } label: {
                                Label("이 주소 복사하기", systemImage: "doc.on.clipboard")
                            }
                            Text(store?.storeAddress ?? "")
                        } label: {
                            HStack {
                                Text(store?.storeAddress ?? "")
                                    // 다크 모드 지원
                                    .foregroundColor(scheme == .dark ? .white : .accentColor)
                                    .padding(.leading, 5)
                                    .lineLimit(1)
                                    .fixedSize(horizontal: false, vertical: true)
                                Image(systemName: "ellipsis.circle")
                                
                                Spacer()
                            }
                            .font(.subheadline)
                        }
                        .frame(height: 20)
                        .padding(.top, 10)
                        Spacer()
                        GgakdugiRatingShort(rate: store?.countingStar ?? 0.0, size: 20)
                            .padding(.leading, 5)
                            .padding(.bottom, 10)
                    }
                }
                .frame(height: 90)
                .padding(.top, 10)
            }
        }
        .padding(.horizontal, 15)
        .frame(width: Screen.searchBarWidth, height: 160)
        .background(RoundedRectangle(cornerRadius: 10).fill(scheme == .dark ? .black : Color.white))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.mainColor.opacity(0.5))
        }
        .onAppear {
            print("모달이 나오겠습니다")
        }
    }
    
}

extension StoreModalView {
    var storeTitle: some View {
        HStack {
            NavigationLink(destination: DetailView(detailViewModel: DetailViewModel(store: store ?? .test))) {
                Text(store?.storeName ?? "")
                    .foregroundColor(scheme == .dark ? .white : .accentColor)                
                    .font(.title3)
                    .bold()
            }
            Spacer()
        }
    }
    
    var divider: some View {
        Divider()
            .frame(width: Screen.searchBarWidth, height: 1)
            .overlay(Color.mainColor.opacity(0.5))
    }
}


