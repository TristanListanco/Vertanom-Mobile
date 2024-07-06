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
                            .foregroundStyle(Color.primary)
                        }
                    }

                    // Add more sections and information as needed
                }

                Section(header: Text("Report an Issue")) {
                    Button(action: {
                        isReportIssuePresented = true
                    }) {
                        HStack {
                            Image(systemName: "bubble.and.pencil")
                            Text("Report an Issue")
                            Spacer()
                        }
                        .foregroundStyle(Color.purple)
                    }
                }

                Section(header: Text("About")) {
                    LabeledContent("Version", value: "1.0")
                    HStack {
                        Text("View Privacy Policy")
                        Spacer()
                    }
                }
            }
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
            .formStyle(.grouped)
            
            // Platform-specific toolbar adjustments
            .toolbar {
                #if os(macOS)
                ToolbarItem(placement: .navigation) {
                    Button(action: { /* handle back action */ }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
                #else
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { /* handle action */ }) {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                #endif
            }
        }
    }
}

#Preview {
    About()
}
