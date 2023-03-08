//
//  PolicyView.swift
//  GukbapMinister
//
//  Created by 김요한 on 2023/02/13.
//

import SwiftUI

struct PolicyView: View {
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {

                    List {
                        
                        NavigationLink {
                            ServiceTermsView()
                        } label: {
                            Text("서비스 이용약관")
                        }
                        .listRowSeparator(.hidden)

                        
                        
                        NavigationLink {
                            PrivacyPolicyView()
                        } label: {
                            Text("개인정보 처리 방침")
                        }
                        .listRowSeparator(.hidden)

                        
                        
                        NavigationLink {
                            LocationBasedServicePolicyView()
                        } label: {
                            Text("위치기반 서비스 이용약관")
                        }
                        .listRowSeparator(.hidden)

                        
                        
                        NavigationLink {
                            CommunityGuideLineView()
                        } label: {
                            Text("커뮤니티 가이드라인")
                        }
                        .listRowSeparator(.hidden)

                        
                        
                        NavigationLink {
                            OpenSourceView()
                        } label: {
                            Text("오픈소스 라이선스")
                        }
                        .listRowSeparator(.hidden)
                        
                        NavigationLink {
                            AppMakersInfoView()
                        } label: {
                            Text("국밥부장관을 만든사람들")
                        }
                        .listRowSeparator(.hidden)

                        
                        Text("버전 정보 1.0.0")
                            .fontWeight(.semibold)
                            .listRowSeparator(.hidden)

                        
                    }
                    .listStyle(.plain)
                    

                }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("앱 정보")
        }
    

        
    }
}

struct PolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyView()
    }
}
