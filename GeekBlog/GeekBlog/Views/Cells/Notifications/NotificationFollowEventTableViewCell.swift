//
//  NotificationFollowEventTableViewCell.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/23.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate:AnyObject {
    func didTapFollowUnFollowButton(model:UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate:NotificationFollowEventTableViewCellDelegate?
    
    private var model:UserNotification?
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@kanywest started following you"
        return label
    }()
    
    private let followButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:UserNotification) {
        self.model = model
        
        
        switch model.type {
        case .like(_):
            break
            
        case .follow:
            //configure button
            break
            
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
