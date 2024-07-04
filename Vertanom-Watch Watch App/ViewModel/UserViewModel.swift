//
//  UserViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import Combine
import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile

    init(userProfile: UserProfile) {
        self.userProfile = userProfile
    }

    func updateName(_ newName: String) {
        userProfile.name = newName
    }

    func updateEmail(_ newEmail: String) {
        userProfile.email = newEmail
    }

    func updateAddress(_ newAddress: String) {
        userProfile.address = newAddress
    }

    func updateNumberOfDevices(_ newNumberOfDevices: Int) {
        userProfile.numberOfDevices = newNumberOfDevices
    }

    func updatePassword(_ newPassword: String) {
        userProfile.password = newPassword
    }

    func updateHobbies(_ newHobbies: [String]) {
        userProfile.hobbies = newHobbies
    }

    func updateOwnerImageUrl(_ newOwnerImageUrl: String) {
        userProfile.ownerImageUrl = newOwnerImageUrl
    }
}
