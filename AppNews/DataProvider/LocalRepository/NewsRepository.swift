//
//  NewsRepository.swift
//  AppNews
//
//  Created by Egito Filho on 21/12/23.
//

import Foundation

enum NewsListError: Error {
    case fileNotFound
}

class NewsRepository {
    ///Singleton creation
    static var shared: NewsRepository = {
        let instance = NewsRepository()
        return instance
    }()
    
    private init() {}
    
///função para realizar o pharse do json
    func getNewList(completetion: ([NewsModel]?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "NewList", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                
                let newsModelList = try decoder.decode([NewsModel].self, from: data)
                completetion(newsModelList, nil)
                
            } catch {
                completetion(nil, error)
            }
        } else {
            completetion(nil, NewsListError.fileNotFound)
        }
    }
}

///Extensão de função para formatação de data
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
