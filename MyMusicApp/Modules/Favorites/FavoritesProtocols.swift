//
//  FavoritesProtocols.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import Foundation

// Поступление данных в модуль
protocol FavoritesViewInput: AnyObject {
    func fillDataForTableView(with inputArray: [String])
}

// Внешние запросы из модуля
protocol FavoritesViewOutput: AnyObject {
    
    func requestDataForTableView()
}
