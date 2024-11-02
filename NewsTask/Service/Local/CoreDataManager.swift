//
//  CoreDataManager.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFavorite(article: Article) {
        let favorite = FavoriteArticle(context: context)
        favorite.title = article.title
        favorite.desc = article.description
        favorite.url = article.urlToImage
        favorite.auther = article.author
        
        do {
            try context.save()
            print("Saved favorite successfully")
        } catch {
            print("Failed to save favorite:", error)
        }
    }
    
    func fetchFavorites() -> [FavoriteArticle] {
        let request: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch favorites:", error)
            return []
        }
    }
    
    func deleteFavorite(_ article: FavoriteArticle) {
        context.delete(article)
        do {
            try context.save()
            print("Deleted favorite successfully")
        } catch {
            print("Failed to delete favorite:", error)
        }
    }
}

