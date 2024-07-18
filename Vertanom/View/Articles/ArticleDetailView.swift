//
//  ArticleView.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    @Binding var isPresented: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()

                Text(article.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text(article.content)
                    .font(.body)
                    .padding([.horizontal, .bottom])
            }
            .padding()
        }


        .navigationTitle("Article")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    isPresented = false
                }
            }
        }
    }
}

#Preview {
    let sampleArticle = Article(
        id: UUID(), imageName: "article-1",
        title: "The Future of IoT in Agriculture",
        content: "The integration of IoT in agriculture has revolutionized the industry by enabling farmers to monitor crops and livestock in real-time. Sensors and connected devices provide valuable data that helps in making informed decisions, improving efficiency, and increasing yields..."
    )
    ArticleDetailView(article: sampleArticle, isPresented: .constant(true))
}
