//
//  CustomDetailsUIView.swift
//  AnimationsTest
//
//  Created by Евгений on 07.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class CustomDetailsUIView: UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    let nibName = "CustomDetailsUIView"
    var contentView: UIView?
    var currentState = States.initState
    var superviewDelegate: PostsModuleViewContorllerCloseDetailsView!
    var initialFrame: CGRect!
    
    @IBAction func didPressCloseButton(_ sender: Any) {
        
        if currentState != .middleState {
            close()
            superviewDelegate.didCloseDetailsView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
            self.alpha = 0
            self.backgroundColor = UIColor.white
            self.initialFrame = frame
        }
    
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
            contentView = view
        }
    
        func loadViewFromNib() -> UIView? {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
    func configure(with post: PostDto, delegate: PostsModuleViewContorllerCloseDetailsView) {
        
        self.postImageView.sd_setImage(with: URL(string: post.imageUrl))
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
        self.superviewDelegate = delegate
    }
    
    func close() {
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            self.frame = self.initialFrame
            self.alpha = 0
        }
        animator.startAnimation()
        superviewDelegate.didCloseDetailsView()
    }
}
