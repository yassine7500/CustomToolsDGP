//
//  AlertCustomVCSample.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//
//
//import UIKit
//
//enum ImageType: String {
//    case alert = "alert_red_icon_new"
//    case gps = "gps_error_icon_smap"
//    case greenTick = "tick_registro"
//    case bell = "alert_icon_gray"
//    case mail = "send_email_icon"
//}
//
//enum ColorCancelButton: String {
//    case dark
//    case red
//}
//
//class AlertCustomVCSample: UIViewController {
//
//    // MARK: OBJECTS
//    @IBOutlet weak var viewMainContainer: UIView!
//    @IBOutlet weak var viewContainer: UIView! {didSet{ viewContainer.roundSpecificsCorners(corners: [.topLeft, .topRight], radius: 8) }}
//
//    @IBOutlet weak var imageAlert: UIImageView!
//    @IBOutlet weak var labelTitle: UILabel!
//    @IBOutlet weak var labelDescription: UILabel!
//
//    @IBOutlet weak var buttonCloseView: UIButton!
//    @IBOutlet weak var buttonAccept: UIButton! {
//        didSet {
//            buttonAccept.setShadowSoft(cornerRadius: 6)
//        }
//    }
//    @IBOutlet weak var buttonCancel: UIButton! {
//        didSet {
//            buttonCancel.setShadowSoft(cornerRadius: 6)
//            buttonCancel.isHidden = true
//        }
//    }
//    @IBAction func buttonCloseViewAction(_ sender: UIButton) {actionButtonClose()}
//    @IBAction func buttonAcceptAction(_ sender: UIButton) {actionButtonAccept()}
//    @IBAction func buttonCancelAction(_ sender: UIButton) {actionButtonCancel()}
//
//    // MARK: VARIABLES & CONSTANTS
//    var titleText = ""
//    var descriptionText = ""
//    var buttonText = ""
//    var imageToLoad = ""
//    var buttonCancelText = ""
//    var titleAttributed: NSAttributedString?
//    var descriptionAttributed: NSAttributedString?
//    var hideCloseButton = false
//    var colorTitle: UIColor?
//
//    var okAction: ( ()->Void )?
//    var cancelAction: ( ()->Void )?
//    var closeAction: ( ()->Void )?
//
//    // MARK: VIEW METHODS
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setCloseButtonStatus()
//        populateObjects()
//        self.animationAppearFromBottom(viewContainer: viewContainer)
//
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        self.closePopupView()
//    }
//
//    // MARK: ACTION BUTTONS
//    public func addOkAction(_ action: @escaping ()->Void) {
//        self.okAction = action
//    }
//    public func addCloseAction(_ action: @escaping ()->Void) {
//        self.closeAction = action
//    }
//    public func addCancelAction(_ action: @escaping ()->Void) {
//        self.cancelAction = action
//    }
//
//    private func actionButtonAccept() {
//
//        self.closePopupView()
//        if let action = self.okAction {
//            action()
//        }
//    }
//
//    private func actionButtonClose() {
//
//        self.closePopupView()
//        if let action = self.closeAction {
//            action()
//        }
//    }
//
//    private func actionButtonCancel() {
//
//        self.closePopupView()
//        if let action = self.cancelAction {
//            action()
//        }
//    }
//
//    // MARK: OTHER METHODS
//    private func populateObjects() {
//
//        if titleAttributed != nil {
//            labelTitle.attributedText = titleAttributed
//        } else {
//            if titleText != "" {
//
//                if titleText == " " {
//                    labelTitle.isHidden = true
//                } else {
//                    labelTitle.text = titleText
//                }
//
//            } else {
//                labelTitle.text = LangStr.langStr("text_error")
//            }
//        }
//
//        if descriptionAttributed != nil {
//            labelDescription.attributedText = descriptionAttributed
//        } else {
//            labelDescription.text = descriptionText
//        }
//
//        buttonAccept.setTitle(buttonText, for: .normal)
//        imageAlert.image = UIImage(named: imageToLoad)
//
//        if buttonText != "" {
//            buttonAccept.setTitle(buttonText, for: .normal)
//        } else {
//            buttonAccept.setTitle(LangStr.langStr("accpet_text").capitalizingFirstLetter(), for: .normal)
//        }
//
//        if colorTitle != nil {
//            labelTitle.textColor = colorTitle
//        }
//    }
//
//    public func activeCancelButton(buttonText: String = "", color: ColorCancelButton = .red) {
//        self.buttonCancel.isHidden = false
//        self.buttonCloseView.isHidden = true
//
//        if buttonText != "" {
//            buttonCancel.setTitle(buttonText, for: .normal)
//        } else {
//            buttonCancel.setTitle(LangStr.langStr("cancelar").capitalizingFirstLetter(), for: .normal)
//        }
//
//        if color == .red {
//            buttonCancel.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1463309228, alpha: 1)
//        }
//    }
//
//    private func setCloseButtonStatus() {
//        buttonCloseView.isHidden = self.hideCloseButton
//    }
//
//}
//
//
//extension UIViewController {
//
//    func showAlertCustom(title: String = "", description: String, buttonText: String = "", image: ImageType? = .alert, titleAttributed: NSAttributedString? = nil, descriptionAttributed: NSAttributedString? = nil, openInFrontNavigation: Bool = true, hideCloseButton: Bool = false, colorTitle: UIColor? = nil) -> AlertCustomVCSample {
//
//        self.clearAllNotice()
//
//        let alertCustomVC = getNewViewController(storyBoardName: "AlertCustom", viewIdentifier: "AlertCustomVC") as! AlertCustomVCSample
//
//        alertCustomVC.titleText = title
//        alertCustomVC.descriptionText = description
//        alertCustomVC.buttonText = buttonText
//        alertCustomVC.imageToLoad = image!.rawValue
//        alertCustomVC.titleAttributed = titleAttributed
//        alertCustomVC.descriptionAttributed = descriptionAttributed
//        alertCustomVC.hideCloseButton = hideCloseButton
//        alertCustomVC.colorTitle = colorTitle
//
//        if openInFrontNavigation {
//            self.openPopupViewInFrontNavigation(viewController: alertCustomVC, alphaComponent: 0.0)
//        } else {
//            self.openPopupView(viewController: alertCustomVC, alphaComponent: 0.0)
//        }
//
//        return alertCustomVC
//    }
//
//}
