//
//  File.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit

class PayWallViewController:UIViewController {
    
    //Header Image
    private let headerImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //pricing and product info
    // CTA Buttons
    // Terms of Service
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
                                                            
    @objc private func didTapClose() {
                dismiss(animated: true, completion: nil)
    }
                                                            
}
