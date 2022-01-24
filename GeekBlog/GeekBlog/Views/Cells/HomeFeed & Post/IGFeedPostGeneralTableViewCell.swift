//
//  IGFeedPostGeneralTableViewCell.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/18.
//

import UIKit

/// Commnets
class IGFeedPostGeneralTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //configure the cell
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
