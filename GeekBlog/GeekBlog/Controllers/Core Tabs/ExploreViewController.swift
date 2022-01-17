//
//  ExploreViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit

class ExploreViewController:UIViewController {
    
    private let searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
}

extension ExploreViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
