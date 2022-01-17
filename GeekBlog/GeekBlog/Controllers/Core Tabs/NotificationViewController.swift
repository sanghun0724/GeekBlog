//
//  NotificationViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private let tableview:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        return cell
    }
    
  
}
