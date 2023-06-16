//
//  HomeView.swift
//  MyMusicApp
//
//  Created by mac on 6/13/23.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func didSelectCell(index indexPath: IndexPath)
    func showSections(_ sections: [Section])
}

