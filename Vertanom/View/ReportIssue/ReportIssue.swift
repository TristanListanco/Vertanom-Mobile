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
        #if os(macOS)
        VStack {
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(platformColor)
                .padding()

                Spacer()

                Button("Submit") {
                    // Submit action here
                    // Dismiss the sheet after submission
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(platformColor)
                .padding()
            }

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
            .padding()
        }
        .frame(minWidth: 400, minHeight: 300)
        #else
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
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(platformColor),

                trailing: Button("Submit") {
                    // Submit action here
                    // Dismiss the sheet after submission
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(platformColor)
            )
            .padding()
        }
        #endif
    }

    private var platformColor: Color {
        #if os(macOS)
        return Color(NSColor.systemPurple)
        #else
        return Color(UIColor.systemPurple)
        #endif
    }
}

#Preview {
    ReportIssue()
}
