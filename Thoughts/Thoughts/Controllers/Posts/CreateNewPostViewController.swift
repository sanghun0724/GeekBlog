//
//  CreateNewPostViewController.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit
import SnapKit

class CreateNewPostViewController: UITabBarController {
    
    // Title Field
    private let titleField:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.autocapitalizationType = .words
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50)) // 약간 옆에 공간주기
        field.placeholder = "Endet Title..."
        field.autocorrectionType = .yes
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        return field
    }()
    
    // image Header
    private let headerImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    // TextView for Post
    private let textView:UITextView = {
       let textView = UITextView()
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 28)
        return textView
    }()
    
    private var selectedHeaderImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerImageView)
        view.addSubview(textView)
        view.addSubview(titleField)
        let tap = UITapGestureRecognizer(target: self, action:#selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
        configureButton()
    }
    
    @objc private func didTapHeader() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker,animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    private func configureButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Cancel", style: .done, target: self, action:#selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Post", style: .done, target: self, action:#selector(didTapPost))
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPost() {
        //Check data and post
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = selectedHeaderImage,
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        //upload header Image
        
        // Insert of post into DB
        
        
        let post = BlogPost(identifier: UUID().uuidString, title: title, timestamp: Date().timeIntervalSince1970, headerImageUrl: nil, text: body)
    }
    
    private func configureUI() {
        titleField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(6)
            make.height.equalTo(50)
        }
        headerImageView.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(headerImageView.snp.width).multipliedBy(0.5)
        }
     
        textView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom).offset(6)
        }
    }
}

extension CreateNewPostViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        selectedHeaderImage = image
        headerImageView.image = image
    }
}
