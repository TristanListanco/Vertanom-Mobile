//
//  DevelopersViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import Foundation


class DevelopersViewModel: ObservableObject {
    @Published var developers: [Developers] = [
        Developers(name: "Tristan Listanco", url: "https://developer1.com"),
        Developers(name: "Shanice Reih Tanque", url: "https://developer2.com"),
        // Add more developers as needed
    ]
}
