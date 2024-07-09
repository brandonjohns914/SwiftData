//
//  Sight.swift
//  iTour
//
//  Created by Brandon Johns on 7/9/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Sight {
    var name: String
    var destination: Destination? 
    init(name: String) {
        self.name = name 
    }
}
