//
//  PostViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit

/*
 Section
 - Header model
 Section
 - post cell model
 Sectoin
 - Action Buttons Cell Model
 Section
 - n Number of general models for comments
 
 */

/// States of a rendered cell
enum PostRenderType {
    case header(provider:User)
    case primaryContent(provider:UserPost) // post
    case actions(provider: String) // like ,commnet , share
    case comments(comments:[PostComment])
}

/// Model of rendered Post
struct PostRenderViewModel {
    let renderType:PostRenderType
}

class PostViewController: UIViewController {
    
    private let model:UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView:UITableView = {
        let tableView =  UITableView()
        
        //Register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: Init
    init(model:UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension PostViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            case .actions(_): return 1
            case .comments(let comments): return comments.count > 4 ? 4 : comments.count
            case .primaryContent(_): return 1
            case .header(_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            case .actions(let action):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier,for:indexPath) as! IGFeedPostActionTableViewCell
            
            return cell
            case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,for:indexPath) as! IGFeedPostGeneralTableViewCell
            
            return cell
            case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,for:indexPath) as! IGFeedPostTableViewCell
            
            return cell
            case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,for:indexPath) as! IGFeedPostTableViewCell
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            case .actions(_): return 60
            case .comments(_): return 50
            case .primaryContent(_): return tableView.width
            case .header(_): return 70
        }
    }
}

