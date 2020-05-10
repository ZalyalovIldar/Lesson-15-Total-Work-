//
//  CustomDetailsUIView.swift
//  AnimationsTest
//
//  Created by Евгений on 07.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class CustomDetailsUIView: UIView, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    let nibName = "CustomDetailsUIView"
    let zeroAlpha = 0
    let halfSecondDuration = 0.5
    
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
        self.alpha = CGFloat(zeroAlpha)
        self.backgroundColor = UIColor.white
        self.initialFrame = frame
    }
    
    func commonInit() {
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        postImageView.accessibilityIdentifier = Constants.detailViewImageAccecibilityIdentifier
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
        
        let animator = UIViewPropertyAnimator(duration: halfSecondDuration, curve: .linear) {
            self.frame = self.initialFrame
            self.alpha = CGFloat(self.zeroAlpha)
        }
        animator.startAnimation()
        superviewDelegate.didCloseDetailsView()
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
        if self.currentState == .middleState {
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
