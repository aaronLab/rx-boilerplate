//
//  URLRequest+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

extension URLRequest {
    
    /// 헤더 타입
    typealias Headers = [String: String?]
    
    /// Dictionary 바디 타입
    typealias DictionaryBody = [String: Any]
    
    /// json request 헤더 삽입
    private mutating func jsonRequest() {
        setValue("application/json", forHTTPHeaderField: APIHeader.contentType.rawValue)
    }
    
    /// Method 적용
    private mutating func applyMethod(_ method: HTTPMethod = .get) {
        httpMethod = method.rawValue
    }
    
    /// 헤더 적용
    private mutating func applyHeaders(_ headers: Headers? = nil) {
        guard let headers = headers else { return }
        
        headers.forEach { key, value in
            setValue(value, forHTTPHeaderField: key)
        }
    }
    
    /// Dict Body 적용
    private mutating func applyDictionaryBody(_ body: DictionaryBody? = nil) {
        guard let body = body else { return }
        
        let data = try? JSONSerialization.data(withJSONObject: body, options: [])
        httpBody = data
    }
    
    /// Encodable Body 적용
    private mutating func applyEncodableBody<T: Encodable>(_ body: T? = nil) {
        guard let body = body else { return }
        
        httpBody = body.toJson()
    }
    
    /// Json 리퀘스트 생성(메소드, 헤더 포함)
    private static func createJsonRequest(url: URL,
                                          method: HTTPMethod = .get,
                                          headers: Headers? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.jsonRequest()
        request.applyMethod(method)
        request.applyHeaders(headers)
        return request
    }
    
    /// encodable를 바디로 포함할 수 있는 request 빌더
    static func build(url: URL,
                      method: HTTPMethod = .get,
                      dataBody: Data? = nil,
                      headers: Headers? = nil) -> URLRequest {
        
        var request = URLRequest.createJsonRequest(url: url,
                                                   method: method,
                                                   headers: headers)
        request.httpBody = dataBody
        
        return request
    }
    
    /// [String: String?]의 dictionary를 바디로 포함할 수 있는 request 빌더
    static func build(url: URL,
                      method: HTTPMethod = .get,
                      dictBody: DictionaryBody? = nil,
                      headers: Headers? = nil) -> URLRequest {
        
        var request = URLRequest.createJsonRequest(url: url,
                                                   method: method,
                                                   headers: headers)
        request.applyDictionaryBody(dictBody)
        
        return request
    }
    
    /// Encodable의 바디를 포함할 수 있는 request 빌더
    static func build<T: Encodable>(url: URL,
                                    method: HTTPMethod = .get,
                                    encodableBody: T? = nil,
                                    headers: Headers? = nil) -> URLRequest {
        
        var request = URLRequest.createJsonRequest(url: url,
                                                   method: method,
                                                   headers: headers)
        request.applyEncodableBody(encodableBody)
        
        return request
    }
    
    /// 인증토큰
    static var token: String? {
        return KeychainWrapper.standard[.authToken]
    }
    
    /// 기본 헤더
    static var defaultHeader: [String: String] {
        return [APIHeader.locale.rawValue: UIDevice.currentLocale,
                APIHeader.gmt.rawValue: "\(TimeZone.currentGMT())",
                APIHeader.version.rawValue: UIApplication.appVersion,
                APIHeader.platform.rawValue: "\(UIDevice.platform)-\(UIDevice.deviceModel.rawValue)"]
    }
    
    /// 인증 헤더
    static var authHeader: [String: String?] {
        var defaultHeader = defaultHeader
        defaultHeader[APIHeader.token.rawValue] = token
        return defaultHeader
    }
    
    /// 기본 AF 헤더
    static var defaultAfHeader: HTTPHeaders {
        let headers = defaultHeader.map { HTTPHeader(name: $0, value: $1) }
        return HTTPHeaders(headers)
    }
    
    /// 인증 AF 헤더
    static var authAfHeader: HTTPHeaders {
        var headers = defaultAfHeader
        headers.add(name: APIHeader.token.rawValue, value: token ?? "")
        return headers
    }
    
}
