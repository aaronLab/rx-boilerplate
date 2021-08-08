//
//  UIDevice+Ext.swift
//
//  Created by Aaron Lee on 2021/05/20.
//

import UIKit

extension UIDevice {
    
    /// 앱 ID
    static let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "N/A"
    
    /// 운영체제 버전
    static let osVersion = UIDevice.current.systemVersion
    
    /// 서버 헤더 로케일
    static let currentLocale = Locale.preferredLanguages[0]
    
    /// 플랫폼
    #if os(iOS)
    static let platform = UIDevice.current.model.range(of: "iPad") != nil ? "ipad" : "ios"
    #elseif os(watchOS)
    static let platform = "watchos"
    #elseif os(tvOS)
    static let platform = "tvos"
    #elseif os(macOS)
    static let platform = "macos"
    #else
    static let platform = "apple"
    #endif
    
    /// 브랜드
    static let brand = "apple"

    /// 디바이스 모델 분류
    enum DeviceModel: String {
        case iPod5, iPod6, iPod7
        case iPhone4, iPhone4s
        case iPhone5, iPhone5c, iPhone5s
        case iPhon6, iPhon6Plus, iPhon6s, iPhon6sPlus, iPhoneSE
        case iPhone7, iPhone7Plus
        case iPhone8, iPhone8Plus
        case iPhoneX, iPhoneXs, iPhoneXsMax, iPhoneXR
        case iPhone11, iPhone11Pro, iPhone11ProMax
        case iPhoneSE2nd
        case iPhone12Mini, iPhone12, iPhone12Pro, iPhone12ProMax
        case iPad2, iPad3, iPad4, iPad5, iPad6, iPad7, iPad8
        case iPadAir, iPadAir2, iPadAir3
        case iPadMini, iPadMini2, iPadMini3, iPadMini4, iPadMini5
        case iPadPro9in, iPadPro10in
        case iPadPro11in, iPadPro11in2
        case iPadPro13in, iPadPro13in2, iPadPro13in3, iPadPro13in4
        case appleTV, appleTV4K, homePod
        case simulator, iOS, tvOS
    }

    /// 디바이스 모델
    static let deviceModel: DeviceModel = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func map(identifier: String) -> DeviceModel {

            #if os(iOS)
                switch identifier {
                case "iPod5,1": return .iPod5
                case "iPod7,1": return .iPod6
                case "iPod9,1": return .iPod7
                case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .iPhone4
                case "iPhone4,1": return .iPhone4s
                case "iPhone5,1", "iPhone5,2": return .iPhone5
                case "iPhone5,3", "iPhone5,4": return .iPhone5c
                case "iPhone6,1", "iPhone6,2": return .iPhone5s
                case "iPhone7,2": return .iPhon6
                case "iPhone7,1": return .iPhon6Plus
                case "iPhone8,1": return .iPhon6s
                case "iPhone8,2": return .iPhon6sPlus
                case "iPhone8,4": return .iPhoneSE
                case "iPhone9,1", "iPhone9,3": return .iPhone7
                case "iPhone9,2", "iPhone9,4": return .iPhone7Plus
                case "iPhone10,1", "iPhone10,4": return .iPhone8
                case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
                case "iPhone10,3", "iPhone10,6": return .iPhoneX
                case "iPhone11,2": return .iPhoneXs
                case "iPhone11,4", "iPhone11,6": return .iPhoneXsMax
                case "iPhone11,8": return .iPhoneXR
                case "iPhone12,1": return .iPhone11
                case "iPhone12,3": return .iPhone11Pro
                case "iPhone12,5": return .iPhone11ProMax
                case "iPhone12,8": return .iPhoneSE2nd
                case "iPhone13,1": return .iPhone12Mini
                case "iPhone13,2": return .iPhone12
                case "iPhone13,3": return .iPhone12Pro
                case "iPhone13,4": return .iPhone12ProMax
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
                case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad3
                case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad4
                case "iPad6,11", "iPad6,12": return .iPad5
                case "iPad7,5", "iPad7,6": return .iPad6
                case "iPad7,11", "iPad7,12": return .iPad7
                case "iPad11,6", "iPad11,7": return .iPad8
                case "iPad4,1", "iPad4,2", "iPad4,3": return .iPadAir
                case "iPad5,3", "iPad5,4": return .iPadAir2
                case "iPad11,4", "iPad11,5": return .iPadAir3
                case "iPad2,5", "iPad2,6", "iPad2,7": return .iPadMini
                case "iPad4,4", "iPad4,5", "iPad4,6": return .iPadMini2
                case "iPad4,7", "iPad4,8", "iPad4,9": return .iPadMini3
                case "iPad5,1", "iPad5,2": return .iPadMini4
                case "iPad11,1", "iPad11,2": return .iPadMini5
                case "iPad6,3", "iPad6,4": return .iPadPro9in
                case "iPad7,3", "iPad7,4": return .iPadPro10in
                case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11in
                case "iPad8,9", "iPad8,10": return .iPadPro11in2
                case "iPad6,7", "iPad6,8": return .iPadPro13in
                case "iPad7,1", "iPad7,2": return .iPadPro13in2
                case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro13in3
                case "iPad8,11", "iPad8,12": return .iPadPro13in4
                case "AppleTV5,3": return .appleTV
                case "AppleTV6,2": return .appleTV4K
                case "AudioAccessory1,1": return .homePod
                case "IOS": return .iOS
                case "i386", "x86_64": return map(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "IOS")
                default: return .iOS
                }
            #elseif os(tvOS)
                switch identifier {
                case "AppleTV5,3": return .appleTV
                case "AppleTV6,2": return .appleTV4K
                case "tvOS": return .tvOS
                case "i386", "x86_64": return map(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS")
                default: return identifier
                }
            #endif

        }

        return map(identifier: identifier)
    }()
    
    /// 소형기기 대응
    static var isSmallDevice: Bool {
        return UIScreen.main.scale < 3
    }

}
