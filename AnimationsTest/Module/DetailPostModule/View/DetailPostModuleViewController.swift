//
//  DetailPostViewController.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class DetailPostModuleViewController: UIViewController, DetailPostModuleViewInput {

    var post: PostDto!
    var presenter: DetailPostModuleViewOutput!
    var delegate: PostsModuleViewControllerEditingProtocol!
    @IBOutlet weak var bodyTextArea: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = post.title
        bodyTextArea.text = post.body
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.saveButtonTitle, style: .done, target: self, action: #selector(self.didPressSaveButton(_:)))
    }
        
    @objc func didPressSaveButton(_ sender: Any) {
        
        if post.body == bodyTextArea.text {
            presenter.didPressSaveButton(on: post, isChanged: false, delegate: delegate)
        } else {
            var post = self.post!
            post.body = bodyTextArea.text
            presenter.didPressSaveButton(on: post, isChanged: true, delegate: delegate)
        }
    }
        
    func configure(with post: PostDto) {
        self.post = post
    }
}
