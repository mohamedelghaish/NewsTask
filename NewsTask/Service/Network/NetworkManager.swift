//
//  NetworkManager.swift
//  NewsTask
//
//  Created by Mohamed Kotb Saied Kotb on 02/11/2024.
//

import Foundation
import Combine

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://newsapi.org/v2/everything"
    private let apiKey = "b4469ab2e42744ab93da77cfac1fa1da"
    
    func fetchArticles(query: String, fromDate: Date?) -> AnyPublisher<[Article], Error> {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        if let fromDate = fromDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            components.queryItems?.append(URLQueryItem(name: "from", value: formatter.string(from: fromDate)))
        }
        
        let url = components.url!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .map(\.articles)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

