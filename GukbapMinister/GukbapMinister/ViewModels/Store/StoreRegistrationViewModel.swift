//
//  StoreViewModel.swift
//  GukbapMinister
//
//  Created by Martin on 2023/01/20.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

import Firebase
import FirebaseFirestore
import FirebaseStorage

final class StoreRegistrationViewModel: ObservableObject {
    @Published var storeRegistration: StoreRegistration
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    
    @Published var selectedImages: [PhotosPickerItem] = []
    @Published var selectedImageData: [Data] =  []
    @Published var convertedImages: [UIImage] =  []
    
    @Published var stores: [Store] = []
    @Published var storeImages: [String : UIImage] = [:]
    
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    private var database = Firestore.firestore()
    private var storage = Storage.storage()
    
    
    init(storeRegistration: StoreRegistration = StoreRegistration(storeName: "",
                              storeAddress: "",
                              coordinate: GeoPoint(latitude: 0, longitude: 0),
                              menu: [:],
                              description: "",
                              countingStar: 0.0,
                              foodType: ["순대국밥"]
    )) {

        self.storeRegistration = storeRegistration
        self.$storeRegistration
            .dropFirst()
            .sink { [weak self] store in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    

    
    private func convertToUIImages() {
        if !selectedImageData.isEmpty {
            for imageData in selectedImageData {
                if let image = UIImage(data: imageData) {
                    convertedImages.append(image)
                }
            }
        }
    }
    
    private func makeImageName() {
        // iterate over images
        for img in convertedImages {
            let imgName = UUID().uuidString
            uploadImage(image: img, name: (storeRegistration.storeName + "/" + imgName))
        }
    }
    
    
    private func addStoreInfo() {
        do {
            self.convertToUIImages()
            makeImageName()
            //위도 경도값을 형변환해서 넣어주기
            self.storeRegistration.coordinate = GeoPoint(latitude: Double(self.latitude) ?? 0.0, longitude: Double(self.longitude) ?? 0.0)
            
            let _ = try database.collection("StoreRegistration")
                .addDocument(from: self.storeRegistration)
        }
        catch {
            print(error)
        }
    }
    
    private func updateStoreInfo(_ storeRegistration: StoreRegistration) {
        if let documentId = storeRegistration.id {
            do {
                try database.collection("StoreRegistration")
                    .document(documentId)
                    .setData(from: storeRegistration)
            }
            catch {
                print(error)
            }
        }
    }
    
    
    private func removeStoreInfo() {
        if let documentId = self.storeRegistration.id {
            database.collection("StoreRegistration").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    private func updateOrAddStoreInfo() {
        if let _ = storeRegistration.id {
            self.updateStoreInfo(self.storeRegistration)
        }
        else {
            addStoreInfo()
        }
    }
    
    private func uploadImage(image: UIImage, name: String) {
        let storageRef = storage.reference().child("storeRegistrationImages/\(name)")
        let data = image.jpegData(compressionQuality: 0.1)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // uploda data
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, err) in
                
                if let err = err {
                    print("err when uploading jpg\n\(err)")
                }
                
                if let metadata = metadata {
                    print("metadata: \(metadata)")
                }
            }
        }
        
    }
    // MARK: - Storage에서 이미지 다운로드
//    func fetchImages(storeId: String, imageName: String) {
//        let ref = storage.reference().child("storeImages/\(storeId)/\(imageName)")
//
//        ref.getData(maxSize: 15 * 1024 * 1024) { [self] data, error in
//            if let error = error {
//                print("error while downloading image\n\(error.localizedDescription)")
//                return
//            } else {
//                let image = UIImage(data: data!)
//                self.storeImages[imageName] = image
//
//            }
//        }
//    }
    
//    func fetchImages(storeId: String, imageName: String) async throws -> UIImage {
//        let ref = storage.reference().child("storeImages/\(storeId)/\(imageName)")
//
//        let data = try await ref.data(maxSize: 1 * 1024 * 1024)
//        let image = UIImage(data: data)
//
//        self.storeImages[imageName] = image
//
//        return image!
//    }

        // MARK: - UI 핸들러
    
    func handleDoneTapped() {
        self.updateOrAddStoreInfo()
    }
    
    func handleDeleteTapped() {
        self.removeStoreInfo()
    }
    
 
}//StoreViewModel
