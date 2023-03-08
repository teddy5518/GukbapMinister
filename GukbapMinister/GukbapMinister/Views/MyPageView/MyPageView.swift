//
//  MyPageView.swift
//  GukbapMinister
//
//  Created by Martin on 2023/01/16.
//

import SwiftUI

extension LoginState {
    var imageName: String {
        switch self {
        case .googleLogin: return "GoogleLogin"
        case .appleLogin: return "AppleLogin"
        case .kakaoLogin: return "KakaoLogin"
        case .logout: return ""
        }
    }
    
    var image: Image {
        Image(self.imageName)
    }
}

struct MyPageView: View {
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storesViewModel: StoresViewModel
    
    @StateObject private var reviewViewModel = ReviewViewModel()
    @StateObject private var mypageViewModel = MyPageViewModel()
    
    var myReviewCount : [Review] {
        reviewViewModel.reviews.filter{
            $0.userId == userViewModel.userInfo.id
        }
    }
    
    var body: some View {
        NavigationStack {
            // 로그아웃 상태가 아니면(로그인상태이면) mypageView 띄우기
            if userViewModel.isLoggedIn {
            VStack(alignment: .leading){

                    header

                    List {
                        NavigationLink {
                            NoticeView()
                        } label: {
                          Label("공지", systemImage: "exclamationmark.bubble")
                        }
                        .listRowSeparator(.hidden)
                        
                        NavigationLink {
                            MyReviewView()
                                .environmentObject(storesViewModel)

                        } label: {
                            HStack {
                                Label("내가 쓴 리뷰", systemImage: "pencil")
                                Spacer()
                                Text("\(myReviewCount.count)")
                            }
                        }
                        .listRowSeparator(.hidden)

                        NavigationLink {
                            UpdateUserInfoView()
                                .environmentObject(mypageViewModel)
                                .environmentObject(userViewModel)
                        } label: {
                            Label("회원정보 수정", systemImage: "gearshape.fill")
                        }
                        .listRowSeparator(.hidden)


                        
                        NavigationLink {
                            if userViewModel.userInfo.userGrade != "국밥부 차관" {
                                Text("국밥부 차관만 등록 할 수 있습니다.\n 지금 국밥부 차관에 지원 하세요!")
                                
                            } else {
                                StoreRegistrationView()
                            }
                    
                        } label: {
                            Label("새로운 국밥집 등록하기", systemImage: "lock.open.fill")
                        }
                        .listRowSeparator(.hidden)

                        NavigationLink {
                            PolicyView()
                        } label: {
                            Label("앱정보", systemImage: "captions.bubble")
                        }
                        .listRowSeparator(.hidden)
                        
                        Button {
                            userViewModel.logoutByPlatform()
                        } label: {
                            Label("로그아웃", systemImage: "xmark.circle")
                        }
                        .padding(1.5)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)

            } else {
                goLoginView()
                    .environmentObject(userViewModel)
            }
        }
        .onAppear {
            reviewViewModel.fetchAllReviews()
            mypageViewModel.subscribeUserInfo()
        }
        .onDisappear {
            mypageViewModel.unsubscribeUserInfo()
        }
        .tint(.mainColor)
    }
    
    private var header: some View {
        HStack(alignment: .center){
            Circle()
                .fill(.gray.opacity(0.1))
                .frame(width: 75, height: 75)
                .overlay{
                    Image("Ddukbaegi.fill")
                        .foregroundColor(.accentColor)
                        .font(.largeTitle)
                }
                .padding(.leading, 20)
            
            VStack(alignment: .leading){
                HStack{
                    Text("\(mypageViewModel.user.userNickname)")
                        .font(.title3)
                    
                    userViewModel.loginState.image
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.052, height: UIScreen.main.bounds.height * 0.025)
                    
                    Spacer()
                    
                    Text("\(mypageViewModel.user.userGrade)")
                        .font(.body)
                        .padding(.trailing, 20)
                }
                .padding(.leading, 10)
                .padding(.bottom, 1)
                
                HStack{
                    Text(mypageViewModel.user.userEmail)
                        .font(.caption)
                        .padding(.leading, 10)
                }
            }
            
        }
        .overlay(
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.gray.opacity(0.3),lineWidth: 1)
            .frame(width: Screen.maxWidth * 0.9217, height: Screen.maxHeight * 0.1355)
        )
        .padding()
        .padding(.vertical)
    }
}




