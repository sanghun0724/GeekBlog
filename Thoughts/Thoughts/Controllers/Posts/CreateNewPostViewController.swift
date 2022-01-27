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
        imageView.clipsToBounds = true
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
              let email = UserDefaults.standard.string(forKey: "email"),
              let headerImage = selectedHeaderImage,
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty else {
                  let alert = UIAlertController(title: "Enter Post Details", message: "Please enter a title, body, and selected a image to continue", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                  present(alert,animated: true)
            return
        }
        
        let newPostId = UUID().uuidString //random generate
        
        //upload header Image
        StorageManager.shared.uploadBlogHeaderImage(email: email,
                                                    image: headerImage,
                                                    postId: newPostId) { success in
            guard success else {
                
                return
            }
            
            StorageManager.shared.downloadUrlForPostHeader(email: email, postId: newPostId) { url in
                guard let headerUrl = url else {
                    print("Failed to upload url for header")
                    return
                }
                //Insert of post into DB
                let post = BlogPost(identifier: UUID().uuidString, title: title, timestamp: Date().timeIntervalSince1970, headerImageUrl: headerUrl, text: body)
                
                DatabaseManager.shared.insert(blogPost: post, email: email) {[weak self] posted in
                    guard posted else {
                        print("Fail to blog insert")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.didTapCancel()
                    }
                }
            }
        }
        
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
