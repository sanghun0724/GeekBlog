//
//  IGFeedPostHeaderTableViewCell.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/18.
//
import SnapKit
import SDWebImage
import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    private let profilePhotoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel:UILabel = {
      let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18,weight:.medium)
        return label
    }()
    
    private let moreButton:UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName:"ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:User) {
        //configure the cell
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
        //profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        layoutIfNeeded()
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }
    
    private func configureUI() {
        profilePhotoImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-4)
            make.width.equalTo(profilePhotoImageView.snp.height)
            make.top.left.equalToSuperview().offset(2)
        }
        
        moreButton.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-4)
            make.width.equalTo(moreButton.snp.height)
            make.top.right.equalToSuperview().offset(-2)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profilePhotoImageView.snp.right).offset(4)
            make.right.equalTo(moreButton.snp.left).offset(-4)
        }
    }

}
