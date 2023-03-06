//
//  UpdateUserInfoView.swift
//  GukbapMinister
//
//  Created by 전혜성 on 2023/02/01.
//

import SwiftUI
import FirebaseAuth

struct UpdateUserInfoView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
        
    let currentUser = Auth.auth().currentUser
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                        NavigationLink {
                            EditNicknameView()
//                                .environmentObject(userViewModel)
                        } label: {
                            Text("\(userViewModel.userInfo.userNickname)")
                        }
                        .listRowSeparator(.hidden)

                    

                
                        NavigationLink {
                            EditGukbapView()
                        } label: {
                            Text("선호하는 국밥")
                        }
                        .listRowSeparator(.hidden)

                    
                   
                        NavigationLink {
                            EditPreferenceAreaView()
                        } label: {
                            Text("선호하는 지역")
                        }
                        .listRowSeparator(.hidden)

                    
                   
                        NavigationLink {
                            DeleteAccountView()
                        } label: {
                            Text("더보기")
                        }
                        .listRowSeparator(.hidden)

                }
                .listStyle(.plain)
                
           
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원정보 수정")
        }
        .onAppear {
//            userViewModel.fetchUpdateUserInfo()
        }
    }
}

//struct UpdateUserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateUserInfoView()
//    }
//}
