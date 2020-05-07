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
        
        static let animationDuration = 0.5
        static let endAlpha: CGFloat = 1.0
        
        static let cardWidthMultiplier: CGFloat = 0.85
        static let cardHeight: CGFloat = 400
        
        static let cardCornerRadius: CGFloat = 15
        
        static let longPressDuration: TimeInterval = 0.5
        
        static let completionDelta: CGFloat = 0.5
        static let animationMiddlePoint = 0.5
        static let animationEndPoint = 1.0
    }
    
    //MARK: - Animators
    var animateToCard: UIViewPropertyAnimator!
    var animateToFullScreen: UIViewPropertyAnimator!
    var animateToDismiss: UIViewPropertyAnimator!
    
    var currentlyDismissing = false {
        
        didSet {
            
            if currentlyDismissing {
                
                animateToFullScreen.stopAnimation(true)
                animateToFullScreen = toFullScreenAnimator?()
            }
            else {
                
                animateToDismiss.stopAnimation(true)
                animateToDismiss = toDismissAnimator?()
            }
        }
    }
    
    //MARK: - Haptic
    lazy var impact: UIImpactFeedbackGenerator = {
        
        let impact = UIImpactFeedbackGenerator()
        
        return impact
    }()
    
    private var toFullScreenAnimator: (() -> UIViewPropertyAnimator)?
    private var toDismissAnimator: (() -> UIViewPropertyAnimator)?
    private var toCardAnimator: (() -> UIViewPropertyAnimator)?
    
    //MARK: - Views
    var detailView: DetailView!
    var detailViewInitialFrame: CGRect?

    var coverView = UIVisualEffectView()
    
    var mainView = MainView()
    var presenter: MainViewOutput!
    
    var initialTranslation: CGFloat = .zero
    
    lazy var cellLongPressGestureRecognizer: UILongPressGestureRecognizer = {
        
        let recognizer = UILongPressGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleLongPress(gestureRecognizer:)))
        recognizer.minimumPressDuration = Appearance.longPressDuration
        
        return recognizer
    }()
    
    lazy var cardPanGestureRecognizer: UIPanGestureRecognizer = {
        
        let recognizer = PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(handlePan(gestureRecognizer:)))
        
        return recognizer
    }()
    
    lazy var cardExpandGestureRecognizer: UITapGestureRecognizer = {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleExpand(gestureRecognizer:)))
        
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
        
        if self.detailView.mainScrollView.isScrollEnabled {
            self.detailView.mainScrollView.isScrollEnabled.toggle()
        }
        
        if percentage > .zero {
            
            if !currentlyDismissing {
                currentlyDismissing.toggle()
            }
            
            animateToDismiss.fractionComplete = CGFloat(percentage)
        }
        else {
            
            if currentlyDismissing {
                currentlyDismissing.toggle()
            }
            
            animateToFullScreen.fractionComplete = abs(CGFloat(percentage))
        }
    }
    
    func finishPanAnimation() {
                
        if animateToDismiss.fractionComplete > Appearance.completionDelta {
            animateToDismiss.startAnimation()
        }
        else if animateToFullScreen.fractionComplete > Appearance.completionDelta {
            animateToFullScreen.startAnimation()
        }
        else {
                        
            animateToDismiss.stopAnimation(true)
            animateToFullScreen.stopAnimation(true)
            animateToCard = toCardAnimator?()
            
            animateToCard.addCompletion { [unowned self] _ in
                
                self.animateToDismiss = self.toDismissAnimator?()
                self.animateToFullScreen = self.toFullScreenAnimator?()
                self.detailView.mainScrollView.isScrollEnabled = false
            }
            
            animateToCard.startAnimation()
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
        
        prepareForAnimation(hero: hero, at: indexPath)
        animateToFullScreen.startAnimation()
    }
    
    //MARK: - Display as card
    func displayDetailViewAsCard(for hero: HeroDto, at indexPath: IndexPath) {
        
        prepareForAnimation(hero: hero, at: indexPath)
        animateToCard.startAnimation()
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
    func prepareForAnimation(hero: HeroDto, at indexPath: IndexPath) {
        
        detailView = DetailView(hero: hero, delegate: self)
        detailView.addGestureRecognizer(cardPanGestureRecognizer)
        coverView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        coverView.alpha = .zero
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
        let cardToFrame = CGRect(x: cellFrame.origin.x + xTranslation, y: self.view.frame.origin.y + yTranslation, width: cellFrame.width * Appearance.cardWidthMultiplier, height: Appearance.cardHeight)
        
        toFullScreenAnimator = { [unowned self] in
        
            let animateToFullScreen = UIViewPropertyAnimator(duration: Appearance.animationDuration, curve: .easeOut) { [unowned self] in
                
                self.detailView.frame = self.view.frame
                self.detailView.alpha = Appearance.endAlpha
                self.detailView.layoutIfNeeded()
            }
            
            animateToFullScreen.addCompletion { _ in
                
                self.detailView.mainScrollView.isScrollEnabled = true
                self.detailView.mainScrollView.setContentOffset(CGPoint(x: .zero, y: -self.detailView.mainScrollView.adjustedContentInset.top), animated: true)
            }
            
            return animateToFullScreen
        }
        
        animateToFullScreen = toFullScreenAnimator?()
        
        toCardAnimator = { [unowned self] in
            
            let animateToCard = UIViewPropertyAnimator(duration: Appearance.animationDuration, curve: .easeOut, animations: { [unowned self] in
                
                self.coverView.alpha = Appearance.endAlpha
                self.detailView.layer.cornerRadius = Appearance.cardCornerRadius
                self.detailView.frame = cardToFrame
                self.detailView.alpha = Appearance.endAlpha
            })
            
            animateToCard.addCompletion { _ in
                
                self.detailView.mainScrollView.isScrollEnabled = false
                self.detailView.addGestureRecognizer(self.cardExpandGestureRecognizer)
            }
                                    
            return animateToCard
        }
        
        animateToCard = toCardAnimator?()
        
        toDismissAnimator = { [unowned self] in
            
            let animateToDismiss = UIViewPropertyAnimator(duration: Appearance.animationDuration, curve: .easeOut) { [unowned self] in
                
                self.detailView.frame = CGRect(x: .zero, y: self.view.frame.height, width: self.view.frame.width, height: self.detailView.frame.height)
                self.coverView.alpha = .zero
                self.detailView.layoutIfNeeded()
            }
            
            animateToDismiss.addCompletion { [unowned self] _ in
                
                self.cleanUpAnimationRelatedObjects()
            }
            
            return animateToDismiss
        }
        
        animateToDismiss = toDismissAnimator?()
    }
    
    func cleanUpAnimationRelatedObjects() {
        
        if let fullScreenAnimator = self.animateToFullScreen, fullScreenAnimator.isInterruptible {
            
            fullScreenAnimator.stopAnimation(true)
        }
        
        if let cardAnimator = self.animateToCard, cardAnimator.isInterruptible {
            
            cardAnimator.stopAnimation(true)
        }
        
        if let dismissAnimator = self.animateToDismiss, dismissAnimator.isInterruptible {
            
            dismissAnimator.stopAnimation(true)
        }
        
        self.detailViewInitialFrame = .none
        self.coverView.removeFromSuperview()
        self.detailView.removeGestureRecognizer(self.cardPanGestureRecognizer)
        self.detailView.removeFromSuperview()
        
        self.animateToCard = .none
        self.animateToDismiss = .none
        self.animateToFullScreen = .none
    }
    
    //MARK: - Detail View Delegate
    func didPressExitButton() {
        animateToDismiss.startAnimation()
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
        
        let currentTranslation = gestureRecognizer.translation(in: view).y
        
        switch gestureRecognizer.state {
            
        case .changed:
            
            let translationPercentage = currentTranslation / view.frame.height * 2
            presenter.updatePanAnimationPercentage(with: Double(translationPercentage))
            
        case .ended:
            presenter.finishPanAnimation()
        default:
            break
        }
    }
    
    @objc func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
        animateToDismiss.startAnimation()
    }
    
    @objc func handleExpand(gestureRecognizer: UITapGestureRecognizer) {
        
        detailView.removeGestureRecognizer(gestureRecognizer)
        animateToFullScreen.startAnimation()
    }
}
