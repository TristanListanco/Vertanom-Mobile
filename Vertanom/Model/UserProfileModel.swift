//
//  UserProfileModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//
import Foundation

struct UserProfile: Codable, Hashable {
    var id: UUID
    var name: String
    var ownerImageUrl: String
    var email: String
    var address: String
    var numberOfDevices: Int
    var password: String
    var hobbies: [String]
    var devices: [Device] // Include an array of Device objects
}
