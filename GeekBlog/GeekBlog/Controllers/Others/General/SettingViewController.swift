//
//  SettingViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit

struct SettingCellModel {
    let title:String
    let handler: (() -> Void)
}

/// View Controller to show user settings
final class SettingViewController: UIViewController {
    
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        congfigureModel()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func congfigureModel() {
        let section = [
        SettingCellModel(title: "Log Out") { [weak self] in
            guard let self = self else { return }
            self.didTapLogOut()
       }]
        data.append(section)
    }
  
    private func didTapLogOut() {
        AuthManager.shared.logOut { success in
            DispatchQueue.main.async {
                if success {
                    //present log in
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0 
                    }
                } else  {
                    //error occured
                }
            }
        }
    }
}


extension SettingViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 테이블뷰 클릭하면 색깔 변하는거 다시 돌아오게 해주는 펑션
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
        //Handle cell selection here
        
    }
    
    
    
}
