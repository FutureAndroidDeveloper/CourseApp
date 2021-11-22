//
//  AuthorizationViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import XCoordinator

protocol AuthorizationViewModelInput {
    func didLogin()
}

protocol AuthorizationViewModelOutput {
    
}



protocol AuthorizationViewModel {
    var input: AuthorizationViewModelInput { get }
    var output: AuthorizationViewModelOutput { get }
}

extension AuthorizationViewModel where Self: AuthorizationViewModelInput & AuthorizationViewModelOutput {
    var input: AuthorizationViewModelInput { return self }
    var output: AuthorizationViewModelOutput { return self }
}


class LoginViewModelImpl: AuthorizationViewModel, AuthorizationViewModelInput, AuthorizationViewModelOutput {

    private let router: UnownedRouter<AppRoute>

    init(router: UnownedRouter<AppRoute>) {
        self.router = router
    }
    
    func didLogin() {
        router.trigger(.main, with: .init(animated: true))
    }
}
