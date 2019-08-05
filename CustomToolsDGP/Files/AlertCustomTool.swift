//
//  AlertCustomTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 04/08/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class AlertCustomTool {
    
    public enum ButtonsFormatType: String {
        case stickedDown
        case withConstraints
    }
    
    // MARK: OBJECTS
    var mainViewContainer: UIView!
    var viewContainer: UIView!
    var stackView: UIStackView!
    var imageIcon: UIImageView!
    var textLabelTitle: UILabel!
    var textLabel: UILabel!
    var stackViewButtons: UIStackView!
    var buttonAccept: UIButton!
    var buttonCancel: UIButton!
    var buttonOther: UIButton!
    
    // MARK: PARAMETERS
    var acceptAction: ( ()->Void )?
    var cancelAction: ( ()->Void )?
    var otherAction: ( ()->Void )?
    
    // MARK: START METHODS
    public init() {
    }
    
    public func show(title: String, message: String, customImage: UIImage?, imageHeight: CGFloat = 80, imageWidth: CGFloat = 80, onlyOneButton: Bool, activeExtraButton: Bool = false, typeFormatButtons: ButtonsFormatType = .withConstraints) {
        
        // Parameters
        let window = UIApplication.shared.keyWindow
        
        // View Container Main
        mainViewContainer = UIView()
        mainViewContainer.clipsToBounds = true
        mainViewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // View Container
        viewContainer = UIView()
        viewContainer.layer.cornerRadius = 6
        viewContainer.clipsToBounds = true
        viewContainer.layer.borderWidth = 3
        viewContainer.layer.borderColor = #colorLiteral(red: 0.1604149618, green: 0.1736847846, blue: 0.192962541, alpha: 1)
        viewContainer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.95)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 20
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Image
        imageIcon = UIImageView()
        imageIcon.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageIcon.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imageIcon.clipsToBounds = true
        imageIcon.layer.cornerRadius = 2
        imageIcon.contentMode = .scaleAspectFit
        if customImage != nil {
            imageIcon.image = customImage
        } else {
            imageIcon.isHidden = true
        }
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Label Title
        textLabelTitle = UILabel()
        textLabelTitle.font = textLabelTitle.font.withSize(24)
        textLabelTitle.text = title
        textLabelTitle.textAlignment = .center
        textLabelTitle.numberOfLines = 2
        textLabelTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // Label
        textLabel = UILabel()
        textLabel.font = textLabel.font.withSize(14)
        textLabel.text = message
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View Buttons
        stackViewButtons = UIStackView()
        stackViewButtons.axis = NSLayoutConstraint.Axis.horizontal
        stackViewButtons.distribution = UIStackView.Distribution.fillEqually
        stackViewButtons.alignment = UIStackView.Alignment.fill
        stackViewButtons.spacing = 16
        stackViewButtons.clipsToBounds = true
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        
        // Button Accept
        buttonAccept = UIButton()
        buttonAccept.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8039215686, blue: 0.368627451, alpha: 1)
        buttonAccept.setTitle("Accept", for: .normal)
        buttonAccept.layer.cornerRadius = 4
        buttonAccept.addTarget(self, action: #selector(buttonAcceptAction), for: .touchUpInside)
        
        buttonCancel = UIButton()
        buttonCancel.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0.3411764706, alpha: 1)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.layer.cornerRadius = 4
        buttonCancel.addTarget(self, action: #selector(buttonCancelAction), for: .touchUpInside)
        
        // Add items to stackView
        if !onlyOneButton {
            stackViewButtons.addArrangedSubview(buttonCancel)
            
            if activeExtraButton {
                buttonOther = UIButton()
                buttonOther.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                buttonOther.setTitle("Other", for: .normal)
                buttonOther.layer.cornerRadius = 4
                buttonOther.addTarget(self, action: #selector(buttonOtherAction), for: .touchUpInside)
                
                stackViewButtons.addArrangedSubview(buttonOther)
            }
        }
        
        stackViewButtons.addArrangedSubview(buttonAccept)
        
        stackView.addArrangedSubview(imageIcon)
        stackView.addArrangedSubview(textLabelTitle)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(stackViewButtons)
        
        // Add items to containers
        viewContainer.addSubview(stackView)
        mainViewContainer.addSubview(viewContainer)
        
        // Add item to screen
        window?.addSubview(mainViewContainer)
        window?.bringSubviewToFront(mainViewContainer)
        
        // Add constraints
        mainViewContainer.widthAnchor.constraint(equalToConstant: window!.bounds.width).isActive = true
        mainViewContainer.heightAnchor.constraint(equalToConstant: window!.bounds.height).isActive = true
        mainViewContainer.centerXAnchor.constraint(equalTo: window!.centerXAnchor).isActive = true
        mainViewContainer.centerYAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
        
        viewContainer.topAnchor.constraint(greaterThanOrEqualTo: mainViewContainer.topAnchor, constant: 50).isActive = true
        viewContainer.bottomAnchor.constraint(lessThanOrEqualTo: mainViewContainer.bottomAnchor, constant: 50).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: mainViewContainer.leadingAnchor, constant: 30).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: mainViewContainer.trailingAnchor, constant: -30).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: mainViewContainer.centerYAnchor).isActive = true
        viewContainer.centerXAnchor.constraint(equalTo: mainViewContainer.centerXAnchor).isActive = true
        
        textLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        
        textLabelTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        textLabelTitle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        
        stackViewButtons.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        switch typeFormatButtons {
        case .stickedDown:
            stackViewButtons.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
            stackViewButtons.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
            stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 0).isActive = true
            
            stackViewButtons.spacing = 0
            buttonAccept.layer.cornerRadius = 0
            buttonCancel.layer.cornerRadius = 0
            if activeExtraButton {
                buttonOther.layer.cornerRadius = 0
            }
            break
        case .withConstraints:
            stackViewButtons.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
            stackViewButtons.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
            stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -30).isActive = true
            break
        }
        
        stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: 0).isActive = true
    }
    
}


// MARK: BUTTON METHODS
extension AlertCustomTool {
    
    @objc func buttonAcceptAction() {
        print("AlertCustomTool: buttonAcceptAction")
        mainViewContainer.removeFromSuperview()
        if let action = self.acceptAction {
            action()
        }
    }
    
    @objc func buttonCancelAction() {
        print("AlertCustomTool: buttonCancelAction")
        mainViewContainer.removeFromSuperview()
        if let action = self.cancelAction {
            action()
        }
    }
    
    @objc func buttonOtherAction() {
        print("AlertCustomTool: buttonOtherAction")
        mainViewContainer.removeFromSuperview()
        if let action = self.otherAction {
            action()
        }
    }
    
    public func addOkAction(_ action: @escaping ()->Void) {
        self.acceptAction = action
    }
    public func addCancelAction(_ action: @escaping ()->Void) {
        self.cancelAction = action
    }
    public func addCloseAction(_ action: @escaping ()->Void) {
        self.otherAction = action
    }
    
}


// MARK: CUSTOMIZE VIEW METHODS
extension AlertCustomTool {
    
    // BACKGROUND
    public func setBackgroundColor(color: UIColor) {
        mainViewContainer.backgroundColor = color
    }
    
    // CONTAINER
    public func setContainerBackgroundColor(color: UIColor) {
        viewContainer.backgroundColor = color
    }
    public func setContainerCornerRadius(value: CGFloat) {
        viewContainer.layer.cornerRadius = value
    }
    public func setContainerBorder(value: CGFloat, color: UIColor) {
        viewContainer.layer.borderWidth = value
        viewContainer.layer.borderColor = color.cgColor
    }
    
    // STACK VIEW
    public func setStackViewSpacing(value: CGFloat) {
        stackView.spacing = value
    }
    public func setStackViewButtonsSpacing(value: CGFloat) {
        stackViewButtons.spacing = value
    }
    
    // IMAGE
    public func setImageCorner(value: CGFloat) {
        imageIcon.layer.cornerRadius = value
        imageIcon.layer.masksToBounds = true
    }
    public func setImageBorder(value: CGFloat, color: UIColor) {
        imageIcon.layer.borderWidth = value
        imageIcon.layer.borderColor = color.cgColor
    }
    
    // LABEL TITLE
    public func setLabelTitleFontSize(value: CGFloat) {
        textLabelTitle.font = textLabelTitle.font.withSize(value)
    }
    public func setLabelTitleAlignment(value: NSTextAlignment) {
        textLabelTitle.textAlignment = value
    }
    public func setLabelTitleNumberLines(value: Int) {
        textLabelTitle.numberOfLines = value
    }
    public func setLabelTitleTextColor(color: UIColor) {
        textLabelTitle.textColor = color
    }
    
    // LABEL
    public func setLabelFontSize(value: CGFloat) {
        textLabel.font = textLabelTitle.font.withSize(value)
    }
    public func setLabelAlignment(value: NSTextAlignment) {
        textLabel.textAlignment = value
    }
    public func setLabelNumberLines(value: Int) {
        textLabel.numberOfLines = value
    }
    public func setLabelTextColor(color: UIColor) {
        textLabel.textColor = color
    }
    
    // BUTTONS
    public func setButtonAcceptBackground(color: UIColor) {
        buttonAccept.backgroundColor = color
    }
    public func setButtonAcceptCorner(value: CGFloat) {
        buttonAccept.layer.cornerRadius = value
    }
    public func setButtonAcceptTextColor(color: UIColor) {
        buttonAccept.setTitleColor(color, for: .normal)
    }
    public func setButtonAcceptTitle(text: String) {
        buttonAccept.setTitle(text, for: .normal)
    }
    
    public func setButtonCancelBackground(color: UIColor) {
        buttonCancel.backgroundColor = color
    }
    public func setButtonCancelCorner(value: CGFloat) {
        buttonCancel.layer.cornerRadius = value
    }
    public func setButtonCancelTextColor(color: UIColor) {
        buttonCancel.setTitleColor(color, for: .normal)
    }
    public func setButtonCancelTitle(text: String) {
        buttonCancel.setTitle(text, for: .normal)
    }
    
    public func setButtonOtherBackground(color: UIColor) {
        buttonOther.backgroundColor = color
    }
    public func setButtonOtherCorner(value: CGFloat) {
        buttonOther.layer.cornerRadius = value
    }
    public func setButtonOtherTextColor(color: UIColor) {
        buttonOther.setTitleColor(color, for: .normal)
    }
    public func setButtonOtherTitle(text: String) {
        buttonOther.setTitle(text, for: .normal)
    }
    
}

// MARK: ANIMATIONS
extension AlertCustomTool {
    
    public enum AnimationType: String {
        case disolveCenter
        case scaleCenter
        case fromBottom
    }
    
    public func setAnimationView(type: AnimationType, duration: TimeInterval = 0.2, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        switch type {
        case .disolveCenter:
            
            self.mainViewContainer.alpha = 0.0
            self.mainViewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: duration, animations: {
                self.mainViewContainer.alpha = 1.0
                self.mainViewContainer.layoutIfNeeded()
            }, completion: { _ in
                completionAction = action
                if let actions = completionAction {
                    actions()
                }
            })
            
            break
        case .scaleCenter:
            
            self.viewContainer.alpha = 0
            self.viewContainer.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            self.mainViewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [.curveEaseOut], animations: {
                self.viewContainer.alpha = 1
                self.viewContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.mainViewContainer.layoutIfNeeded()
            }, completion: { _ in
                completionAction = action
                if let actions = completionAction {
                    actions()
                }
            })
            
            break
            
        case .fromBottom:
            
            viewContainer.alpha = 0
            viewContainer.transform = CGAffineTransform(translationX: 0, y: 100)
            self.mainViewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 3, options: [.curveEaseOut], animations: {
                self.viewContainer.alpha = 1
                self.viewContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                self.mainViewContainer.layoutIfNeeded()
            }, completion: { _ in
                completionAction = action
                if let actions = completionAction {
                    actions()
                }
            })
            
            break
        }
        
    }
    
}

