//
//  ViewAllCategoryViewController.swift
//  MyMusicApp
//
//  Created by mac on 6/21/23.
//

import UIKit

class ViewAllCategoryViewController: UICollectionViewController {

    init() {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 155, height: 155)
            
            super.init(collectionViewLayout: layout)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = Resources.Colors.TabBarColors.background

        self.collectionView!.register(TopicCell.self, forCellWithReuseIdentifier: "cell5")
        
        collectionView.collectionViewLayout = createFlowLayout()

    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 155, height: 155)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as? TopicCell else {
            return UICollectionViewCell()
        }

        cell.backgroundColor = .red
        cell.configureCell()
        return cell
    }

    // MARK: UICollectionViewDelegate

}
