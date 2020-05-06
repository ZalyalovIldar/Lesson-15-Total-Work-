//
//  PostsModuleViewController.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

protocol PostsModuleViewControllerEditingProtocol {
    func didFinishEditing()
}

class PostsModuleViewController: UIViewController, PostsModuleViewInput, UITableViewDelegate, UITableViewDataSource, PostsModuleViewControllerEditingProtocol {
    
    @IBOutlet weak var postsTableView: UITableView!
    
    var presenter: PostsModuleViewOutput!
    var posts: [PostDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        presenter.loadPosts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postsTableView.dequeueReusableCell(withIdentifier: Constants.customCellReuseIdentifier) as! CustomTableViewCell
        cell.configure(with: posts[indexPath.row])
        return cell
    }
    
    func didFinishLoadingPosts(posts: [PostDto]) {
        
        self.posts = posts
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editButton = UITableViewRowAction(style: .normal, title: Constants.editActionTitle) { (rowAction, indexPath) in
            
            self.presenter.editButtonPressed(for: self.posts[indexPath.row])
        }
        
        let deleteButton = UITableViewRowAction(style: .default, title: Constants.deleteActionTitile) { (rowAction, indexPath) in
            
            self.presenter.deleteButtonPressed(for: self.posts[indexPath.row])
            
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton, editButton]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.toDetailPostViewSegueName {
            
            if let destinationVC = segue.destination as? DetailPostModuleViewController, let sender = sender as? PostDto {
                
                destinationVC.delegate = self
                destinationVC.configure(with: sender)
            }
        }
    }
    
    func didFinishEditing() {
        presenter.loadPosts()
    }
    
    func didFinishDeletingPost() {
        presenter.loadPosts()
    }
    
    
}
