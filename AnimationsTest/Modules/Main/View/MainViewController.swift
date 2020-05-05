//
//  MainMainViewController.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import UIKit

protocol MainViewInput: class {
    
    func setupInitialState()
    func reloadTable()
    func set(dataSource: UITableViewDataSource)
}

protocol MainViewOutput {

    func viewIsReady()
    var navTitle: String { get }
    func didActivateDeleteAction(at indexPath: IndexPath)
}


class MainViewController: UIViewController, MainViewInput {
    
    var output: MainViewOutput!
    
    /// Table view for heroes
    private var tableView: UITableView!
    
    /// Haptic touch generator
    private let generator = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = output.navTitle
        
        output.viewIsReady()
        initTableView()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Method, that initialize tableView & add constraints to it
    private func initTableView() {
        
        tableView = UITableView()
        
        tableView.delegate = self        
        tableView.register(cell: HeroCell.self)
        tableView.frame = view.frame
        
        view.addSubview(tableView)
    }
    
    /// Method for reload table after data got
    func reloadTable() {
        tableView.reloadData()
    }
    
    
    /// Meethod to set data source to table
    /// - Parameter dataSource: datasource to be install as datasource
    func set(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    // MARK: MainViewInput
    func setupInitialState() {
    }
}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        generator.impactOccurred()
        print("Selected")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let renameAction = UIContextualAction(style: .normal, title: "Rename") { [weak self] _, _, completion in
                        
            completion(true)
        }
        
        renameAction.image = UIImage(systemName: Constants.renameButtonImageName)
        
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.deleteButtonTitle) { [weak self] _, _, completion in
            
            self?.output.didActivateDeleteAction(at: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: Constants.deleteButtonImageName)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, renameAction])
        
        configuration.performsFirstActionWithFullSwipe = true        
        
        return configuration
    }
    
}
