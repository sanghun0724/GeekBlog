//
//  ProfileInfoHeaderCollectionReusableView.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/19.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    private let profilePhotoImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
        
    private let postButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let follwingButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let followersButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let editProfileButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
            return label
    }()
    
    private let bioLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    //MARK: -init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        backgroundColor = .systemBlue
        clipsToBounds = true
        
    }
    
    private func addSubViews() {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(follwingButton)
        addSubview(postButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        
        
    }
}
