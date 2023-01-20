//
//  DetailView.swift
//  GukbapMinister
//
//  Created by Martin on 2023/01/17.
//

import SwiftUI

class StarStore: ObservableObject {
    @Published var selectedStar: Int = 0
}

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject private var reviewViewModel: ReviewViewModel = ReviewViewModel()
    
    @ObservedObject var starStore = StarStore()
    
    @State private var text: String = ""
    @State private var isBookmarked: Bool = false
    @State private var showingAddingSheet: Bool = false
    
    let colors: [Color] = [.yellow, .green, .red]
    let menus: [[String]] = [["국밥", "9,000원"], ["술국", "18,000원"], ["수육", "32,000원"], ["토종순대", "12,000원"]]
    
    
    //lineLimit 관련 변수
    @State private var isExpanded: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width: CGFloat = geo.size.width
                ScrollView {
                    ZStack {
                        //배경색
                        Color(uiColor: .systemGray6)
                        
                        VStack(alignment: .leading, spacing: 0){
                            //상호명 주소
                            //Store.storeName, Store.storeAddress
                            storeNameAndAddress
                            
                            //Store.images
                            storeImages(width)
                            
                            //Store.description
                            storeDescription
                            
                            //Store.menu
                            storeMenu
                            
                            // refactoring으로 인한 일시 주석처리
                            //                            NaverMapView(coordination: (37.503693, 127.053033), marked: .constant(false), marked2: .constant(false))
                            //                                .frame(height: 260)
                            //                                .padding(.vertical, 15)
                            
                            userStarRate
                            
                            ForEach(reviewViewModel.reviews) { review in
                                NavigationLink{
                                    ReviewDetailView(reviewViewModel:reviewViewModel, selectedtedReview: review)
                                }label: {
                                   UserReview(reviewViewModel: reviewViewModel, review: review)
                    
                                        .contextMenu{
                                            Button{
                                                reviewViewModel.removeReview(review: review)
                                            }label: {
                                                Text("삭제")
                                                Image(systemName: "trash")
                                            }
                                        }//contextMenu
                                }//NavigationLink
                                
                            }
                            
                        }//VStack
                        .padding(.bottom, 200)
                    }//ZStack
                }//ScrollView
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .tint(.black)
                        }
                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isBookmarked.toggle()
                        } label: {
                            Image(systemName: isBookmarked ? "heart.fill" : "heart")
                                .tint(.red)
                        }
                    }
                }
            }//GeometryReader
        }//NavigationStack
        .fullScreenCover(isPresented: $showingAddingSheet) {
            CreateReviewView(reviewViewModel: reviewViewModel, starStore: starStore,showingSheet: $showingAddingSheet )
        }
        .onAppear{
            reviewViewModel.fetchReviews()
        }
        .onDisappear{
            reviewViewModel.fetchReviews()
        }
        .refreshable {
            reviewViewModel.fetchReviews()
        }
    }//body
}//struct

extension DetailView {
    var storeNameAndAddress: some View {
        //상호명 주소
        //Store.storeName, Store.storeAddress
        HStack {
            VStack(alignment: .leading){
                Text("농민백암순대")
                    .font(.title.bold())
                    .padding(.bottom, 8)
                Text("서울 강남구 역삼로3길 20-4")
            }
            Spacer()
        }
        .padding(15)
        .background(.white)
    }
    
    func storeImages(_ width: CGFloat) -> some View {
        TabView {
            ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                
                VStack {
                    Text("사진\(index + 1)")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: width * 0.8)
                .background(color)
            }
        }
        .frame(height:width * 0.8)
        .tabViewStyle(.page(indexDisplayMode: .always))
        
    }
    
    var storeDescription: some View {
        VStack(alignment: .leading) {
            
            Text("수요미식회에서 인정한 선릉역 찐 맛집! 이래도 안 먹을 것인지? 먹어주시겄어요? 제발제발! 줄은 서지만 기다릴만한 가치가 있는 맛집이입니다...> < 수요미식회에서 인정한 선릉역 찐 맛집! 이래도 안 먹을 것인지? 먹어주시겄어요? 제발제발! 줄은 서지만 기다릴만한 가치가 있는 맛집이입니다...> <수요미식회에서 인정한 선릉역 찐 맛집! 이래도 안 먹을 것인지? 먹어주시겄어요? 제발제발! 줄은 서지만 기다릴만한 가치가 있는 맛집이입니다...> <")
                .lineLimit(isExpanded ? nil : 3)
                .overlay(
                    GeometryReader { proxy in
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text(isExpanded ? "접기" : "더보기")
                                .font(.caption).bold()
                                .padding(.leading, 8.0)
                                .padding(.top, 4.0)
                                .background(Color.white)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                    }
                )
            //                .lineLimit(10)
                .padding(.horizontal, 15)
                .padding(.vertical, 30)
            Divider()
        }
        .background(Color.red)
    }
    
    var storeMenu: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("메뉴")
                    .font(.title2.bold())
                    .padding(.bottom)
                
                ForEach(menus, id: \.self) {menu in
                    HStack{
                        Text(menu[0])
                        Spacer()
                        Text(menu[1])
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(15)
            Divider()
        }
        .background(.white)
    }
    
    var userStarRate: some View {
        HStack {
            Spacer()
            VStack {
                Text("테디베어님의 후기를 남겨주세요")
                    .fontWeight(.bold)
                
                Spacer()
                
                //별 재사용 예정
                
                HStack(spacing: 15) {
                    ForEach(0..<5) { index in
                        Button {
                            starStore.selectedStar = index
                            showingAddingSheet.toggle()
                        } label: {
                            Image(starStore.selectedStar >= index ? "Ggakdugi" : "Ggakdugi.gray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                        }
                    }
                }
            }
            .padding(.vertical, 30)
            
            Spacer()
        }
        .background(.white)
    }
    
    struct UserReview:  View {
        @StateObject var reviewViewModel: ReviewViewModel
        @ObservedObject var starStore = StarStore()
        var review: Review
        var body: some View{
            VStack{
                HStack{
                    Text("\(review.nickName)")
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    Text("\(review.createdDate)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding()
                }
              
                HStack(spacing: -30){
                    ForEach(0..<5) { index in
                        Image(review.starRating >= index ? "Ggakdugi" : "Ggakdugi.gray")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding()
                    }
                    Spacer()
                }//HStack
                .padding(.top,-30)
               HStack{
                    Text("\(review.reviewText)")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .padding()
                }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(review.images ?? [], id: \.self) { index in
                                if let image = reviewViewModel.reviewImage[index] {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 180,height: 160)
                                        .cornerRadius(10)
                                }
                                  
                            }
                        }
                     
                    }
                    .padding()
             Divider()
            }//VStack
        }
    }
    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(starStore: StarStore())
//    }
//}
