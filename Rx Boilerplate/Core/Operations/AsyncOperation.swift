//
//  AsyncOperation.swift
//  Rx Boilerplate
//
//  Created by Aaron Lee on 2021/12/31.
//

import Foundation

/// Async Operation
import Foundation

class AsyncOperation: Operation {
  // Create state management
  enum State: String {
    case ready, executing, finished

    fileprivate var keyPath: String {
      "is\(rawValue.capitalized)"
    }
  }

  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }

  // Override properties
  override var isReady: Bool {
    super.isReady && state == .ready
  }

  override var isExecuting: Bool {
    state == .executing
  }

  override var isFinished: Bool {
    state == .finished
  }

  override var isAsynchronous: Bool {
    true
  }

  // Override start
  override func start() {
    if isCancelled {
      state = .finished
      return
    }

    main()
    state = .executing
  }
}
