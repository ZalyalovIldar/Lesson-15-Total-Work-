//
//  RouterMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class RouterMock: MainRouterInput {
    
    var shouldDisplayRenamingAlert = false
    var shouldDisplayErrorAlert = false
    
    func showRenamingAlert(initial name: String, indexPath: IndexPath) {
        shouldDisplayRenamingAlert.toggle()
    }
    
    func showErrorAlert(text: String) {
        shouldDisplayErrorAlert.toggle()
    }
}
