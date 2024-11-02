//
//  HomeViewModel.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchArticles(query: String, fromDate: Date?) {
        NetworkManager.shared.fetchArticles(query: query, fromDate: fromDate)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Failed to fetch articles:", error)
                }
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &cancellables)
    }
    
    func clearArticles() {
        articles.removeAll()
    }
}
