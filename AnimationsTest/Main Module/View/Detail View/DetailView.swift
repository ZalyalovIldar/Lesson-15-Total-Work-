//
//  DetailView.swift
//  AnimationsTest
//
//  Created by Enoxus on 27.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

protocol DetailViewDelegate: AnyObject {
    
    /// tells delegate that exit button was
    func didPressExitButton()
}

class DetailView: UIView {
    
    //MARK: - View Constants
    private class Appearance {
        
        static let stackViewSpacing: CGFloat = 5
        static let stackViewTopOffset = 10
        static let stackViewBottomOffset = -10
        
        static let stackViewWidthMultiplier = 0.9
        
        static let closeImageName = "multiply.circle.fill"
        
        static let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    weak var delegate: DetailViewDelegate?
    
    //MARK: - Views
    lazy var headerImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
        
    lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var homeworldLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var massLabel: UILabel = {
        
        let label = UILabel()
        
        return label
    }()
    
    lazy var heightLabel: UILabel = {
        
        let label = UILabel()
        
        return label
    }()
    
    lazy var eyeColorLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var skinColorLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var bigTextLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var fieldsStackView: UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Appearance.stackViewSpacing
        
        return stackView
    }()
    
    lazy var mainScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.alwaysBounceHorizontal = false
        
        return scrollView
    }()
    
    lazy var exitButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Appearance.closeImageName), for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var exitButtonView: UIView = {
        
        let view = UIView()
        
        return view
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(hero: HeroDto, delegate: DetailViewDelegate?) {
        
        self.init()
        
        backgroundColor = .white
        
        nameLabel.text = hero.name
        homeworldLabel.text = hero.homeworld
        speciesLabel.text = hero.species
        genderLabel.text = hero.gender
        heightLabel.text = hero.height
        massLabel.text = hero.mass
        eyeColorLabel.text = hero.eyeColor
        skinColorLabel.text = hero.skinColor
        bigTextLabel.text = Appearance.loremIpsum
        
        setupViewHierarchy()
        
        if let imageData = hero.imageData {
            headerImageView.image = UIImage(data: imageData)
        }
        else {
            headerImageView.sd_setImage(with: URL(string: hero.image))
        }
        
        self.delegate = delegate
    }
    
    //MARK: - Setup
    func setupViewHierarchy() {
        
        addSubview(mainScrollView)
        
        exitButtonView.addSubview(exitButton)
        
        mainScrollView.addSubview(fieldsStackView)
        
        fieldsStackView.addArrangedSubview(exitButtonView)
        fieldsStackView.addArrangedSubview(headerImageView)
        fieldsStackView.addArrangedSubview(nameLabel)
        fieldsStackView.addArrangedSubview(homeworldLabel)
        fieldsStackView.addArrangedSubview(speciesLabel)
        fieldsStackView.addArrangedSubview(genderLabel)
        fieldsStackView.addArrangedSubview(heightLabel)
        fieldsStackView.addArrangedSubview(massLabel)
        fieldsStackView.addArrangedSubview(eyeColorLabel)
        fieldsStackView.addArrangedSubview(skinColorLabel)
        fieldsStackView.addArrangedSubview(bigTextLabel)
    }
    
    func setupConstraints() {
        
        mainScrollView.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        headerImageView.snp.makeConstraints { make in
            
            make.width.equalToSuperview()
            make.height.equalTo(headerImageView.snp.width)
        }
        
        fieldsStackView.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(Appearance.stackViewTopOffset)
            make.bottom.equalToSuperview().offset(Appearance.stackViewBottomOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Appearance.stackViewWidthMultiplier)
        }
        
        exitButton.snp.makeConstraints { make in
            
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func closeButtonPressed() {
        delegate?.didPressExitButton()
    }
}
