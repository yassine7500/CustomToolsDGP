////
////  MediaFileActions.swift
////  CustomToolsDGP
////
////  Created by David SG on 04/09/2020.
////  Copyright © 2020 David Galán. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//import CoreLocation
//import UserNotifications
//import MobileCoreServices
//import AVKit
//import CustomToolsDGP
//
//
//public protocol MediaFilesActionsProtocol: class {
//    func reloadData()
//}
//
//public class MediaFilesActions: UIViewController, UINavigationControllerDelegate {
//    
//    // MARK: ENUMS
//    public enum MediaSource {
//        case photoLibrary
//        case camera
//    }
//    
//    public enum MediaType {
//        case image
//        case video
//    }
//    
//    public enum DocumentsType: Int {
//        case image = 1
//        case document = 2
//        case audio = 3
//        case video = 4
//        case note = 5
//    }
//    
//    // MARK: PARAMETERS
//    weak var mediaFilesDelegate: MediaFilesActionsProtocol?
//    var recordAudio: RecordAudioPopupViewController?
//    var viewControllerDelegate: UIViewController!
//    var imagePicker: UIImagePickerController?
//    var docParams: [String : Any] = [:]
//    let permissionTools = PermissionTools()
//    
//    var typeBookSelected: ObraApp.BookTypes?
//    var typeDocumentSelected: MediaFilesActions.DocumentsType?
//    
//    var latitudeUserValue: Double = 0.0
//    var longitudeUserValue: Double = 0.0
//    
//    var constructionID: Int?
//    var imageStr: String? = ""
//    
//    var titleAnnotationValue = ""
//    var textAnnotationValue = ""
//    var collaboratorsIds = [Int]()
//    
//    var arrayFilesBase64 = [String]()
//    var arrayTypesFiles = [Int]()
//    
//    // MARK: INIT METHODS
//    init(documentType: DocumentsType, mediaFilesDelegate: MediaFilesActionsProtocol, viewController: UIViewController, typeBookSelected: ObraApp.BookTypes? = nil, constructionID: Int, title: String, annotation: String, collaboratorsIds: [Int] = [Int](), latitude: Double, longitude: Double) {
//        
//        self.mediaFilesDelegate = mediaFilesDelegate
//        self.typeDocumentSelected = documentType
//        self.viewControllerDelegate = viewController
//        self.titleAnnotationValue = title
//        self.textAnnotationValue = annotation
//        self.collaboratorsIds = collaboratorsIds
//        self.typeBookSelected = typeBookSelected
//        self.constructionID = constructionID
//        self.latitudeUserValue = latitude
//        self.longitudeUserValue = longitude
//        
//        super.init(nibName: nil, bundle: nil)
//        
//        switch documentType {
//            
//        case .image:
//            self.checkCameraPermission(isVideo: false)
//            break
//        case .document:
//            self.openDocumentSelector()
//            break
//        case .audio:
//            self.actionButtonMicrophone(isVideo: false)
//            break
//        case .video:
//            self.checkCameraPermission(isVideo: true)
//            break
//        case .note:
//            break
//        }
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: OTHER METHODS
//    private func resetArrayValues() {
//        docParams = [:]
//        collaboratorsIds = [Int]()
//        arrayFilesBase64 = [String]()
//        arrayTypesFiles = [Int]()
//    }
//    
//}
//
//// MARK: PERMISSIONS METHODS
//extension MediaFilesActions {
//    
//    // CAMERA
//    public func checkCameraPermission(isVideo: Bool) {
//        
//        permissionTools.checkCameraPermission { (videoPermissionValue) in
//            
//            if videoPermissionValue == .granted {
//                
//                DispatchQueue.main.async {
//                    if isVideo {
//                        self.actionButtonMicrophone(isVideo: true)
//                    } else {
//                        self.chooseTypeMediaOrigin(typeMedia: .image)
//                    }
//                }
//                
//            } else if videoPermissionValue == .denied {
//                
//                if isVideo {
//                    ObraApp.shared.showAlertPermision(viewController: self.viewControllerDelegate, typeError: .video)
//                } else {
//                    ObraApp.shared.showAlertPermision(viewController: self.viewControllerDelegate, typeError: .images)
//                }
//                
//            }
//        }
//    }
//    
//    // MICROPHONE
//    private func actionButtonMicrophone(isVideo: Bool) {
//        
//        permissionTools.checkMicrophonePermission { (microphonePermissionStatus) in
//            
//            if microphonePermissionStatus == .denied {
//                
//                if isVideo {
//                    
//                    DispatchQueue.main.async {
//                        
//                        self.viewControllerDelegate.showCustomAlert(alertType: .alert, titleValue: languageManager.getMultilingualText(key: "permissions_text"), descriptionValue: languageManager.getMultilingualText(key: "microphone_video_permission_alert_text"), buttonTextValue: .configuration, image: .alertRed) { alertCustomVC in
//                            
//                            alertCustomVC.addOkAction {
//                                DeviceTools().openAppSystemConfiguration()
//                            }
//                            
//                            alertCustomVC.addCloseAction {
//                                DispatchQueue.main.async {
//                                    self.chooseTypeMediaOrigin(typeMedia: .video)
//                                }
//                            }
//                        }
//                        
//                    }
//                    
//                } else {
//                    ObraApp.shared.showAlertPermision(viewController: self.viewControllerDelegate, typeError: .microphone)
//                }
//                
//            } else if microphonePermissionStatus == .granted {
//                
//                DispatchQueue.main.async {
//                    if isVideo {
//                        self.chooseTypeMediaOrigin(typeMedia: .video)
//                    } else {
//                        self.openAudioPopup()
//                    }
//                }
//            }
//            
//        }
//        
//    }
//    
//    
//}
//
//extension MediaFilesActions {
//    
//    // MARK: CAMERA METHODS
//    
//    // 1.A. SELECT GALLERY O CAMERA
//    private func chooseTypeMediaOrigin(typeMedia: MediaType) {
//        
//        let actionA = UIAlertAction(title: languageManager.getMultilingualText(key: "camera_text"), style: .default, handler: { _ in
//            
//            if typeMedia == .image {
//                self.imageSourceActions(source: .camera)
//            } else {
//                self.startMediaBrowser(delegate: self, sourceType: .camera)
//            }
//        })
//        
//        let actionB = UIAlertAction(title: languageManager.getMultilingualText(key: "gallery_text"), style: .default, handler: { _ in
//            
//            if typeMedia == .image {
//                self.imageSourceActions(source: .photoLibrary)
//            } else {
//                self.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
//            }
//        })
//        
//        ObraApp.shared.showUIAlertController(delegate: self.viewControllerDelegate, title: languageManager.getMultilingualText(key: "choose_origin_text"), message: nil, buttonAText: actionA, buttonBText: actionB, buttonCancelText: true)
//        
//    }
//    
//    // 2.1. - PHOTO ACTIONS
//    private func imageSourceActions(source: MediaSource) {
//        
//        imagePicker =  UIImagePickerController()
//        imagePicker?.allowsEditing = true
//        imagePicker?.delegate = self
//        
//        switch source {
//        case .camera:
//            imagePicker?.sourceType = .camera
//        case .photoLibrary:
//            imagePicker?.sourceType = .photoLibrary
//        }
//        
//        guard imagePicker != nil else { return }
//        
//        DispatchQueue.main.async {
//            self.viewControllerDelegate.present(self.imagePicker!, animated: true, completion: nil)
//        }
//    }
//    
//    // 2.2. - VIDEO ACTIONS
//    func startMediaBrowser(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerController.SourceType) {
//        
//        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
//        
//        imagePicker = UIImagePickerController()
//        imagePicker?.sourceType = sourceType
//        imagePicker?.mediaTypes = [kUTTypeMovie as String]
//        imagePicker?.videoQuality = UIImagePickerController.QualityType.typeHigh
//        imagePicker?.allowsEditing = true
//        imagePicker?.delegate = delegate
//        
//        guard imagePicker != nil else { return }
//        
//        DispatchQueue.main.async {
//            delegate.present(self.imagePicker!, animated: true, completion: nil)
//        }
//    }
//    
//}
//
//
//extension MediaFilesActions: UIImagePickerControllerDelegate {
//    
//    // 3. PICKER RESPONSE
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        DispatchQueue.main.async {
//            
//            self.docParams = [:]
//            
//            DispatchQueue.main.async {
//                self.pleaseWait()
//                self.imagePicker?.dismiss(animated: true, completion: nil)
//            }
//            
//            if info[.mediaType] as? String == (kUTTypeMovie as String), let selectedVideo: URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
//                
//                // VIDEO
//                self.actionsWithVideo(videoUrl: selectedVideo)
//                
//            } else {
//                
//                // IMAGE
//                self.actionsWithImage(info: info)
//                
//            }
//        }
//    }
//    
//}
//
//extension MediaFilesActions {
//    
//    // 4.1 - VIDEO ACTIONS
//    private func actionsWithVideo(videoUrl: URL) {
//        
//        DispatchQueue.main.async {
//            
//            self.pleaseWait()
//            
//            let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + UUID().uuidString + ".mp4")
//            self.compressVideo(inputURL: videoUrl as URL, outputURL: compressedURL) { exportSession in
//                
//                guard let session = exportSession else { return }
//                
//                switch session.status {
//                    
//                case .unknown:
//                    break
//                case .waiting:
//                    break
//                case .exporting:
//                    break
//                case .completed:
//                    
//                    let nsData = NSData(contentsOf: compressedURL)
//                    let base64vid = nsData?.base64EncodedString(options: [])
//                    
//                    self.arrayFilesBase64.append(base64vid ?? "")
//                    self.arrayTypesFiles.append(DocumentsType.video.rawValue)
//                    
//                    self.fillRequestParameters(base64: self.arrayFilesBase64, typeFiles: self.arrayTypesFiles)
//                    self.sendMediaContent()
//                    
//                case .failed:
//                    self.showAlertVideoError()
//                    break
//                case .cancelled:
//                    self.showAlertVideoError()
//                    break
//                @unknown default:
//                    self.showAlertVideoError()
//                    break
//                }
//            }
//        }
//        
//    }
//    
//    
//    // COMPRESS VIDEO
//    func compressVideo(inputURL: URL, outputURL: URL, handler: @escaping (_ exportSession: AVAssetExportSession?) -> Void) {
//        
//        let urlAsset = AVURLAsset(url: inputURL, options: nil)
//        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
//            handler(nil)
//            return
//        }
//        
//        exportSession.outputURL = outputURL
//        exportSession.outputFileType = .mp4
//        exportSession.exportAsynchronously {
//            handler(exportSession)
//        }
//    }
//    
//    // VIDEO ERROR
//    private func showAlertVideoError() {
//        self.viewControllerDelegate.showCustomAlert(alertType: .alert, titleValue: languageManager.getMultilingualText(key: "error_text"), descriptionValue: languageManager.getMultilingualText(key: "video_saving_error"), buttonTextValue: .accept, image: .alertRed) { (customAlertVC) in }
//    }
//    
//}
//
//
//extension MediaFilesActions {
//    
//    // 4.2 - IMAGE ACTIONS
//    private func actionsWithImage(info: [UIImagePickerController.InfoKey: Any]) {
//        
//        var imageData: Data
//        if let editedImage = info[.editedImage] as? UIImage {
//            imageData = (editedImage.jpegData(compressionQuality: 1.0)?.base64EncodedData())!
//            self.imageStr =  String(data: imageData, encoding: String.Encoding.utf8)!
//        } else if let image = info[.originalImage] as? UIImage {
//            imageData = (image.jpegData(compressionQuality: 1.0)?.base64EncodedData())!
//            self.imageStr =  String(data: imageData, encoding: String.Encoding.utf8)!
//        }
//        
//        self.arrayFilesBase64.append(self.imageStr ?? "")
//        self.arrayTypesFiles.append(DocumentsType.image.rawValue)
//        
//        self.fillRequestParameters(base64: self.arrayFilesBase64, typeFiles: self.arrayTypesFiles)
//        
//        askForMoreImages()
//    }
//    
//    private func askForMoreImages() {
//        
//        let actionA = UIAlertAction(title: languageManager.getMultilingualText(key: "yes_text"), style: .default, handler: { _ in
//            self.chooseTypeMediaOrigin(typeMedia: .image)
//        })
//        
//        let actionB = UIAlertAction(title: languageManager.getMultilingualText(key: "no_text"), style: .default, handler: { _ in
//            self.sendMediaContent()
//        })
//        
//        ObraApp.shared.showUIAlertController(delegate: self.viewControllerDelegate, title: languageManager.getMultilingualText(key: "add_more_images_text"), message: nil, buttonAText: actionA, buttonBText: actionB, buttonCancelText: false)
//        
//    }
//    
//}
//
//
//extension MediaFilesActions: UIDocumentPickerDelegate {
//    
//    // MARK: 1.B - DOCUMENTS METHODS
//    private func openDocumentSelector() {
//        
//        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeImage)], in: .import)
//        importMenu.delegate = self
//        importMenu.modalPresentationStyle = .fullScreen
//        
//        DispatchQueue.main.async {
//            self.viewControllerDelegate.present(importMenu, animated: true, completion: nil)
//        }
//    }
//    
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        
//        DispatchQueue.main.async {
//            if FileManager.default.fileExists(atPath: url.path) {
//                var docNum: Int?
//                docNum = realm.objects(Document.self).sorted(byKeyPath: "id", ascending: true).last?.id
//                
//                if docNum == nil {
//                    docNum = 1
//                }
//                
//                let data = try! Data(contentsOf: url)
//                
//                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//                let dataPath = paths[0].appendingPathComponent(FileManager.default.displayName(atPath: url.path))
//                try! data.write(to: dataPath)
//                
//                let nsData = NSData(contentsOf: url)
//                
//                if let base64doc = nsData?.base64EncodedString(options: []) {
//                    
//                    self.arrayFilesBase64.append(base64doc)
//                    self.arrayTypesFiles.append(DocumentsType.document.rawValue)
//                    
//                    self.docParams = [:]
//                    self.fillRequestParameters(base64: self.arrayFilesBase64, typeFiles: self.arrayTypesFiles)
//                    
//                    self.sendMediaContent()
//                    
//                } else {
//                    self.viewControllerDelegate.showCustomAlert(alertType: .alert, titleValue: languageManager.getMultilingualText(key: "information_text"), descriptionValue: languageManager.getMultilingualText(key: "token_expired_message_text"), image: .alertRed) { alertCustomVC in }
//                }
//            }
//        }
//    }
//    
//}
//
//extension MediaFilesActions: RecordAudioProtocol {
//    
//    // MARK: 1.C - AUDIO METHODS
//    public func openAudioPopup() {
//        
//        getNewViewController(storyBoardName: "Constructions", viewIdentifier: "recordAudioPopupVC") { (viewControllerResult) in
//            
//            if let vc = viewControllerResult as? RecordAudioPopupViewController {
//                
//                self.recordAudio = vc
//                self.recordAudio?.recordAudioDelegate = self
//                self.viewControllerDelegate.openPopupView(viewController: self.recordAudio!, alphaBlackComponent: 0.0, completion: {
//                    
//                    self.recordAudio?.view.translatesAutoresizingMaskIntoConstraints = false
//                    self.recordAudio?.view.leadingAnchor.constraint(equalTo: self.viewControllerDelegate.view.leadingAnchor, constant: 0).isActive = true
//                    self.recordAudio?.view.trailingAnchor.constraint(equalTo: self.viewControllerDelegate.view.trailingAnchor, constant: 0).isActive = true
//                    self.recordAudio?.view.bottomAnchor.constraint(equalTo: self.viewControllerDelegate.view.bottomAnchor, constant: 0).isActive = true
//                    self.recordAudio?.view.heightAnchor.constraint(equalToConstant: self.viewControllerDelegate.view.frame.height).isActive = true
//                })
//            }
//        }
//    }
//    
//    func returnAudioData(audioFileBase64: String) {
//        
//        self.arrayFilesBase64.append(audioFileBase64)
//        self.arrayTypesFiles.append(VisitBookConstructionViewController.DocumentsType.audio.rawValue)
//        
//        self.fillRequestParameters(base64: self.arrayFilesBase64, typeFiles: self.arrayTypesFiles)
//        sendMediaContent()
//    }
//    
//}
//
//
//extension MediaFilesActions {
//    
//    private func fillRequestParameters(base64: [String], typeFiles: [Int]) {
//        
//        if self.typeBookSelected != nil {
//            self.docParams["title"] = self.titleAnnotationValue
//            self.docParams["description"] = self.textAnnotationValue
//            self.docParams["images"] = base64
//            self.docParams["types"] = typeFiles
//        } else {
//            self.docParams["name"] = self.titleAnnotationValue
//            self.docParams["notes"] = self.textAnnotationValue
//            self.docParams["url"] = base64
//            self.docParams["type"] = typeFiles
//        }
//    }
//    
//    // 5 - SAVE MEDIA CONTENT
//    private func sendMediaContent() {
//        
//        self.docParams["lat"] = self.latitudeUserValue
//        self.docParams["lon"] = self.longitudeUserValue
//
//        
//        if self.collaboratorsIds.count > 0 {
//            self.docParams["collaborators"] = self.collaboratorsIds
//        }
//        
//        print(text: "DOC.PARAMS: \(docParams)", type: .favRed)
//        
//        guard self.constructionID != nil else {
//            
//            self.viewControllerDelegate.showCustomAlert(alertType: .alert, titleValue: languageManager.getMultilingualText(key: "error_text"), descriptionValue: languageManager.getMultilingualText(key: "token_expired_message_text")) { (customAlertVC) in
//            }
//            
//            return
//        }
//        
//        
//        if self.typeBookSelected != nil {
//
//            BooksAnnotationsRequest(viewController: self.viewControllerDelegate).getBooksAnnotationsResponse(typeBook: self.typeBookSelected!, typeRequest: .createBookAnnotations, constructionIdOrAnnotationIdToDelete: self.constructionID!, params: self.docParams) { (_) in
//                
//                self.resetArrayValues()
//                self.mediaFilesDelegate?.reloadData()
//            }
//            
//        } else {
//            
//            self.docParams["constructionID"] = self.textAnnotationValue
//            
//            DocumentsRequest(viewController: self).getDocumentsResponse(typeRequest: .saveDocuemnts, params: self.docParams) { (success) in
//
//                if success {
//                    self.mediaFilesDelegate?.reloadData()
//                }
//            }
//        }
//        
//    }
//    
//}
