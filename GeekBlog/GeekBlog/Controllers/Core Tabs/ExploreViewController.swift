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
        searchBar.placeholder = "Search"
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
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        searchBar.delegate = self
    }
}

extension ExploreViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        guard let text = searchBar.text , !text.isEmpty else {
            return
        }
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
    }
    
    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    private func query(_ text:String) {
        //perform the search in the backend
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
