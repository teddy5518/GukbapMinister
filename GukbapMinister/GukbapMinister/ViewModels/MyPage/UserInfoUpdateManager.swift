//
//  UserInfoUpdateManager.swift
//  GukbapMinister
//
//  Created by Martin on 2023/03/08.
//

import Foundation
import Combine

import FirebaseFirestore

final class UserInfoUpdateManager: ObservableObject {
    @Published var user: User
    @Published var modified = false
    
    private let database = Firestore.firestore() // FireStore 참조 객체
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User = User(userNickname: "",
                           userEmail: "",
                           userGrade: "",
                           reviewCount: 0,
                           storeReportCount: 0,
                           favoriteStoreId: [])
    ) {
        self.user = user
        self.$user
            .dropFirst()
            .sink { [weak self] user in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: User 정보 업데이트
    private func updateUserInfo(_ userInfo: User) {
        if let documentId = userInfo.id {
            do {
                try database.collection("User")
                    .document(documentId)
                    .setData(from: userInfo)
            }
            catch {
                print(error)
            }
        }
    }
    
    //MARK: - UI 핸들러
    func handleUpdateButton() {
        self.updateUserInfo(user)
    }
    
}
