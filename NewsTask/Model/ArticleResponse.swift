//
//  ArticleResponse.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
//    init(from favorite: FavoriteArticle, source: Source) {
//        self.source = source
//        self.title = favorite.title ?? "No Title"
//        self.author = favorite.auther ?? "Unknown Author"
//        self.description = favorite.desc ?? "No Description"
//        self.url = favorite.url ?? "No URL"
//        self.urlToImage = "favorite.urlToImage"
//        self.publishedAt = ""
//    }
}


struct Source: Codable {
    let id: String?
    let name: String
}
