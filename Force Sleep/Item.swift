//
//  Item.swift
//  Force Sleep
//
//  Created by Ahmad Arefin on 19/04/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
