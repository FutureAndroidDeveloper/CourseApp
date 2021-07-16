//
//  ATYUpCreateCourseViewModel.swift
//  AppToYou
//
//  Created by Philip Bratov on 22.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

class ATYUpCreateCourseViewModel {

    let interactionMode : InteractionMode

    enum InteractionMode {
        case create
        case update
    }

    init(interactionMode: InteractionMode) {
        self.interactionMode = interactionMode
    }
}
