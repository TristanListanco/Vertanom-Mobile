//
//  ArticlesModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/8/24.
//

import Foundation

struct Article: Identifiable, Hashable {
    let id: UUID
    let imageName: String
    let title: String
    let content: String
}
