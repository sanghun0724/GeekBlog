//
//  PayWallHeaderView.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit

class PayWallHeaderView: UIView {

    //Header Image
    private let headerImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

}
