//
//  MyReviewView.swift
//  GukbapMinister
//
//  Created by 기태욱 on 2023/02/01.
//
import SwiftUI
import FirebaseAuth

struct MyReviewView: View {
    @StateObject private var reviewVM = ReviewViewModel()
    @EnvironmentObject private var userVM: UserViewModel
    @EnvironmentObject private var storesViewModel: StoresViewModel
    
    var myReview : [Review]
    
    var body: some View {
        VStack{
            NavigationStack{
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0){
                        if myReview.isEmpty {
                            Text("작성된 리뷰가 없습니다.")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                                .padding(.top,300)
                        } else {
                            ForEach(Array(myReview.enumerated()), id: \.offset) { index, review in
                                NavigationLink {
                                    ForEach(storesViewModel.stores, id: \.self) { store in
                                        if(review.storeName == store.storeName) {
                                            DetailView(detailViewModel: DetailViewModel(store: store))
                                        }
                                    }
                                } label: {
                                    UserReviewCell(reviewViewModel: reviewVM, review: review, isInMypage: true)
//                                        .onAppear(){
//
//                                            if (index == myReview.count) || (index < myReview.count) {
//                                                if index == myReview.count - 1{
//                                                    if ((self.myReview.last?.id) != nil) == true {
//
//                                                    }
//                                                    reviewVM.updateReviews()
//                                                    print("\(index+1)번째 리뷰 데이터 로딩중")
//                                                }
//                                            }
//
//
//                                        }
                                }
                                
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitle("내가 쓴 리뷰보기", displayMode: .inline)
        }
        
    }
}




