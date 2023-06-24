//
//  ViewAllCategoryViewController.swift
//  MyMusicApp
//
//  Created by mac on 6/21/23.
//

import UIKit

class ViewAllCategoryViewController: UICollectionViewController {
    
    var genres: [String] = []
    let image = UIImage(named: "rap")

    init() {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 155, height: 155)
            
            super.init(collectionViewLayout: layout)
        fetchGenres()
  
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = Resources.Colors.TabBarColors.background

        self.collectionView!.register(TopicCell.self, forCellWithReuseIdentifier: "cell5")
        
        collectionView.collectionViewLayout = createFlowLayout()
        fetchGenres()
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 155, height: 155)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }
    
    func fetchGenres() {
        APICaller.shared.getGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genres):
                self.genres = genres.genres
                print(genres)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return genres.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as? TopicCell else {
            return UICollectionViewCell()
        }
        let genre = genres[indexPath.row]
        cell.categoryName.text = genre
        cell.image2.image = image
        //cell.configureCell(image: image!, title: genre)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    

}
