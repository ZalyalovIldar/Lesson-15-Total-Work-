//
//  InteractorTests.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import XCTest
@testable import AnimationsTest

class InteractorTests: XCTestCase {
    
    var presenter: PresenterMock!
    var interactor: MainInteractor!
    var networkManagerFailing: NetworkManagerFailMock!
    var networkManagerSucessing: NetworkManagerSuccessMock!
    var realmManager: RealmManagerMock!

    override func setUpWithError() throws {
        
        presenter = PresenterMock()
        interactor = MainInteractor()
        networkManagerFailing = NetworkManagerFailMock()
        networkManagerSucessing = NetworkManagerSuccessMock()
        realmManager = RealmManagerMock()
        
        interactor.presenter = presenter
        interactor.realmManager = realmManager
        realmManager.interactor = interactor
    }
    
    //MARK: - fetchAllHeroes()
    func testFetchAllHeroesChecksForCachedResult() throws {
        
        interactor.networkManager = networkManagerFailing
        interactor.fetchAllHeroes()
        XCTAssertTrue(realmManager.hasCheckedForCachedCopy)
    }
    
    func testFetchAllHeroesResultedInSubscribingToRealm() throws {
        
        interactor.networkManager = networkManagerFailing
        interactor.fetchAllHeroes()
        
        let exp = expectation(description: "Should subscribe")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.01)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(realmManager.isBeingObserved)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testFetchAllHeroesResultedInCallingPresenterMethodWithSuccess() throws {
        
        interactor.networkManager = networkManagerFailing
        interactor.fetchAllHeroes()
        
        let exp = expectation(description: "Should call didFinishFetchingHeroes(result:)")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.01)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(presenter.shouldCallDidFinishFetchingHeroesWithResult)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShouldAskForDataFromNetworkManagerIfCachedDataIsEmptyEvenIfNetworkManagerWillFail() throws {
        
        interactor.networkManager = networkManagerFailing
        realmManager.shouldReturnEmptyListOnGetAll = true
        interactor.fetchAllHeroes()
        
        let exp = expectation(description: "Should ask network manager for data")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.05)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(networkManagerFailing.shouldGetAllHeroes)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShouldAskForDataFromNetworkManagerIfCachedDataIsEmpty() throws {
        
        interactor.networkManager = networkManagerSucessing
        realmManager.shouldReturnEmptyListOnGetAll = true
        interactor.fetchAllHeroes()
        
        let exp = expectation(description: "Should ask network manager for data")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.05)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(networkManagerSucessing.shouldGetAllHeroes)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShouldCallDidFinishFetchingHeroesWithResultIfDataIsFetchedFromNetwork() throws {
        
        interactor.networkManager = networkManagerSucessing
        realmManager.shouldReturnEmptyListOnGetAll = true
        interactor.fetchAllHeroes()
        
        let exp = expectation(description: "Should ask network manager for data")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.06)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(presenter.shouldCallDidFinishFetchingHeroesWithResult)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShouldCallDidFinishFetchingHeroesWithErrorIfDataIsNotFetchedFromNetwork() throws {
        
        interactor.networkManager = networkManagerFailing
        realmManager.shouldReturnEmptyListOnGetAll = true
        interactor.fetchAllHeroes()
        
        let exp = expectation(description: "Should ask network manager for data")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.1)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(presenter.shouldCallDidFinishFetchingHeroesWithError)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
    
    //MARK: - saveImage(data:id:)
    func testSavingImageShouldResultInNotification() throws {
        
        interactor.saveImage(data: Data(), id: .zero)
        
        XCTAssertTrue(realmManager.shouldNotifyInteractor)
    }
    
    //MARK: - renameRequested(on:new:)
    func testRenameRequestShouldResultInNotificationWhenPrimaryKeyIsPresent() throws {
        
        interactor.renameRequested(on: 1, new: String())
        
        XCTAssertTrue(realmManager.shouldNotifyInteractor)
    }
    
    func testRenameRequestShouldNotResultInNotificationWhenPrimaryKeyIsAbsent() throws {
        
        interactor.renameRequested(on: .zero, new: String())
        
        XCTAssertFalse(realmManager.shouldNotifyInteractor)
    }
    
    //MARK: - deleteRequested(on:)
    func testDeleteRequestShouldResultInNotificationWhenPrimaryKeyIsPresent() throws {
        
        interactor.deleteRequested(on: 1)
        
        XCTAssertTrue(realmManager.shouldNotifyInteractor)
    }
    
    func testDeleteRequestShouldNotResultInNotificationWhenPrimaryKeyIsAbsent() throws {
        
        interactor.deleteRequested(on: .zero)
        
        XCTAssertFalse(realmManager.shouldNotifyInteractor)
    }
    
    //MARK: - notificationReceived(new:deletions:insertions:modifications:)
    func testPresenterShouldCallDidReceiveNotificationWhenNotificationIsReceivedByInteractor() throws {
        
        interactor.notificationReceived(new: [], deletions: [], insertions: [], modifications: [])
        
        XCTAssertTrue(presenter.shouldCallDidReceiveUpdateNotification)
    }
    
    //MARK: - startObservingRealm()
    func testNotificationBlockActuallyInvokes() throws {
        
        interactor.startObservingRealm()
        realmManager.saveBatch([Hero(id: .zero, name: String(), image: String(), homeworld: .none, gender: String(), height: .none, mass: .none, species: String(), skinColor: .none, eyeColor: .none)], completion: {})
        
        let exp = expectation(description: "Should call notification block")
        
        let result = XCTWaiter.wait(for: [exp], timeout: 0.3)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(presenter.shouldCallDidReceiveUpdateNotification)
        }
        else {
            XCTFail("Delay interrupted")
        }
    }
}
