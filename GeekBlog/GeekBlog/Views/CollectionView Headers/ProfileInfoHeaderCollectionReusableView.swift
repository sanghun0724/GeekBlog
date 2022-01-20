//
//  ProfileInfoHeaderCollectionReusableView.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/19.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate:AnyObject {
    func profileHeaderDidTapPostsButton(_ header:ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header:ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header:ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapPEditProfileButton(_ header:ProfileInfoHeaderCollectionReusableView)
}


final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate:ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let postButton:UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton:UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton:UIButton = {
        let button = UIButton()
        button.setTitle("followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton:UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Joe smith"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel:UILabel = {
        let label = UILabel()
        label.text = "This is the first account!"
        label.textColor = .label
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    
    //MARK: -init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addbuttonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
        
    }
    
    private func addbuttonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        
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
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right, y: 5 + buttonHeight , width: countButtonWidth*3, height: buttonHeight).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoImageView.bottom , width: width-10, height: 50).integral
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom , width: width-10, height: bioLabelSize.height).integral
    }
    
    //MARK: - Actions
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapPostButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapPEditProfileButton(self)
    }
}
