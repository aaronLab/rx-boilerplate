//
//  NetworkBaseOperation.swift
//  Rx Boilerplate
//
//  Created by Aaron Lee on 2021/12/31.
//

import Foundation

class NetworkBaseOperation: AsyncOperation {
  var apiError: APIError?
  var success: Bool = false
  var onComplete: APIResponseProviderOnComplete?
}

extension NetworkBaseOperation: APIResponseProvider {}
