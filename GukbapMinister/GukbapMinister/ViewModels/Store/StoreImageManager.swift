//
//  StoreImageManager.swift
//  GukbapMinister
//
//  Created by Martin on 2023/03/03.
//

import Foundation
import FirebaseStorage

final class StoreImageManager: ObservableObject {
    @Published var store: Store = .test {
        willSet(newValue) {
            getImageURLs(newValue)
        }
    }
    @Published var imageURLs: [URL] = []
    private var storage = Storage.storage()
    
    init(store: Store) {
        self.store = store
    }
    
    //FIXME: - URL을 캐시에 저장해서 다 불러오는 작업을 피할 수 있지 않을까? V 1.1.0 예정
    // 현재는 스토어 정보를 받을 때마다 스토리지에서 다운로드 url을 전부 가져오고 있다.
    func getImageURLs(_ store: Store) {
        storage.reference().child("storeImages/\(store.storeName)").listAll { result, error in
            if let error {
                print(error.localizedDescription)
            }
            if let result {
                for ref in result.items {
                    ref.downloadURL { url, error in
                        if let error {
                            print( error.localizedDescription)
                        }
                        if let url {
                            self.imageURLs.append(url)
                        }
                    }
                }
            }
        }
    }
    
}
