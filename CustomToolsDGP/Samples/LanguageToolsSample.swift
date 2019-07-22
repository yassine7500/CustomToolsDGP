//
//  LanguageTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

//// MARK: LANGUAGES CODES
//public enum LanguageCodeType: String {
//    case cat = "ca" //optional: "ca-ES"
//    case cas = "es"
//    case eng = "en"
//}
//
//// MARK: VARIABLES
//var bundleLanguage = Bundle()
//public let appLanguages = [LanguageCodeType.cat, LanguageCodeType.cas, LanguageCodeType.eng]
//
//// MARK: DEFAULTS REFERENCES
//
//public var languageCodeEdited: Bool {
//    set {
//        UserDefaults.standard.set(newValue, forKey: "languageCodeEdited")
//    }
//    get {
//        return UserDefaults.standard.bool(forKey: "languageCodeEdited")
//    }
//}
//
//public var languageCodeApp: String {
//    set {
//        UserDefaults.standard.set(newValue, forKey: "languageCodeApp")
//    }
//    get {
//        return UserDefaults.standard.string(forKey: "languageCodeApp") ?? LanguageCodeType.eng.rawValue
//    }
//}
//
//// MARK: METHODS TO WORK
//public class LangStr {
//
//    public class func langStr(_ text: String) -> String {
//        //        return NSLocalizedString(text, comment: text) // Old method to change language texts
//        return  setLanguage(key: text)
//    }
//}
//
//
//public func getLocaleLanguage() -> String {
//    return Locale.preferredLanguages[0]
//}
//
//public func setLanguage(key: String) -> String {
//    return bundleLanguage.localizedString(forKey: key, value: nil, table: nil)
//}
//
//public func setLanguagelUppercase(label: UILabel, keyText: String) {
//    label.text = setLanguage(key: keyText).uppercased()
//}
//
//public func setLanguageExtra(label: UILabel, keyText: String, extraText: String = "") {
//    label.text = setLanguage(key: keyText) + extraText
//}
//
//// MARK: BUNDLE
//
//public func setBundleLanguage() {
//
//    print("LanguageCodeEdited: \(languageCodeEdited)")
//    if !languageCodeEdited {
//        languageCodeApp = getLocaleLanguage()
//        print("LanguageCodeApp-Device: \(languageCodeApp)")
//        controlCodes()
//        print("LanguageCodeApp-Device-Controled: \(languageCodeApp)")
//        controlInitialLanguage()
//        print("LanguageCodeApp-Initial: \(languageCodeApp)")
//    }
//
//    let path = Bundle.main.path(forResource: languageCodeApp, ofType: "lproj")
//    bundleLanguage = Bundle(path: path!)!
//}
//
//func controlInitialLanguage() {
//    var languageFounded = false
//    if !languageCodeEdited {
//        for language in appLanguages {
//            if language.rawValue == languageCodeApp {
//                languageFounded = true
//                break
//            }
//        }
//
//        if !languageFounded {
//            languageCodeApp = LanguageCodeType.eng.rawValue
//        }
//    }
//}
//
//func controlCodes() {
//
//    switch languageCodeApp {
//        //    case "ca":
//    //        languageCodeApp = "ca-ES"
//    case "ca-ES":
//        languageCodeApp = "ca"
//    case "en-GB":
//        languageCodeApp = "en"
//    case "es-ES":
//        languageCodeApp = "es"
//    default:
//        break
//    }
//}
//
//public func getLanguageText(language: String) -> String {
//
//    switch language {
//    case LanguageCodeType.eng.rawValue:
//        return setLanguage(key: "lang_en")
//    case LanguageCodeType.cat.rawValue:
//        return setLanguage(key: "lang_ca")
//    case LanguageCodeType.cas.rawValue:
//        return setLanguage(key: "lang_es")
//    default:
//        return ""
//    }
//}
//
//public func getCurrentLanguageText() -> String {
//    return getLanguageText(language: languageCodeApp)
//}
//
//public func getLanguageId() -> Int {
//
//    // id's language according to name and description order in array product data from server.
//    switch languageCodeApp {
//    case LanguageCodeType.cat.rawValue:
//        return 0
//    case LanguageCodeType.cas.rawValue:
//        return 1
//    case LanguageCodeType.eng.rawValue:
//        return 2
//    default:
//        return 2
//    }
//}
//
//public func updateLanguageFromWSData(languageData: String) {
//    for language in appLanguages {
//        if language.rawValue == languageData {
//            languageCodeEdited = true
//            languageCodeApp = languageData
//            setBundleLanguage()
//            break
//        }
//    }
//}
//
