//
//  NewsListDataProvider.swift
//  AppNews
//
//  Created by Egito Filho on 21/12/23.
//

import Foundation

protocol NewsListDataProviderProtocol: GenericDataProvider { }

class NewsListDataProvider: DataProviderManager<NewsListDataProviderProtocol, NewsModel> {
    
    func getNewsList(){
        NewsRepository.shared.getNewList { newModeList, error in
            if let error = error {
                self.delegate?.errorData(self.delegate, error: error)
                return
            }
            
            if let model = newModeList {
                self.delegate?.success(model: model)
            }
        }
    }
}
