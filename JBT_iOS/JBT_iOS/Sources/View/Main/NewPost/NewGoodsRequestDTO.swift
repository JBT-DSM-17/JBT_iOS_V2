//
//  NewGoodsRequestDTO.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/18/24.
//

import UIKit

struct NewGoodsRequestDTO: Encodable {
    let representative: Data
    let name: String
    let description: String
    let category: String
    let price: Int
    let location: String
    let detailLocation: String
    let isClassB: Bool
    let detail: Data
    
    enum CodingKeys: String, CodingKey {
        case representative = "picture"
        case name, description, category, price, location, detail
        case detailLocation = "location_detail"
        case isClassB = "is_dokyung"
    }
}
