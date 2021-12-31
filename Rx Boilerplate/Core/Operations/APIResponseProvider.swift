//
//  APIResponseProvider.swift
//  Rx Boilerplate
//
//  Created by Aaron Lee on 2021/12/31.
//

import Foundation

typealias APIResponseProviderOnComplete = (_ apiError: APIError?,
                                           _ success: Bool) -> Void

protocol APIResponseProvider: AsyncOperation {
  var apiError: APIError? { get set }
  var success: Bool { get set }
  var onComplete: APIResponseProviderOnComplete? { get set }
}

extension APIResponseProvider {
  func requestDidFinish(_ apiError: APIError?,
                        success: Bool) {
    defer { state = .finished }

    self.apiError = apiError
    self.responseError = responseError
    self.success = success

    onComplete?(apiError, responseError, success)
  }
}
