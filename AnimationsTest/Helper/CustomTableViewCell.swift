//
//  CustomTableViewCell.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitileLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with post: PostDto) {
        
        postImageView.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: Constants.placeholderImageName))
        postTitileLabel.text = post.title
        postBodyLabel.text = post.body
    }

}
