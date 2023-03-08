//
//  ExploreBanner.swift
//  GukbapMinister
//
//  Created by Martin on 2023/03/02.
//

import SwiftUI

struct ExploreBanner: View {
    @EnvironmentObject var storesViewModel: StoresViewModel
    
    // 배너 자동 넘기기 기능
    private let numberOfImages = 3
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    var stores: [Store] {
        storesViewModel.stores
    }
    
    @State private var currentIndex = 0
    
    func getDestination(index: Int) -> Store? {
        var destinationStore: Store?
        
        switch index {
        case 1: destinationStore = stores.first {$0.storeName == "청진옥"}
        case 2: destinationStore = stores.first {$0.storeName == "농민백암순대"}
        case 3: destinationStore = stores.first {$0.storeName == "도야지면옥"}
        default: destinationStore = .test
        }
        
        return destinationStore
    }
    
    
    var body: some View {
        
        
        TabView(selection: $currentIndex) {
            ForEach(1...3, id: \.self) { index in
                NavigationLink {
                    DetailView(detailViewModel: DetailViewModel(store: getDestination(index: index) ?? .test))
                } label: {
                    ZStack (alignment: .topLeading) {
                        Image("Banner\(index)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.75)
                    }
                }
                
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.75)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onReceive(timer, perform: { _ in next()})
        .onDisappear {
            self.timer.upstream.connect().cancel()
        }
    }
    
    
    func next() {
        withAnimation {
            currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
        }
    }
}

struct ExploreBanner_Previews: PreviewProvider {
    static var previews: some View {
        ExploreBanner()
    }
}
