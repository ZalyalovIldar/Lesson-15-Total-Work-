//
//  GestureRecognizerCompatibleScrollView.swift
//  AnimationsTest
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class GestureRecognizerCompatibleScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    var verticalOffsetForTop: CGFloat {
        
        let topInset = contentInset.top
        return -topInset
    }
    
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.panGestureRecognizer.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return isAtTop && otherGestureRecognizer is UIPanGestureRecognizer && (otherGestureRecognizer as! UIPanGestureRecognizer).velocity(in: self).y > .zero
    }
    
}
