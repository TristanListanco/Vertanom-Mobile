//
//  ReportIssue.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import SwiftUI

struct ReportIssue: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var messageSubject = ""
    @State private var messageBody = ""
    @State private var reportDate = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subject")) {
                    TextField("Enter subject", text: $messageSubject, axis: .vertical)
                }

                Section(header: Text("Body")) {
                    TextField("Enter body", text: $messageBody, axis: .vertical)
                        .frame(minHeight: 100, alignment: .top)
                        .lineLimit(5 ... 10)
                }

                Section(header: Text("Date and Time")) {
                    Text(reportDate, style: .date)
                    Text(reportDate, style: .time)
                }
            }

            .navigationTitle("Report an Issue")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ReportIssue()
}
