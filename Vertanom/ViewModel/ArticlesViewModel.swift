//
//  ArticlesViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/8/24.
//

import Foundation


class ArticleViewModel: ObservableObject {
    @Published var articles: [Article]

    init(articles: [Article]) {
        self.articles = articles
    }
}
