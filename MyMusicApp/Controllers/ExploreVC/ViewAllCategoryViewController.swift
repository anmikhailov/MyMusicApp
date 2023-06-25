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
    
    let imageCategory: [UIImage] = [
            UIImage(named: "hip-hop")!,
            UIImage(named: "gangz")!,
            UIImage(named: "hipnow")!,
            UIImage(named: "rap")!,
            UIImage(named: "rapSoul")!,
            UIImage(named: "topHits")!,
            UIImage(named: "hits")!
        ]
    
    private var section: Int = 0

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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
        //let randomIndex = imageCategory[indexPath.item % imageCategory.count]//Int.random(in: 0..<imageCategory.count)
        let image = imageCategory[indexPath.item % imageCategory.count]//imageCategory[randomIndex]
        cell.image2.image = image
        //cell.configureCell(image: image!, title: genre)
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = genres[indexPath.row]
        APICaller.shared.getGenreTracks(for: genre) { result in
            switch result {
            case .success(let genresTracks):
                DispatchQueue.main.async {
                    let targetVC = PlaylistOnlyViewController(playlist: nil,
                                                              playlistsTracks: nil,
                                                              recommendedTracks: genresTracks)
                    targetVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(targetVC, animated: true)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
