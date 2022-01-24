//
//  NotificationLikeEventTableViewCell.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/23.
//

import SDWebImage
import UIKit
import SnapKit

protocol NotificationLikeEventTableViewCellDelegate:AnyObject {
    func didTapRelatedPostButton(model:UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate:NotificationLikeEventTableViewCellDelegate?
    
    private var model:UserNotification?
    
    var profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@joe liked your Photo"
        return label
    }()
    
    private let postButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        //layoutIfNeeded()
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:UserNotification) {
        self.model = model
        
        
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
            
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.0
        profileImageView.clipsToBounds = true
    }
    
    
    //MARK: Configure
    private func configureUI() {
        //photo,text, post Button
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(3)
            make.top.equalToSuperview().offset(3)
            make.height.equalTo(contentView.snp.height).offset(-6)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        let size = contentView.height-4
        postButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(2)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.top.equalToSuperview()
            make.right.equalTo(postButton.snp.left).offset(-5)
            make.height.equalToSuperview()
        }
    }
}


