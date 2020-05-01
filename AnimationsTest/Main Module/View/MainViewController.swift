//
//  MainViewController.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, MainViewInput, DetailViewDelegate {
    
    //MARK: - Appearance Constants
    private class Appearance {
        
        static let renameActionTitle = "Rename"
        static let renameActionImageName = "square.and.pencil"
        
        static let deleteActionTitle = "Delete"
        static let deleteActionImageName = "trash"
        
        static let estimatedCellHeight: CGFloat = 232
        
        static let oneTapAnimationDuration = 0.5
        static let endAlpha: CGFloat = 1.0
        
        static let cardWidthMultiplier: CGFloat = 0.85
        static let cardHeight: CGFloat = 400
        
        static let cardCornerRadius: CGFloat = 15
        
        static let longPressDuration: TimeInterval = 0.5
        
        static let panUpperDelta = 0.4
        static let panLowerDelta = 0.6
        static let animationMiddlePoint = 0.5
        static let animationEndPoint = 1.0
    }
    
    //MARK: - Animators
    var oneTapAnimator: UIViewPropertyAnimator!
    var longPressAnimator: UIViewPropertyAnimator!
    
    var panAnimator: UIViewPropertyAnimator!
    
    //MARK: - Haptic
    lazy var impact: UIImpactFeedbackGenerator = {
        
        let impact = UIImpactFeedbackGenerator()
        
        return impact
    }()
    
    //MARK: - Views
    var detailView: DetailView!
    var detailViewInitialFrame: CGRect?
    var coverView = UIVisualEffectView()
    
    var mainView = MainView()
    var presenter: MainViewOutput!
    
    lazy var cellLongPressGestureRecognizer: UILongPressGestureRecognizer = {
        
        let recognizer = UILongPressGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleLongPress(gestureRecognizer:)))
        recognizer.minimumPressDuration = Appearance.longPressDuration
        recognizer.delegate = self
        
        return recognizer
    }()
    
    lazy var cardPanGestureRecognizer: UIPanGestureRecognizer = {
        
        let recognizer = PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(handlePan(gestureRecognizer:)))
        recognizer.delegate = self
        
        return recognizer
    }()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.register(cell: MainTableViewCell.self)
        mainView.tableView.addGestureRecognizer(cellLongPressGestureRecognizer)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mainView.tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
    
    //MARK: - View Input
    func fireHapticImpact() {
        impact.impactOccurred()
    }
    
    func updatePanAnimationPercentage(with percentage: Double) {
        
        if percentage > Appearance.animationMiddlePoint {
            
            let normalized = (Appearance.animationEndPoint - percentage) / Appearance.animationMiddlePoint
            longPressAnimator.fractionComplete = CGFloat(normalized)
        }
        else {
            
            let normalized = Appearance.animationEndPoint - percentage / Appearance.animationMiddlePoint
            panAnimator.fractionComplete = CGFloat(normalized)
        }
    }
    
    func finishPanAnimation(at percentage: Double) {
        
        if percentage < Appearance.panUpperDelta {
            
            panAnimator.pausesOnCompletion = false
            panAnimator.isReversed = false
            
            panAnimator.addCompletion { [unowned self] _ in

                self.detailView.mainScrollView.isScrollEnabled = true
                self.detailView.mainScrollView.setContentOffset(.zero, animated: true)
            }
            
            panAnimator.startAnimation()
            
        }
        else if percentage > Appearance.panLowerDelta {
            
            longPressAnimator.pausesOnCompletion = false
            
            dismissDetailView()
        }
        else {
            
            if percentage > Appearance.animationMiddlePoint {
                
                longPressAnimator.startAnimation()
            }
            else {
                
                panAnimator.isReversed = true
                panAnimator.pausesOnCompletion = true
                
                panAnimator.startAnimation()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Appearance.oneTapAnimationDuration) { [unowned self] in
                    
                    self.panAnimator.isReversed = false
                }
            }
        }
    }
    
    func displayTableView() {
        mainView.displayTableView()
    }
    
    func displayLoadingView() {
        mainView.displayLoadingIndicator()
    }
    
    //MARK: - Display Immediately
    func displayDetailView(for hero: HeroDto, at indexPath: IndexPath) {
        
        detailView = DetailView(hero: hero, delegate: self)
        coverView.frame = mainView.frame
        
        mainView.addSubview(coverView)
        mainView.addSubview(detailView)
        detailView.setupConstraints()
        
        let cellFrame = mainView.tableView.rectForRow(at: indexPath).offsetBy(dx: -mainView.tableView.contentOffset.x, dy: -mainView.tableView.contentOffset.y)
        
        detailViewInitialFrame = cellFrame
        detailView.frame = cellFrame
        detailView.alpha = .zero
        
        detailView.layoutIfNeeded()
        
        let toFrame = CGRect(x: cellFrame.origin.x, y: self.view.frame.origin.y, width: cellFrame.width, height: self.view.frame.height)
                
        oneTapAnimator = UIViewPropertyAnimator(duration: Appearance.oneTapAnimationDuration, curve: .easeOut, animations: { [unowned self] in
            
            self.detailView.frame = toFrame
            self.detailView.alpha = Appearance.endAlpha
        })

        oneTapAnimator.startAnimation()
    }
    
    //MARK: - Display as card
    func displayDetailViewAsCard(for hero: HeroDto, at indexPath: IndexPath) {
        
        detailView = DetailView(hero: hero, delegate: self)
        detailView.addGestureRecognizer(cardPanGestureRecognizer)
        coverView = UIVisualEffectView()
        coverView.frame = mainView.frame
        detailView.mainScrollView.isScrollEnabled = false
        
        mainView.addSubview(coverView)
        mainView.addSubview(detailView)
        detailView.setupConstraints()
        
        let cellFrame = mainView.tableView.rectForRow(at: indexPath).offsetBy(dx: -mainView.tableView.contentOffset.x, dy: -mainView.tableView.contentOffset.y)
        
        detailViewInitialFrame = cellFrame
        detailView.frame = cellFrame
        detailView.alpha = .zero
        
        detailView.layoutIfNeeded()
        
        let xTranslation = (cellFrame.width - cellFrame.width * Appearance.cardWidthMultiplier) / 2
        let yTranslation = (view.frame.height - Appearance.cardHeight) / 2
        let toFrame = CGRect(x: cellFrame.origin.x + xTranslation, y: self.view.frame.origin.y + yTranslation, width: cellFrame.width * Appearance.cardWidthMultiplier, height: Appearance.cardHeight)
        
        panAnimator = UIViewPropertyAnimator(duration: Appearance.oneTapAnimationDuration, curve: .easeOut) { [unowned self] in
            
            self.detailView.frame = self.view.frame
        }
        
        panAnimator.pausesOnCompletion = true

        longPressAnimator = UIViewPropertyAnimator(duration: Appearance.oneTapAnimationDuration, curve: .easeOut, animations: { [unowned self] in
            
            self.coverView.effect = UIBlurEffect(style: .light)
            self.detailView.layer.cornerRadius = Appearance.cardCornerRadius
            self.detailView.frame = toFrame
            self.detailView.alpha = Appearance.endAlpha
        })
        
        longPressAnimator.pausesOnCompletion = true

        longPressAnimator.startAnimation()
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
    
    //MARK: - Util
    func dismissDetailView() {
        
        if let initialFrame = detailViewInitialFrame, let _ = detailView {
            
            oneTapAnimator = UIViewPropertyAnimator(duration: Appearance.oneTapAnimationDuration, curve: .easeOut) { [unowned self] in
                
                self.detailView.frame = initialFrame
                self.detailView.alpha = .zero
                self.coverView.effect = .none
            }
            
            oneTapAnimator.addCompletion { [unowned self] _ in
                
                if let panAnimator = self.panAnimator, panAnimator.isInterruptible {
                    
                    panAnimator.stopAnimation(true)
                }
                
                if let longPressAnimator = self.longPressAnimator, longPressAnimator.isInterruptible {
                    
                    longPressAnimator.stopAnimation(true)
                }
                
                self.detailViewInitialFrame = .none
                self.coverView.removeFromSuperview()
                self.detailView.removeGestureRecognizer(self.cardPanGestureRecognizer)
                self.detailView.removeFromSuperview()
            }
            
            oneTapAnimator.startAnimation()
        }
    }
    
    //MARK: - Detail View Delegate
    func didPressExitButton() {
        dismissDetailView()
    }
    
    //MARK: - Gesture Recognizers
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let point = gestureRecognizer.location(in: mainView.tableView)
            guard let indexPath = mainView.tableView.indexPathForRow(at: point) else { return }
            
            presenter.didLongPressedOnCell(at: indexPath)
        }
    }
    
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        
        let currentTranslation = gestureRecognizer.translation(in: view)
        let currentPercentage: CGFloat

        if currentTranslation.y < .zero {
            
            currentPercentage = CGFloat(Appearance.animationMiddlePoint) - (abs(currentTranslation.y) / view.frame.height) * CGFloat(Appearance.animationMiddlePoint)
        }
        else {
            currentPercentage = CGFloat(Appearance.animationMiddlePoint) + (currentTranslation.y / view.frame.height) * CGFloat(Appearance.animationMiddlePoint)
        }
        
        switch gestureRecognizer.state {
            
        case .changed:
            presenter.updatePanAnimationPercentage(with: Double(currentPercentage))
        case .ended:
            presenter.finishPanAnimation(at: Double(currentPercentage))
        default:
            break
        }
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return gestureRecognizer == cellLongPressGestureRecognizer && otherGestureRecognizer == cardPanGestureRecognizer
    }
}
