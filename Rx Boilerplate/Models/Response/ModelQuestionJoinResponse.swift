//
//  ModelQuestionJoinResponse.swift
//  Rippler
//
//  Created by Aaron Lee on 2021/07/07.
//

import Foundation

/// 문의하기 Join 응답
struct ModelQuestionResponse: APIResponseV1 {
    
    var code: Int?
    
    var message: String?
    
    var success: Bool?
    
    var data: ModelQuestionJoinData?

}

extension ModelQuestionResponse {
    
    /// 질문 목록
    var questions: [ModelQuestion] {
        guard let questions = data?.item else {
            return []
        }
        return questions
    }
    
    /// 질문 아이디
    var questionID: Int? {
        return questions.first?.id
    }
    
}

struct ModelQuestionJoinData: Decodable {
    
    var item: [ModelQuestion]?
    var total: Int?
    
}

struct ModelQuestion: Decodable {
    
    var id: Int?
    var messageId: Int?
    var user: Int?
    var message: String?
    var cratedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case user
        case id = "question_id"
        case messageId = "id"
        case message = "value"
        case cratedAt = "create_by"
    }
    
}

extension ModelQuestion {
    
    /// 사용자 여부
    var isUser: Bool {
        return user == 1
    }
    
}
