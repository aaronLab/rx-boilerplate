//
//  ContactManager.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import Foundation
import Contacts

/// 연락처 매니저
class ContactManager {
    
    enum ContactManagerError: Error {
        /// 권한 오류
        case permissionDenied
        /// 알 수 없는 오류
        case unknown
    }
    
    /// Contact Store
    private let store = CNContactStore()
    
    /// 주소록 권한 확인
    func checkPermission(completion: @escaping (_ granted: Bool, _ error: Error?) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        if status == .denied ||
            status == .restricted {
            completion(false, nil)
            return
        }
        
        DispatchQueue.main.async {
            self.store
                .requestAccess(for: .contacts) { granted, error in
                    
                    if error != nil {
                        completion(false, ContactManagerError.unknown)
                    }
                    
                    guard granted else {
                        // 권한 거부
                        completion(false, nil)
                        return
                    }
                    
                    completion(true, nil)
                    
                }
        }
    }
    
    /// 연락처 동기화 바디 획득
    func getFriendSyncBody(completion: @escaping (_ contacts: ModelFriendSyncBody?, _ error: Error?) -> Void) {
        
        let request = getContactRequest()
        
        checkPermission { [weak self] granted, error in
            
            if granted {
                // 권한 있음
                do {
                    
                    // 휴대폰 번호가 있는 연락처만 획득
                    var contacts = [CNContact]()
                    
                    try self?.store.enumerateContacts(with: request, usingBlock: { contact, stop in
                        
                        if !contact.phoneNumbers.isEmpty {
                            contacts.append(contact)
                        }
                        
                    })
                    
                    // 연락처 목록
                    let bodyData = contacts
                        .map { self?.getFriendSyncContent(by: $0) }
                        .filter { $0 != nil }
                    
                    // 결과 바디
                    let body = ModelFriendSyncBody(contacts: bodyData)
                    
                    completion(body, nil)
                    
                } catch {
                    // 오류
                    completion(nil, ContactManagerError.unknown)
                }
                
            } else {
                // 권한 없음
                completion(nil, ContactManagerError.permissionDenied)
            }
            
        }
        
    }
    
    /// 연락처 Key 쌍 반환
    private func getContactRequest() -> CNContactFetchRequest {
        let keys: [CNKeyDescriptor] = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                                       CNContactPhoneNumbersKey as CNKeyDescriptor]
        return CNContactFetchRequest(keysToFetch: keys)
    }
    
    /// 연락처 동기화 세부 연락처 획득
    private func getFriendSyncContent(by contact: CNContact) -> ModelFriendSyncContent? {
        // # 으로 시작하는 이름이 포함되어 있으면 PASS
        if contact.familyName.starts(with: "#") ||
            contact.middleName.starts(with: "#") ||
            contact.givenName.starts(with: "#") {
            return nil
        }
        
        // 번호 획득
        guard var mobileNo: String = contact
                .phoneNumbers
                .map({
                    ($0.value.value(forKey: "digits") as? String)? // 연락처
                        .replacingOccurrences(of: " ", with: "") // 공백 제거
                        .replacingOccurrences(of: "-", with: "") ?? "" // 하이픈 제거
                })
                .filter({ $0.hasPrefix("010") || $0.hasPrefix("+8210") || $0.hasPrefix("+82010") }) // 010, +8210, +82010으로 시작해야함
                .first
        else { return nil }
        
        // 포매팅
        if mobileNo.hasPrefix("+8210") {
            mobileNo = mobileNo.replacingOccurrences(of: "+8210", with: "010")
        }
        
        if mobileNo.hasPrefix("+82010") {
            mobileNo = mobileNo.replacingOccurrences(of: "+82010", with: "010")
        }
        
        // 이름 획득
        let name = self.getName(by: contact)
        
        return ModelFriendSyncContent(mobileNo: mobileNo, name: name)
    }
    
    /// 이름 반환
    private func getName(by contact: CNContact) -> String {
        var name = ""
        
        if contact.familyName == "" && contact.givenName == "" {
            
            if contact.organizationName == "" {
                name = "이름을 지어주세요"
            } else {
                name = contact.organizationName
            }
            
        } else {
            
            name = "\(contact.familyName) \(contact.givenName)"
            
        }
        
        return name.replacingOccurrences(of: "'", with: "")
    }
    
}
