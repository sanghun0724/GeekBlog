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
        imageView.backgroundColor = .red
        return imageView
    }()
        
    private let postButton:UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        return button
    }()
    
    private let followingButton:UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        return button
    }()
    
    private let followersButton:UIButton = {
        let button = UIButton()
        button.setTitle("followers", for: .normal)
        return button
    }()
    
    private let editProfileButton:UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
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
        addSubViews()
        backgroundColor = .systemBlue
        clipsToBounds = true
        
    }
    
    private func addSubViews() {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followingButton)
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
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = width-10-profilePhotoSize
        
        postButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        
    }
}
