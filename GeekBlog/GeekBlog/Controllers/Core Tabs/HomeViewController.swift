//
//  ViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedrenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        //Register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated() {
        //check auth status
        if Auth.auth().currentUser == nil {
            // Show Login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedrenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model:HomeFeedRenderViewModel
        if x == 0 {
            model = feedrenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : (x - (x%4) / 4)
            model = feedrenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        }
        else if subSection == 1 {
            // post
            return 1
        }
        else if subSection == 2 {
            // actions
            return 1
        }
        else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let commnets): return commnets.count > 2 ? 2 : commnets.count
            case .header, .actions, .primaryContent: return 0
            }
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model:HomeFeedRenderViewModel
        if x == 0 {
            model = feedrenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : (x - (x%4) / 4)
            model = feedrenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for:indexPath) as! IGFeedPostHeaderTableViewCell
                
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 1 {
            // post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,for:indexPath) as! IGFeedPostTableViewCell
                
                return cell
            case .header, .actions, .comments: return UITableViewCell()
            }
        }
        else if subSection == 2 {
            // actions
            let actionModel = model.actions
            switch actionModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier,for:indexPath) as! IGFeedPostActionTableViewCell
                
                return cell
            case .header, .comments, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,for:indexPath) as! IGFeedPostGeneralTableViewCell
                
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
        }
        else if subSection == 1 {
            return tableView.width
        }
        else if subSection == 2 {
            return 60
        }
        else if subSection == 3 {
            return 50
        }
        return 0
    }
}
