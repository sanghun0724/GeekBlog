//
//  ViewController.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(PostPreviewTableViewCell.self, forCellReuseIdentifier: PostPreviewTableViewCell.identifier)
        return tableView
    }()
    
    private let composeButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration:UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),
                                for: .normal)
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(composeButton)
        view.addSubview(tableView)
        
        composeButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        fetchAllPosts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       configureUI()
    }
    
    @objc private func didTapCreate() {
        let vc = CreateNewPostViewController()
        vc.title = "Create Post"
        let navVC = UINavigationController(rootViewController: vc)
        self.present(navVC,animated: true)
    }


    private func configureUI() {
        composeButton.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        tableView.frame = view.bounds
    }
    
    //TableView
    
    private var posts: [BlogPost] = []
    
    private func fetchAllPosts() {
        print("Fetching home feed...")
        
        DatabaseManager.shared.getAllPosts { [weak self] posts in
            guard let self = self else { return }
            self.posts = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
       guard let cell = tableView.dequeueReusableCell(withIdentifier:PostPreviewTableViewCell.identifier, for: indexPath) as? PostPreviewTableViewCell else {
           fatalError()
       }
        cell.configure(with: .init(title: post.title, imageUrl: post.headerImageUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ViewPostViewController(post: posts[indexPath.row])
        vc.title = "post"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

