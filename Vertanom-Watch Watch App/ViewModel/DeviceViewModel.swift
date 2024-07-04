//
//  DeviceViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/2/24.
//

import Foundation

class DeviceViewModel: ObservableObject {
    @Published var device: Device

    init(device: Device) {
        self.device = device
    }
}
