//
//  MainView.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    //MARK: - Views
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.accessibilityLabel = String(describing: UITableView.self)
        
        return tableView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.accessibilityLabel = String(describing: UIActivityIndicatorView.self)
        
        return indicator
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    func displayTableView() {
        
        subviews.forEach({ $0.removeFromSuperview() })
        addSubview(tableView)
        setupTableViewConstraints()
    }
    
    func displayLoadingIndicator() {
        
        subviews.forEach({ $0.removeFromSuperview() })
        addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        setupLoadingViewConstraints()
    }
    
    func setupTableViewConstraints() {
        
        tableView.snp.makeConstraints { make in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupLoadingViewConstraints() {
        
        loadingIndicator.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
        }
    }
    
}
