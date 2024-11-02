//
//  FavoriteViewModel.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import Foundation
import CoreData
import Combine

class FavoriteViewModel: ObservableObject {
    
    private let coreDataManager = CoreDataManager.shared
    @Published var favoriteArticles: [FavoriteArticle] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchFavorites()
    }
    
    func fetchFavorites() {
        favoriteArticles = coreDataManager.fetchFavorites()
    }
    
    func removeFavorite(_ article: FavoriteArticle) {
        coreDataManager.deleteFavorite(article)
        fetchFavorites()
    }
    
    func saveArticle(_ article: Article) {
        coreDataManager.saveFavorite(article: article)
        fetchFavorites()
    }
    
    func isArticleFavorite(_ article: Article) -> Bool {
            return favoriteArticles.contains { favoriteArticle in
                favoriteArticle.title == article.title && favoriteArticle.url == article.url
            }
        }
}

