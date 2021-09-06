//
//  FetchNews.swift
//  News
//
//  Created by Marwalakchouch on 5/9/2021.
//  Copyright © 2021 Idlebrains. All rights reserved.
//

import Foundation
import SwiftUI

class NewsApi {
    
    static let DEFAULT_COUNTRY = "us"
    static let DEFAULT_CATEGORY = "general"
    static let DEFAULT_PAGE_SIZE = 100
    static let NEWS_API_KEY = Constants()

    
    static func getApiUrl() -> String {
        return "https://newsapi.org/v2/top-headlines?country=us&apiKey=1e720f9e9cd845bea37152f911eb5dd9"
    }
    
    static func fetchTopHeadlines(completion: @escaping (TopHeadlinesResponse?) -> Void) {
        let session = URLSession.shared
        var urlComponents = URLComponents(string: getApiUrl())!
        print("Identified Locale: " + (Locale.current.regionCode ?? "Unknown"))
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: (Locale.current.regionCode ?? DEFAULT_COUNTRY).lowercased()),
            URLQueryItem(name: "category", value: DEFAULT_CATEGORY),
            URLQueryItem(name: "pageSize", value: "\(DEFAULT_PAGE_SIZE)"),
            URLQueryItem(name: "apikey", value:  "1e720f9e9cd845bea37152f911eb5dd9")
        ]
        
        let task = session.dataTask(with: urlComponents.url!) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let topHeadlinesResponse = try? jsonDecoder.decode(TopHeadlinesResponse.self, from: data!)
            if (topHeadlinesResponse != nil) {
                print("Number of news articles = \(topHeadlinesResponse?.totalResults ?? -1)")
            } else {
                print("JSON deserialization failed :(")
            }
            completion(topHeadlinesResponse)
        }
        task.resume()
    }
}
