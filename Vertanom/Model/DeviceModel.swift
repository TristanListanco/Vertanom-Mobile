//
//  DeviceModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/2/24.
//

import Foundation

struct Device: Identifiable, Hashable {
    var id: String
    var name: String
    var location: String
    var lastUpdated: String
    var status: String
}
