//
//  SignInHeaderView.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit

class SignInHeaderView: UIView {
    
    private let imageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Explore millons of articles!"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        imageView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(60)
            make.top.equalToSuperview()
            make.bottom.greaterThanOrEqualTo(label.snp.top).offset(-40)
            //make.bottom.equalTo(label.snp.top).priority(220)
        }
        imageView.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().priority(221)
        }
    }

}
