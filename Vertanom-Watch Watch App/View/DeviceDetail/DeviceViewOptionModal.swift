//
//  DeviceViewOptionModal.swift
//  Vertanom-Watch Watch App
//
//  Created by Tristan Listanco on 7/26/24.
//

import SwiftUI

struct DeviceViewOptionsModal: View {
    @Binding var selectedDataType: DataType
    let loadData: () -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        // Options list
        List {
            ForEach(DataType.allCases, id: \.self) { type in
                HStack {
                    Label(type.rawValue, systemImage: type.iconName)
                        .foregroundStyle(Color.white)
                    Spacer()
                    if selectedDataType == type {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle()) // Make the entire row tappable
                .onTapGesture {
                    selectedDataType = type
                    loadData()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .listStyle(.carousel)
    }
}

extension DataType {
    var iconName: String {
        switch self {
        case .temperature:
            return "thermometer"
        case .humidity:
            return "cloud"
        case .pH:
            return "leaf.arrow.circlepath"
        case .soilNutrient:
            return "globe.asia.australia"
        }
    }
}

// #Preview {
//    DeviceViewOptionsModal()
// }
