//
//  About.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import SwiftUI

struct About: View {
    @StateObject private var viewModel = DevelopersViewModel()
    @State private var selectedDeveloper: Developers?
    @State private var isSheetPresented = false
    @State private var isReportIssuePresented = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Developers")) {
                    ForEach(viewModel.developers) { developer in
                        Button(action: {
                            selectedDeveloper = developer
                            isSheetPresented = true
                        }) {
                            HStack {
                                Image(systemName: "person.circle")
                                Text(developer.name)
                                Spacer()
                            }
                        }
                    }

                    // Add more sections and information as needed
                }


                Section(header: Text("About")) {
                    LabeledContent("Version", value: "1.0")
                    HStack {
                        Text("View Privacy Policy")
                        Spacer()
                    }
                }
                // Optional: Adds a grouped style to the list
                .navigationTitle("About")
                .sheet(isPresented: $isSheetPresented, content: {
                    if let developer = selectedDeveloper {
                        DeveloperDetailView(developer: developer)
                            .presentationSizing(.form)
                    }
                })
                .sheet(isPresented: $isReportIssuePresented) {
                    ReportIssue()
                        .presentationSizing(.form)
                }
            }
        }
    }
}

#Preview {
    About()
}
