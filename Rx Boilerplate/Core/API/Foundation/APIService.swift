//
//  APIService.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation
import Alamofire
import RxSwift

/// APIService
protocol APIService {
    
    func request<T: Decodable>(with request: URLRequest) -> Observable<APIResult<T>>
    
    func upload<T: Decodable>(with url: URL,
                              method: Alamofire.HTTPMethod,
                              headers: HTTPHeaders?,
                              parameters: [MultipartData]) -> Observable<APIResult<T>>
    
}
