//
//  TableNewSongViewController.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import UIKit

class TableNewSongViewController: UICollectionViewController {
    
    var newAlbom: [NewAlbum] = []
        
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
            fetchNewSongs()

            collectionView.register(NewSongCell.self, forCellWithReuseIdentifier: "cell1")
            collectionView.collectionViewLayout = createFlowLayout()

        }
        
        func createFlowLayout() -> UICollectionViewFlowLayout {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: 155, height: 200)
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
            flowLayout.minimumInteritemSpacing = 20
            flowLayout.minimumLineSpacing = 20
            return flowLayout
        }

        // MARK: UICollectionViewDataSource

        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return newAlbom.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? NewSongCell else {
                return UICollectionViewCell()
            }

            let newAlbum = newAlbom[indexPath.item]
            cell.configure(newAlbum: newAlbum)
            let image = newAlbum.images.first!
            cell.setupImage(imageAlbum: image)
            return cell
        }
    
    func fetchNewSongs() {
        APICaller.shared.getNewReleasesAlbums(country: "US", limit: 40) { [weak self] result in
            switch result {
            case .success(let albums):
                self?.newAlbom = albums.albums.items
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = newAlbom[indexPath.item].id
        APICaller.shared.getAlbum(with: albumId) { result in
            switch result {
            case .success(let album):
                DispatchQueue.main.async {
                    let targetVC = AlbumOnlyViewController(album: album)
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
