//
//  PayWallDescriptionView.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit

class PayWallDescriptionView: UIView {

    private let descriptorLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26,weight:.medium)
        label.numberOfLines = 0
        label.text = "Join Thoughts Premium to read unlimited articles and browse thousands of posts"
        return label
    }()
    
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22,weight:.regular)
        label.numberOfLines = 1
        label.text = "$4.99 / month"
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(priceLabel)
        addSubview(descriptorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        
        descriptorLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().multipliedBy(0.45)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.5)
        }
        
    }
    
}
