//
//  MainTabView.swift
//  GukbapMinister
//
//  Created by ㅇㅇ on 2023/01/17.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var storesViewModel: StoresViewModel = StoresViewModel()
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
    
    @State private var tabSelection: Int = 0
    @State private var showModal: Bool = false
    
    var body: some View {
        
            TabView(selection: $tabSelection) {
                MapView(mapViewModel: MapViewModel(storeLocations: storesViewModel.stores))
                    .tabItem {
                        Label("지도", image: "GBmapIcon")
                    }
                    .tag(1)
                    .environmentObject(storesViewModel)
                
                
                ExploreView(exploreViewModel: ExploreViewModel(stores: storesViewModel.stores))
                    .tabItem {
                        Label("둘러보기", image: "GBexploreIcon")

                    }
                    .tag(2)
                    .environmentObject(storesViewModel)
                    .environmentObject(userViewModel)

                    CollectionView()
                        .tabItem {
                            Label("내가 찜한 곳", image: "GBcollectionIcon")

                        }
                        .tag(3)
                        .environmentObject(storesViewModel)
                        .environmentObject(userViewModel)
                    MyPageView()
                        .tabItem {
                            Label("마이페이지", image: "GBmypageIcon")

                        }
                        .tag(4)
                        .environmentObject(userViewModel)
                        .environmentObject(storesViewModel)

            }
            .accentColor(.mainColor)
            .onAppear {
                storesViewModel.subscribeStores()
            }
            .onDisappear {
                storesViewModel.unsubscribeStores()
        }
        
    }
}


//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView(storesViewModel: StoresViewModel())
//
//    }
//}
