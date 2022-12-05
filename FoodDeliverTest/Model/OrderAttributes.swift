//
//  OrderAttributes.swift
//  FoodDeliverTest
//
//  Created by Muhammad Umair on 03/12/2022.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable{
        // Live Activity state changeable properties
        
        var status: Status = .received
    }
    
    // Other properties
    var orderNumber: Int
    var orderItems: String
}

enum Status: String, CaseIterable, Codable, Equatable{
    case received = "shippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
}
