//
//  MainViewController.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, MainViewInput {
    
    //MARK: - Appearance Constants
    private class Appearance {
        
        static let renameActionTitle = "Rename"
        static let renameActionImageName = "square.and.pencil"
        
        static let deleteActionTitle = "Delete"
        static let deleteActionImageName = "trash"
        
        static let estimatedCellHeight: CGFloat = 232
    }
    
    //MARK: - Views
    var mainView = MainView()
    var presenter: MainViewOutput!
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.register(cell: MainTableViewCell.self)
        presenter.viewDidLoad()
    }
    
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let renameAction = UIContextualAction(style: .normal, title: Appearance.renameActionTitle) { [weak self] _, _, completion in
            
            self?.presenter.didPressedRename(on: indexPath)
            completion(true)
        }
        
        renameAction.image = UIImage(systemName: Appearance.renameActionImageName)
        
        let deleteAction = UIContextualAction(style: .destructive, title: Appearance.deleteActionTitle) { [weak self] _, _, completion in
            
            self?.presenter.didPressedDelete(on: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: Appearance.deleteActionImageName)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, renameAction])
        
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Appearance.estimatedCellHeight
    }
    
    //MARK: - View Input
    func displayTableView() {
        mainView.displayTableView()
    }
    
    func displayLoadingView() {
        mainView.displayLoadingIndicator()
    }
    
    func reloadData() {
        mainView.tableView.reloadData()
    }
    
    func reloadData(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath]) {
        
        mainView.tableView.beginUpdates()
        
        mainView.tableView.deleteRows(at: deletions, with: .automatic)
        mainView.tableView.insertRows(at: insertions, with: .automatic)
        mainView.tableView.reloadRows(at: modifications, with: .automatic)
        
        mainView.tableView.endUpdates()
    }
    
    func registerDataSource(_ dataSource: UITableViewDataSource) {
        mainView.tableView.dataSource = dataSource
    }
}
