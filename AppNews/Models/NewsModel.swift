//
//  NewsModel.swift
//  AppNews
//
//  Created by Egito Filho on 21/12/23.
//

import Foundation

struct NewsModel: Codable {
    var source: SourceModel
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlImage: String?
    var publishedAt: Date
    var content: String?
}
