//
//  LanguageTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//
//let languageManager = LanguageManager()
//
//
//class LanguageManager {
//
//    init() {
//
//    }
//
//    // MARK: LANGUAGES CODES
//    enum LanguageCodeType: String {
//        case cat = "ca" //optional: "ca-ES"
//        case cas = "es"
//        case eng = "en"
//    }
//
//    // MARK: VARIABLES
//    var bundleLanguage = Bundle()
//    let appLanguages = [LanguageCodeType.cat, LanguageCodeType.cas, LanguageCodeType.eng]
//
//    // MARK: DEFAULTS REFERENCES
//
//    var languageCodeEdited: Bool {
//        set {
//            UserDefaults.standard.set(newValue, forKey: "languageCodeEdited")
//        }
//        get {
//            return UserDefaults.standard.bool(forKey: "languageCodeEdited")
//        }
//    }
//
//    var languageCodeApp: String {
//        set {
//            UserDefaults.standard.set(newValue, forKey: "languageManager.languageCodeApp")
//        }
//        get {
//            return UserDefaults.standard.string(forKey: "languageManager.languageCodeApp") ?? LanguageCodeType.eng.rawValue
//        }
//    }
//
//    // MARK: METHODS TO WORK
//    func getLocaleLanguage() -> String {
//        return Locale.preferredLanguages[0]
//    }
//
//    func getMultilingualText(key: String) -> String {
//        return bundleLanguage.localizedString(forKey: key, value: nil, table: nil)
//    }
//
//    func setLanguagelUppercase(label: UILabel, keyText: String) {
//        label.text = languageManager.getMultilingualText(key: keyText).uppercased()
//    }
//
//    func setLanguageExtra(label: UILabel, keyText: String, extraText: String = "") {
//        label.text = languageManager.getMultilingualText(key: keyText) + extraText
//    }
//
//    // MARK: BUNDLE
//
//    func setBundleLanguage() {
//
//        print("LanguageCodeEdited: \(languageCodeEdited)")
//        if !languageCodeEdited {
//            languageManager.languageCodeApp = getLocaleLanguage()
//            print("languageManager.languageCodeApp-Device: \(languageManager.languageCodeApp)")
//            controlCodes()
//            print("languageManager.languageCodeApp-Device-Controled: \(languageManager.languageCodeApp)")
//            controlInitialLanguage()
//            print("languageManager.languageCodeApp-Initial: \(languageManager.languageCodeApp)")
//        }
//
//        let path = Bundle.main.path(forResource: languageManager.languageCodeApp, ofType: "lproj")
//        bundleLanguage = Bundle(path: path!)!
//    }
//
//    func controlInitialLanguage() {
//        var languageFounded = false
//        if !languageCodeEdited {
//            for language in appLanguages {
//                if language.rawValue == languageManager.languageCodeApp {
//                    languageFounded = true
//                    break
//                }
//            }
//
//            if !languageFounded {
//                languageManager.languageCodeApp = LanguageCodeType.eng.rawValue
//            }
//        }
//    }
//
//    func controlCodes() {
//
//        switch languageManager.languageCodeApp {
//            //    case "ca":
//        //        languageManager.languageCodeApp = "ca-ES"
//        case "ca-ES":
//            languageManager.languageCodeApp = "ca"
//        case "en-GB":
//            languageManager.languageCodeApp = "en"
//        case "es-ES":
//            languageManager.languageCodeApp = "es"
//        default:
//            break
//        }
//    }
//
//    func getLanguageText(language: String) -> String {
//
//        switch language {
//        case LanguageCodeType.eng.rawValue:
//            return languageManager.getMultilingualText(key: "lang_en")
//        case LanguageCodeType.cat.rawValue:
//            return languageManager.getMultilingualText(key: "lang_ca")
//        case LanguageCodeType.cas.rawValue:
//            return languageManager.getMultilingualText(key: "lang_es")
//        default:
//            return ""
//        }
//    }
//
//    func getLanguageTextShort(language: String) -> String {
//
//        switch language {
//        case LanguageCodeType.eng.rawValue:
//            return "EN"
//        case LanguageCodeType.cat.rawValue:
//            return "CAT"
//        case LanguageCodeType.cas.rawValue:
//            return "ES"
//        default:
//            return ""
//        }
//    }
//
//    func setLanguageCodeFromText(language: String) {
//
//        switch language {
//        case languageManager.getMultilingualText(key: "lang_en"):
//            languageManager.languageCodeApp = LanguageCodeType.eng.rawValue
//            return
//        case languageManager.getMultilingualText(key: "lang_ca"):
//            languageManager.languageCodeApp = LanguageCodeType.cat.rawValue
//            return
//        case languageManager.getMultilingualText(key: "lang_es"):
//            languageManager.languageCodeApp = LanguageCodeType.cas.rawValue
//            return
//        default:
//            languageManager.languageCodeApp = LanguageCodeType.cas.rawValue
//            return
//        }
//    }
//
//
//    func getCurrentLanguageText() -> String {
//        return getLanguageText(language: languageManager.languageCodeApp)
//    }
//
//    func getCurrentLanguageTextShort() -> String {
//        return getLanguageTextShort(language: languageManager.languageCodeApp)
//    }
//
//    func getLanguageId() -> Int {
//
//        // id's language according to name and description order in array product data from server.
//        switch languageManager.languageCodeApp {
//        case LanguageCodeType.cat.rawValue:
//            return 0
//        case LanguageCodeType.cas.rawValue:
//            return 1
//        case LanguageCodeType.eng.rawValue:
//            return 2
//        default:
//            return 2
//        }
//    }
//
//    func updateLanguageFromWSData(languageData: String) {
//        for language in appLanguages {
//            if language.rawValue == languageData {
//                languageCodeEdited = true
//                languageManager.languageCodeApp = languageData
//                setBundleLanguage()
//                break
//            }
//        }
//    }
//
//
//}
//
//
