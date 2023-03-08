//
//  StoreRegistration.swift
//  GukbapMinister
//
//  Created by 김요한 on 2023/03/06.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct StoreRegistration: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    var storeName: String
    var storeAddress: String
    var coordinate: GeoPoint
    var menu: [String : String]
    var description: String
    var countingStar: Double
    var foodType: [String]
}
