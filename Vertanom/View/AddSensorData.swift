//
//  AddSensorData.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/29/24.
//

import SwiftUI

struct AddSensorData: View {
    @StateObject private var viewModel = AddSensorViewModel()
    var body: some View {
        VStack {
            Text("Add Sensor Data")
                .font(.title)
                .fontWeight(.bold)
            TextField("Enter value", text: $viewModel.inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocorrectionDisabled()

            Button(action: {
                viewModel.addEntry()
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            List(viewModel.entries) { entry in
                VStack(alignment: .leading) {
                    Text(entry.value)
                    Text(entry.date, style: .date)
                    Text(entry.date, style: .time)
                }
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Invalid Input"), message: Text("Please enter a valid number"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    AddSensorData()
}
