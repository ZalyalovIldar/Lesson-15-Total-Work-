//
//  MainTableViewCell.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit
import SDWebImage

protocol MainTableViewCellDelegate: AnyObject {
    
    /// tells delegate that SDWebImage has loaded an image
    /// - Parameters:
    ///   - data: image
    ///   - id: dto id
    func didLoadImage(data: Data, id: Int)
}

class MainTableViewCell: UITableViewCell {
    
    //MARK: - Appearance Constants
    private class Appearance {
        
        static let imageViewWidth: CGFloat = 200
        static let imageViewHeight = 200
        static let imageViewCornerRadius: CGFloat = 15
        
        static let imageViewTopOffset = 16
        static let imageViewLeftOffset = 16
        static let imageViewBottomOffset = -16
        
        static let nameLabelTopOffset = 16
        static let nameLabelLeftOffset = 16
        static let nameLabelRightOffset = -16
        
        static let homeworldLabelLeftOffset = 16
        static let homeworldLabelRightOffset = -16
        
        static let genderLabelLeftOffset = 16
        static let genderLabelRightOffset = -16
        static let genderLabelBottomOffset = -16
    }
    
    var dto: HeroDto!
    weak var delegate: MainTableViewCellDelegate?
    
    //MARK: - Views
    lazy var heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Appearance.imageViewCornerRadius
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(heroImageView)
        addSubview(nameLabel)
        addSubview(homeworldLabel)
        addSubview(genderLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    func configure(with dto: HeroDto, delegate: MainTableViewCellDelegate?) {
        
        self.delegate = delegate
        
        nameLabel.text = dto.name
        homeworldLabel.text = dto.homeworld
        genderLabel.text = dto.gender
        
        if let imageData = dto.imageData {
            heroImageView.image = UIImage(data: imageData)?.resizeTopAlignedToFill(newWidth: Appearance.imageViewWidth)
        }
        else {
            heroImageView.sd_setImage(with: URL(string: dto.image)) { [weak self] image, _, _, _ in
                
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    
                    self.heroImageView.image = image?.resizeTopAlignedToFill(newWidth: self.heroImageView.frame.width)
                    
                    if let data = self.heroImageView.image?.pngData() {
                        delegate!.didLoadImage(data: data, id: dto.id)
                    }
                }
            }
            heroImageView.image = heroImageView.image?.resizeTopAlignedToFill(newWidth: Appearance.imageViewWidth)
        }
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        heroImageView.sd_cancelCurrentImageLoad()
    }
    
    func setupConstraints() {
        
        heroImageView.snp.makeConstraints { make in
            
            make.width.equalTo(Appearance.imageViewWidth)
            make.height.equalTo(Appearance.imageViewHeight)
            
            make.left.equalToSuperview().offset(Appearance.imageViewLeftOffset)
            make.top.equalToSuperview().offset(Appearance.imageViewTopOffset)
            make.bottom.equalToSuperview().offset(Appearance.imageViewBottomOffset)
        }
        
        nameLabel.snp.makeConstraints { make in
            
            make.left.equalTo(heroImageView.snp.right).offset(Appearance.nameLabelLeftOffset)
            make.right.equalToSuperview().offset(Appearance.nameLabelRightOffset)
            make.top.equalToSuperview().offset(Appearance.nameLabelTopOffset)
        }
        
        homeworldLabel.snp.makeConstraints { make in
            
            make.centerY.equalTo(heroImageView.snp.centerY)
            make.left.equalTo(heroImageView.snp.right).offset(Appearance.homeworldLabelLeftOffset)
            make.right.equalToSuperview().offset(Appearance.homeworldLabelRightOffset)
        }
        
        genderLabel.snp.makeConstraints { make in
            
            make.left.equalTo(heroImageView.snp.right).offset(Appearance.genderLabelLeftOffset)
            make.right.equalToSuperview().offset(Appearance.genderLabelRightOffset)
            make.bottom.equalToSuperview().offset(Appearance.genderLabelBottomOffset)
        }
    }

}
