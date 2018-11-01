//
//  NSThreadClass.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import Dispatch

// MARK: - Global functions
/// Runs a block on main thread.
///
/// - Parameter block: Block to be executed.
public func runOnMainThread(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: {
        block()
    })
}

/// Runs a block in background.
///
/// - Parameter block: block Block to be executed.
public func runInBackground(_ block: @escaping () -> Void) {
    DispatchQueue.global().async {
        block()
    }
}

/**
 Runs after time
 **/
public func runOnAfterTime(afterTime : Double , block: @escaping () -> ()) {
    let dispatchTime = DispatchTime.now() + afterTime
    DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
        block()
    }
}
