//
//  GenericDataProvider.swift
//  AppNews
//
//  Created by Egito Filho on 21/12/23.
//

import Foundation

protocol GenericDataProvider {
    func success(model: Any)
    func errorData(_ provider: GenericDataProvider?, error: Error)
}

class DataProviderManager<T, S> {
    var delegate: T?
    var model: S?
}
