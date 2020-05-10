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

protocol PostsModuleViewContorllerCloseDetailsView {
    func didCloseDetailsView()
}

enum States {
    case initState
    case middleState
    case fullState
}

class PostsModuleViewController: UIViewController, PostsModuleViewInput, UITableViewDelegate, UITableViewDataSource, PostsModuleViewControllerEditingProtocol, PostsModuleViewContorllerCloseDetailsView {
    
    @IBOutlet weak var postsTableView: UITableView!
    
    var presenter: PostsModuleViewOutput!
    var posts: [PostDto] = []
    var lightHapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    var heavyHapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    var blurEffect: UIBlurEffect!
    var visualEffectView: UIVisualEffectView!
    var detailsView: CustomDetailsUIView!
    var animator: UIViewPropertyAnimator!
    
    let halfOfSecondDuration = 0.5
    let fullAlpha: CGFloat = 1
    let zeroAlpha: CGFloat = 0
    let ratio: CGFloat = 1.5
    let ratioDivider: CGFloat = 4
    let cornerRadius: CGFloat = 15
    let heightDivider: CGFloat = 2
    let zero: CGFloat = 0
    let reverseMultiplier: CGFloat = -1
    let zeroDurationFactor: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        blurEffect = UIBlurEffect(style: .regular)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        presenter.loadPosts()
        
        animator = UIViewPropertyAnimator(duration: halfOfSecondDuration, curve: .linear)
        detailsView = CustomDetailsUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = halfOfSecondDuration
        self.postsTableView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        postsTableView.deselectRow(at: indexPath, animated: true)
        
        lightHapticFeedbackGenerator.prepare()
        lightHapticFeedbackGenerator.impactOccurred()
        
        let rectInTableView = tableView.rectForRow(at: indexPath)
        let rectInSuperView = tableView.superview?.convert(rectInTableView, from: tableView)
        
        detailsView = CustomDetailsUIView(frame: rectInSuperView!)
        detailsView.configure(with: posts[indexPath.row], delegate: self)
        configureDetailsView(view: detailsView)
        view.addSubview(detailsView)
        
        animator.addAnimations {
            self.detailsView.frame = UIScreen.main.bounds
            self.detailsView.alpha = self.fullAlpha
        }
        
        animator.addCompletion { (position) in
            self.detailsView.currentState = States.fullState
        }
        
        animator.startAnimation()
    }
    
    func didFinishEditing() {
        presenter.loadPosts()
    }
    
    func didFinishDeletingPost() {
        presenter.loadPosts()
    }
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        
        let p = longPressGesture.location(in: self.postsTableView)
        let indexPath = self.postsTableView.indexPathForRow(at: p)
        if (indexPath != nil) && (longPressGesture.state == UIGestureRecognizer.State.began) {
            
            heavyHapticFeedbackGenerator.prepare()
            heavyHapticFeedbackGenerator.impactOccurred()
            
            let rectInTableView = postsTableView.rectForRow(at: indexPath!)
            let rectInSuperView = postsTableView.superview?.convert(rectInTableView, from: postsTableView)
            
            let middleRect = CGRect(x: (UIScreen.main.bounds.size.width / ratio) / ratioDivider, y: (UIScreen.main.bounds.size.height / ratio) / ratioDivider, width: UIScreen.main.bounds.size.width / ratio, height: UIScreen.main.bounds.size.height / ratio)
            detailsView = CustomDetailsUIView(frame: middleRect)
            detailsView.closeButton.isHidden = true
            detailsView.scrollView.isScrollEnabled = false
            configureDetailsView(view: detailsView)
            detailsView.configure(with: posts[indexPath!.row], delegate: self)
            detailsView.initialFrame = rectInSuperView
            view.addSubview(visualEffectView)
            visualEffectView.frame = view.frame
            view.addSubview(detailsView)
            
            animator.addAnimations {
                self.detailsView.layer.masksToBounds = true
                self.detailsView.layer.cornerRadius = self.cornerRadius
                self.detailsView.alpha = self.fullAlpha
            }
            
            animator.addCompletion { (position) in
                self.detailsView.currentState = .middleState
            }
            
            animator.startAnimation()
        }
    }
    
    func didCloseDetailsView() {
        visualEffectView.removeFromSuperview()
    }
    
    
    @objc func didPan(_ panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: self.detailsView)
        let final = view.bounds.height / heightDivider
        var currentYTranslation = -translation.y
        
        switch panGesture.state {
            
        case .began:
            
            let contentOffset = detailsView.scrollView.contentOffset.y
            
            if (currentYTranslation > zero) {
                activateExpandAnimation()
            } else if ((currentYTranslation < zero) && (contentOffset <= zero)) {
                activateCloseAnimation()
            }
            
            animator.pauseAnimation()
        case .changed:
            
            if (currentYTranslation < zero) {
                currentYTranslation *= reverseMultiplier
            }
            animator.fractionComplete = currentYTranslation / final
            break
            
        case .ended:
            
            animator.continueAnimation(withTimingParameters: nil, durationFactor: zeroDurationFactor)
            break
            
        default: break
        }
    }
    
    private func configureDetailsView(view: UIView) {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGestureRecognizer.delegate = detailsView
        detailsView.scrollView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tapGestureRecognizer.delegate = detailsView
        detailsView.scrollView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func activateExpandAnimation() {
        
        if (detailsView.currentState == .middleState) {
            
            detailsView.scrollView.isScrollEnabled = true
            detailsView.closeButton.isHidden = false
            animator.addAnimations {
                self.detailsView.frame = UIScreen.main.bounds
            }
            
            animator.addCompletion { (position) in
                self.detailsView.currentState = States.fullState
            }
            
            animator.startAnimation()
        }
    }
    
    private func activateCloseAnimation() {
        
        animator.addAnimations {
            
            self.detailsView.frame = self.detailsView.initialFrame
            self.detailsView.alpha = self.zeroAlpha
        }
        
        animator.addCompletion { (position) in
            self.detailsView.currentState = .initState
        }
        
        animator.startAnimation()
        self.didCloseDetailsView()
    }
    
    @objc func didTap() {
        
        if detailsView.currentState == .middleState {
            activateExpandAnimation()
        }
    }
    
}
