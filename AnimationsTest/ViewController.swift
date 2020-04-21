//
//  ViewController.swift
//  AnimationsTest
//
//  Created by Ильдар Залялов on 13.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

enum AnimationState {
    case open
    case close
}

class ViewController: UIViewController {

    @IBOutlet weak var viewForAnimation: UIView!
    
    var animator: UIViewPropertyAnimator!
    
    var state: AnimationState = .close
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForAnimation.center = view.center
        
        animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut, animations: {
            
            self.viewForAnimation.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.viewForAnimation.layer.backgroundColor = UIColor.red.cgColor
            
            self.viewForAnimation.layer.cornerRadius = 15
        })
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
//        viewForAnimation.addGestureRecognizer(tapGesture)
//
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
//        tapGesture2.numberOfTouchesRequired = 2
//
//        viewForAnimation.addGestureRecognizer(tapGesture2)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        
        viewForAnimation.addGestureRecognizer(panGesture)
    }
    
    func activateAnimation() {
        
        switch state {
        case .open: closeAnimation()
        case .close: openAnimation()
        }
    }
    
    @objc
    func didPan(_ panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: self.view)
        let final = (view.bounds.height - viewForAnimation.bounds.height) / 2
        var currentYTranslation = -translation.y
        
        switch panGesture.state {
            
        case .began:
            activateAnimation()
            animator.pauseAnimation()
        case .changed:
            
            if state == .open {
                currentYTranslation *= -1
            }
            
            animator.fractionComplete = currentYTranslation / final
            
        case .ended:
            
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            
        default: break
        }
    }
    
    @objc
    func openAnimation() {
        
        animator.addAnimations {
            
            self.viewForAnimation.transform = CGAffineTransform.init(scaleX: 1.6, y: 1.6)
            self.viewForAnimation.layer.backgroundColor = UIColor.red.cgColor
            
            self.viewForAnimation.layer.cornerRadius = 15
        }
        
        animator.addCompletion { (position) in
            
            self.state = .open
        }
        
        animator.startAnimation()
    }

  @objc
   func closeAnimation() {
       
       animator.addAnimations {
           
        self.viewForAnimation.transform = .identity
        self.viewForAnimation.layer.backgroundColor = UIColor.systemPurple.cgColor
           
           self.viewForAnimation.layer.cornerRadius = 0
       }
       
        animator.addCompletion { (position) in
        
            self.state = .close
        }
    
       animator.startAnimation()
   }
    
    @IBAction func didSlide(_ sender: UISlider) {
        
        animator.fractionComplete = CGFloat(sender.value) / 100
    }
}

