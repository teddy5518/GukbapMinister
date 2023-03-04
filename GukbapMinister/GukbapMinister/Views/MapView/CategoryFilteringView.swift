//
//  MapCategoryModalView.swift
//  GukbapMinister
//
//  Created by 기태욱 on 2023/01/17.
//

import SwiftUI

struct CategoryFilteringView: View {
    
    enum Mode {
        case map, myPage
    }
    
    @Binding var showModal: Bool
    @ObservedObject var mapViewModel: MapViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isTapped: [Bool] = Array(repeating: false, count: Gukbaps.allCases.count)
    var mode: Mode = .map
    
    var body: some View {
        VStack{
            HStack{
                Text("국밥종류")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 12)
            
            VStack(alignment: .center){
                placeButtonsInAlignment(0,2)
                placeButtonsInAlignment(3,4)
                placeButtonsInAlignment(5,7)
                placeButtonsInAlignment(8,9)
                placeButtonsInAlignment(10,11)
            }
            
            Spacer()
        }
        .toolbar {
            ToolbarItemGroup(placement: mode == .map ? .principal : .bottomBar) {
                headerContent
            }
        }
        .onAppear {
            isTapped = Gukbaps.allCases.map {mapViewModel.filteredGukbaps.contains($0)}
        }
    }
}

extension CategoryFilteringView {
    @ViewBuilder
    private func placeButtonsInAlignment(_ start: Int, _ end: Int) -> some View {
        HStack{
            ForEach(Array(Gukbaps.allCases.enumerated())[start...end], id: \.offset) { index, gukbap in
                Button{
                    handleFilteredGukbaps(index: index, gukbap: gukbap)
                } label: {
                    HStack(spacing: 2) {
                        gukbap.image
                            .resizable()
                            .frame(width: 28, height: 28)
                        
                        Text(gukbap.rawValue)
                        
                    }
                    .categoryCapsule(isChanged: isTapped[index])
                }
            }
        }
        .padding(4)
    }
    
    private var headerContent: some View {
        VStack {
            if mode == .myPage {
                Divider()
            }
            
            HStack {
                Button {
                    isTapped = Array(repeating: false, count: Gukbaps.allCases.count)
                    // switch mode {
                    // case .map: mapViewModel.filteredGukbaps = []
                    // case .myPage: userViewModel.filterdGukbaps = []
                    // }
                } label: {
                    Text("전체해제")
                }
                Spacer()
                Button {
                    showModal.toggle()
                } label: {
                    Text("확인")
                }
            }
            if mode == .map {
                Divider()
            }
            
        }
    }
}

extension CategoryFilteringView {
    private func handleFilteredGukbaps(index: Int, gukbap: Gukbaps) {
        isTapped[index].toggle()
        switch mode {
        case .map:
            var newVal: [Gukbaps] = []
            for (index, gukbap) in Gukbaps.allCases.enumerated() {
                if isTapped[index] {
                    newVal.append(gukbap)
                }
            }
            
            mapViewModel.filteredGukbaps = newVal
            
        case .myPage: print("아직몰루")
        }
    }
}

struct GukbapCategoryFilteringView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CategoryFilteringView(showModal: .constant(false), mapViewModel: MapViewModel(storeLocations: []), mode: .map)
        }
        .environmentObject(MapViewModel(storeLocations: []))
        .environmentObject(UserViewModel())
    }
}
