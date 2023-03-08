//
//  NoticeViewModel.swift
//  GukbapMinister
//
//  Created by 김요한 on 2023/03/07.
//

import Foundation
import UIKit

import Firebase
import FirebaseFirestore

@MainActor
final class NoticeViewModel: ObservableObject {
    @Published var notices: [Notice] = []
    
    private var database = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
 
    
    func unsubscribeNotices() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
   
    func subscribeNotices() {
        if listenerRegistration == nil {
            listenerRegistration =  database.collection("Notice")
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("There are no documents")
                        return
                    }
                    
                    self.notices = documents.compactMap { queryDocumentSnapshot in
                      try? queryDocumentSnapshot.data(as: Notice.self)
                    }
                }
        }
    }
    
}
