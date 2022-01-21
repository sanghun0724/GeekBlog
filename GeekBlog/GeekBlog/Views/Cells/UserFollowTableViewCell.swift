//
//  UserFollowTableViewCell.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/20.
//

import UIKit

protocol UserFollowTableViewCellDelegate:AnyObject {
    func didTapFollowUnfollowButton(model:String)
}

class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    
    weak var delegate:UserFollowTableViewCellDelegate?
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "joe"
        return label
    }()
    
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@Joe"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
    }
    
    public func configure(with model:String) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width:  contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth, y: (contentView.height-40)/2, width: buttonWidth, height: 40)
        
        
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right+5 , y: 0, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
        usernameLabel.frame = CGRect(x: profileImageView.right+5 , y: nameLabel.bottom, width: contentView.width-8-profileImageView.width-buttonWidth, height: labelHeight)
        
    }
}
