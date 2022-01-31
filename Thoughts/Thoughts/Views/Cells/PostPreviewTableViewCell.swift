//
//  PostPreviewTableViewCell.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/28.
//

import UIKit
import SnapKit

class PostPreviewTableViewCellViewModel {
    let title:String
    let imageUrl:URL?
    var imageData:Data?
    
    init(title:String,imageUrl:URL?) {
        self.title = title
        self.imageUrl = imageUrl
    }
}

class PostPreviewTableViewCell: UITableViewCell {
    static let identifier = "PostPreviewTableViewCell"
    
    private let postImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postTitleLabel:UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        contentView.addSubview(postTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.text = nil
        postImageView.image = nil
    }
    
    func configure(with viewModel:PostPreviewTableViewCellViewModel) {
        postTitleLabel.text = viewModel.title
        
        if let data = viewModel.imageData {
            postImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            //fetch image and cache
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.postImageView.image = UIImage(data:data)
                }
            }
            task.resume()
        }
    }
    
    func configureUI() {
        postImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(6)
            make.top.equalToSuperview().inset(4)
            make.width.equalTo(postImageView.snp.height)
            make.bottom.equalToSuperview().inset(4)
            
        }
        
        postTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(postImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(4)
        }
    }

}
