//
//  ArticlesCardView.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/8/24.
//

import SwiftUI

struct ArticlesCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Image(article.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 70)
                .cornerRadius(8)

            Text(article.title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 8)

            Text(article.content)
                .font(.caption)
                .lineLimit(2)
                .padding(.top, 2)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct ArticlesCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesCardView(article: Article(imageName: "article-1", title: "Sample Article", content: "This is a brief overview of the content of the sample article."))
    }
}
