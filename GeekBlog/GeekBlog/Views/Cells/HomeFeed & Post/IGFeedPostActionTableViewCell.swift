//
//  IGFeedPostActionTableViewCell.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/18.
//
import SnapKit
import UIKit

protocol IGFeedPostActionTableViewCellDelegate:AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionTableViewCell"
    
    weak var delegate:IGFeedPostActionTableViewCellDelegate?
    
    private let likeButton:UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30,weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton:UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30,weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton:UIButton = {
       let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30,weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
    
    
    
    public func configure(with post:UserPost) {
        //configure the cell
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().offset(-8)
            make.width.equalTo(likeButton.snp.height)
        }
        
        commentButton.snp.makeConstraints { make in
            make.width.height.equalTo(likeButton)
            make.centerY.equalToSuperview()
            make.left.equalTo(likeButton.snp.right)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(commentButton.snp.right)
            make.height.width.equalTo(likeButton)
        }
        
        
    }
}
