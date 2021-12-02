//
//  Observable.swift
//  AppToYou
//
//  Created by mac on 2.12.21.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
