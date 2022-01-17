//
//  CameraViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import AVFoundation
import UIKit
/// custom camera controller  (not use imagePicker)
class CameraViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func didTapTakePicture() {
        
    }
}
