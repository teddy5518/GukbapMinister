import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct MapView: View {
    @Environment(\.colorScheme) var scheme
    
    @StateObject var mapViewModel = MapViewModel(storeLocations: [])
    @StateObject var locationManager = LocationManager()
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storesViewModel: StoresViewModel
    
    // 필터 버튼을 눌렀을 때 동작
    @State var isShowingFilterModal: Bool = false
    @State private var isShowingSelectedStore: Bool = false
    
    var body: some View {
        // 지오메트리 리더가 뷰 안에 선언 되어있기 때문에 뷰 만큼의 너비와 높이를 가져옴
        GeometryReader { geo in
            let width = geo.size.width
            
            NavigationStack {
                ZStack {
                    MapUIView(
                        region: $locationManager.region,
                        storeAnnotations: $mapViewModel.storeLocationAnnotations,
                        selectedStoreAnnotation: $mapViewModel.selectedStoreAnnotation,
                        isSelected: $isShowingSelectedStore,
                        filters: $mapViewModel.filteredGukbaps
                    )
                    .ignoresSafeArea(edges: [.top, .horizontal])
                    
                    VStack {
                        SearchBarButton()
                        mapFilter
                            .offset(x: width * 0.0005)
                        Spacer()
                    }
                    
                    StoreReportButton()
                        .offset(x: width * 0.5 - 47)
                    
                    VStack {
                        // Version 1: 특정 마커의 관하여 모달 내리기 올리기 선택 가능
                        // mapViewModel.selectedStore와 mapViewController.isSelected가 연결되어 있어
                        // mapViewController.isSelected가 true면 mapViewModel.selectedStore에 선택된 가게 정보가 들어감.
                        // Button의 isShowingSelectedStore <- 문제원인, 모달은 mapVieModel.selectedStore만 영향가능
                        if let _ = mapViewModel.selectedStore {
                            Button {
                                isShowingSelectedStore.toggle()
                            } label: {
                                Spacer()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        } else {
                            Spacer()
                        }
                        // Version 2: 모달이 올라온 채로 변형
//                         Spacer()

                        StoreModalView(store: mapViewModel.selectedStore ?? .test)
                                .padding(25)
                                .offset(y: isShowingSelectedStore ? 0 : 400)
                            // animation issue로 인한 주석 처리
                            // .animation(.easeInOut, value: isShowingSelectedStore)
                                .transition(.slide)
                    }
                }
            }
        }
        .onAppear {
            Task {
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                    mapViewModel.storeLocations = storesViewModel.stores
                }
            }
        }
    }
}
