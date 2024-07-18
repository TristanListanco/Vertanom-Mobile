//
//  Tip.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/8/24.
//

import Foundation
import TipKit

struct AddDeviceTip: Tip {
    var title: Text {
        Text("Add New Device")
            .foregroundStyle(.purple)
    }

    var message: Text? {
        Text("Tap here to add and configure your new Vertanom device")
    }

    var image: Image? {
        Image(systemName: "rectangle.badge.plus")
    }

//    var actions: [Action] {
//        [
//            Tip.Action(id: "learn-more", title: "Learn More")
//        ]
//    }
}

struct MonitorData: Tip {
    var title: Text {
        Text("Monitor your Device")
            .foregroundStyle(.purple)
    }

    var message: Text? {
        Text("See the realtime climatic data and provide insights")
    }

    var image: Image? {
        Image(systemName: "chart.line.uptrend.xyaxis")
    }

//    var actions: [Action] {
//        [
//            Tip.Action(id: "learn-more", title: "Learn More")
//        ]
//    }
}

struct DeviceInstructions: Tip {
    var title: Text {
        Text("Device Instruction")
            .foregroundStyle(.purple)
    }

    var message: Text? {
        Text("Vertanom uses WiFi Technology to transfer data. If there is no internet available the last synced data will be shown")
    }

    var image: Image? {
        Image(systemName: "network")
    }

//    var actions: [Action] {
//        [
//            Tip.Action(id: "learn-more", title: "Learn More")
//        ]
//    }
}
