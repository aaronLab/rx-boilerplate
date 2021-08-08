//
//  APISession.swift
//
//  Created by Aaron Lee on 2021/05/18.
//

import Foundation
import Alamofire
import RxSwift

/// APISession
struct APISession: APIService {
    
    /// 리퀘스트
    func request<T>(with request: URLRequest) -> Observable<APIResult<T>> where T : Decodable {
        
        DebugManager.shared.print(title: "Request Headers",
                                  description: request.headers,
                                  type: .normal)
        
        // 바디 디버깅
        if let body = request.httpBody?.toDict() {
            DebugManager.shared.print(title: "Request Body",
                                      description: body,
                                      type: .normal)
        }
        
        // 네트워킹
        return Observable<APIResult<T>>.create { observer in
            
            let request = AF.request(request)
            let task = request
                .responseJSON { response in
                    
                    self.handleResponse(request: request,
                                        response: response,
                                        observer: observer)
                    
                }
            
            return Disposables.create{
                // 네트워킹 종료
                task.cancel()
            }
            
        }
        
    }
    
    /// 업로드
    func upload<T>(with url: URL,
                   method: Alamofire.HTTPMethod = .post,
                   headers: HTTPHeaders? = nil,
                   parameters: [MultipartData]) -> Observable<APIResult<T>> where T: Decodable {
        
        DebugManager.shared.print(title: "Request Headers",
                                  description: headers,
                                  type: .normal)
        
        // 네트워킹
        return Observable.create { observer in
            
            // 업로드 리퀘스트
            let request = AF.upload(
                multipartFormData: { multipart in
                    parameters.forEach {
                        multipart.append($0.data, withName: $0.key.rawValue, fileName: $0.fileName, mimeType: $0.mimeType?.rawValue)
                    }
                }, to: url,
                method: method,
                headers: headers)
            
            // 업로드 작업
            let task = request
                .responseJSON { response in
                    self.handleResponse(request: request,
                                        response: response,
                                        observer: observer)
                }
            
            return Disposables.create {
                task.cancel()
            }
            
        }
        
    }
    
    /// 응답 핸들러
    private func handleResponse<T: Decodable>(request: DataRequest,
                                              response:  AFDataResponse<Any>,
                                              observer: AnyObserver<APIResult<T>>) {
        
        DebugManager.shared.print(title: "Request Started",
                                description: request,
                                type: .normal)
        
        guard let statusCode = response.response?.statusCode else {
            
            DebugManager.shared.print(title: "Request Failed - Unknown",
                                    description: request.response,
                                    type: .error)
            
            // 알 수 없는 오류
            let result = APIResult<T>(error: .unknown, response: nil)
            observer.onNext(result)
            return
        }
        
        guard let data = response.data else {
            
            DebugManager.shared.print(title: "Request Failed - HTTPError",
                                    description: request.response,
                                    type: .error)
            
            // 통신 오류
            let result = APIResult<T>(error: .httpError(statusCode), response: nil)
            observer.onNext(result)
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            
            // 성공
            let result = APIResult<T>(error: nil, response: decodedData)
            
            DebugManager.shared.print(title: "Request Success",
                                      description: decodedData,
                                      type: .success)
            
            observer.onNext(result)
        } catch(let error) {
            DebugManager.shared.print(title: "Request Failed - DecodingError",
                                      description: error.localizedDescription,
                                      type: .error)
            
            // 디코딩 오류
            let result = APIResult<T>(error: .decodingError, response: nil)
            observer.onNext(result)
            return
        }
    }
    
}
