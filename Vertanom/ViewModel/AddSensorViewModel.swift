//
//  AddSensorViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/29/24.
//

import Combine
import Foundation

class AddSensorViewModel: ObservableObject {
    @Published var entries: [Entry] = []
    @Published var inputText: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func addEntry() {
        guard let _ = Double(inputText) else {
            alertMessage = "Please enter a valid number."
            showAlert = true
            return
        }

        let newEntry = Entry(value: inputText, date: Date())
        entries.append(newEntry)
        inputText = ""
    }
}
