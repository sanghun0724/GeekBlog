//
//  File.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit
import SnapKit

class PayWallViewController:UIViewController {
    
    private let header = PayWallHeaderView()
    private let heroView = PayWallDescriptionView()
    
    //pricing and product info
    // CTA Buttons
    private let buyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let restoreButton:UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purchase", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    // Terms of Service
    private let termsView:UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .label
        textView.text = "This is an auto-renewable Subscirption. It will be charged to your iTunes account beofre each pay perid. You can cancel anytime by going into your Settings -> Subscriptions. Restore purchases if previously subscribed"
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thoughts Premium"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        view.addSubview(buyButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
        view.addSubview(heroView)
        setUpCloseButton()
        setUpButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    private func setUpButtons() {
        buyButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }
    
    @objc private func didTapSubscribe() {
        // ReVenueCat
    }
    
    
    @objc private func didTapRestore() {
        // ReVenueCat
    }
    
    
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureUI() {
        header.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.height/3.2)
        }
        
        termsView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(termsView.snp.top).offset(-60)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        buyButton.snp.makeConstraints { make in
            make.bottom.equalTo(restoreButton.snp.top).offset(-4)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        heroView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(buyButton.snp.top)
        }
    }
}
