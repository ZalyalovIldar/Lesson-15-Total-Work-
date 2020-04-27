//
//  DetailView.swift
//  AnimationsTest
//
//  Created by Enoxus on 27.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class DetailView: UIView {

    private class Appearance {
        
    }
    
    lazy var headerImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.clipsToBounds = true
        
        return imageView
    }()
        
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        
        return label
    }()
    
    lazy var homeworldLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        
        let label = UILabel()
        
        return label
    }()
    
    lazy var bigTextLabel: UILabel = {
        
        let label = UILabel()
        
        return label
    }()

}
