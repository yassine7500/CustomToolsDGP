//
//  TextFieldContainerValuesTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 25/09/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public var isTextFieldContainerValuesToolOpen = false

public protocol TextFieldContainerValuesToolProtocol: class {
    func selectedItem(value: Any)
}

public class TextFieldContainerValuesTool: UIViewController {
    
    public enum ContainerPositionType: String {
        case top
        case bottom
    }
    
    // MARK: OBJECTS
    var viewContainer: UIView!
    var tableView: UITableView!
    
    // MARK: PARAMETERS
    let cellIdentifier = "TextFieldContainerValuesToolCell"
    weak var delegateProtocol: TextFieldContainerValuesToolProtocol?
    var cellHeight: CGFloat = 50
    var valueHeightContainer: CGFloat!
    var textFieldObservers: TextFieldObservers?
    let topBottomSpace: CGFloat = 50
    
    var leadingAnchorCustom: NSLayoutConstraint!
    var trailingAnchorCustom: NSLayoutConstraint!
    var topAnchorCustom: NSLayoutConstraint!
    var bottomAnchorCustom: NSLayoutConstraint!
    
    var mainDelegate: UIViewController?
    var textFieldReference: UITextField!
    var textFieldSeparation: CGFloat!
    var containerPosition: ContainerPositionType!
    var data: [Any]?
    var dataForTableView: [Any]?
    var cellHeightValue: CGFloat!
    
    var typeAnimation: AnimationType!
    var durationAnimation: TimeInterval!
    var durationCloseAnimation: TimeInterval!
    var completionAction: ( ()->Void )?
    
    var isTextFieldActived = false
    var isTextFieldPopulate = false
    var isContainerReduced = false
    var isItemSelected = false
    var dataFinderResults: [Any]?
    
    
    // MARK: START METHODS
    public func setTextFieldDelegate(delegate: UIViewController, textField: UITextField, textFieldSeparation: CGFloat = 10, containerPosition: ContainerPositionType, data: [Any], cellHeightValue: CGFloat = 50) {
        
        self.mainDelegate = delegate
        self.mainDelegate!.hideKeyboardWhenTappedAroundCustom()
        self.delegateProtocol = self.mainDelegate as? TextFieldContainerValuesToolProtocol
        
        self.textFieldReference = textField
        self.textFieldReference.delegate = self
        self.textFieldReference.addTarget(self, action: #selector(TextFieldContainerValuesTool.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.textFieldSeparation = textFieldSeparation
        self.containerPosition = containerPosition
        self.data = data
        self.cellHeightValue = cellHeightValue
        
        self.dataForTableView = self.data
        self.textFieldObservers = TextFieldObservers(delegate: self)
    }
    
    private func showContainerData() {
        
        // Initial control to not duplicate alerts
        guard !isTextFieldContainerValuesToolOpen else {
            return
        }
        
        // Parameters
        let window = UIApplication.shared.keyWindow
        isTextFieldContainerValuesToolOpen = true
        self.cellHeight = cellHeightValue
        
        valueHeightContainer = calculateContainerHeight(
            containerPosition: containerPosition,
            totalItems: data?.count ?? 0,
            textFieldYposition: textFieldReference.layer.position.y,
            textFieldHeight: textFieldReference.bounds.height,
            windowHeight: window!.layer.bounds.height,
            topBottomSpace: self.topBottomSpace,
            spaceBetweenContainerAndTextField: 10
        )
        
        // View Container
        viewContainer = UIView()
        viewContainer.layer.cornerRadius = 6
        viewContainer.clipsToBounds = true
        viewContainer.layer.borderWidth = 3
        viewContainer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        viewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Table View
        tableView = UITableView(frame: .zero)
        tableView.layer.cornerRadius = 6
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add items to containers
        viewContainer.addSubview(tableView)
        
        // Add item to screen
        window?.addSubview(viewContainer)
        window?.bringSubviewToFront(viewContainer)
        
        // MARK: Add constraints
        viewContainer.leadingAnchor.constraint(equalTo: textFieldReference.leadingAnchor, constant: 0).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: textFieldReference.trailingAnchor, constant: 0).isActive = true
        
        switch containerPosition {
        case .bottom:
            viewContainer.topAnchor.constraint(equalTo: textFieldReference.bottomAnchor, constant: textFieldSeparation).isActive = true
            viewContainer.heightAnchor.constraint(lessThanOrEqualToConstant: valueHeightContainer).isActive = true
            break
        case .top:
            viewContainer.heightAnchor.constraint(lessThanOrEqualToConstant: valueHeightContainer).isActive = true
            viewContainer.bottomAnchor.constraint(equalTo: textFieldReference.topAnchor, constant: -textFieldSeparation).isActive = true
            break
        case .none:
            break
        }
        
        leadingAnchorCustom = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContainer, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        trailingAnchorCustom = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContainer, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        topAnchorCustom = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContainer, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        bottomAnchorCustom = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewContainer, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([leadingAnchorCustom, trailingAnchorCustom, topAnchorCustom, bottomAnchorCustom])
    }
    
}


// MARK: BUTTON METHODS
extension TextFieldContainerValuesTool {
    
    private func closeViewActions() {
        
        switch typeAnimation {
        case .disolve:
            self.viewContainer.alpha = 1.0
            self.viewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: durationCloseAnimation, animations: {
                self.viewContainer.alpha = 0.0
                self.viewContainer.layoutIfNeeded()
            }, completion: { _ in
                self.completionActions()
            })
            break
            
        case .appearing:
            
            switch containerPosition {
            case .bottom:
                
                bottomAnchorCustom.constant = 0
                self.viewContainer.layoutIfNeeded()
                
                UIView.animate(withDuration: durationCloseAnimation, animations: {
                    self.bottomAnchorCustom.constant = -self.valueHeightContainer
                    self.viewContainer.layoutIfNeeded()
                }, completion: { _ in
                    self.completionActions()
                })
                
                break
            case .top:
                
                topAnchorCustom.constant = 0
                self.viewContainer.layoutIfNeeded()
                
                UIView.animate(withDuration: durationCloseAnimation, animations: {
                    self.topAnchorCustom.constant = self.valueHeightContainer
                    self.viewContainer.layoutIfNeeded()
                }, completion: { _ in
                    self.completionActions()
                })
                
                break
                
            case .none:
                break
            }
            
            break
            
        case .none:
            completionActions()
            break
        case .some(.none):
            completionActions()
            break
        }
    }
    
    private func completionActions() {
        isTextFieldContainerValuesToolOpen = false
        self.viewContainer.removeFromSuperview()
    }
    
}


// MARK: CUSTOMIZE VIEW METHODS
extension TextFieldContainerValuesTool {
    
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
    
    // TABLE VIEW
    public func setTableViewBackgorund(color: UIColor) {
        tableView.backgroundColor = color
    }
    public func setTableViewSeparator(style: UITableViewCell.SeparatorStyle) {
        tableView.separatorStyle = style
    }
    public func setTableViewSeparator(color: UIColor) {
        tableView.separatorColor = color
    }
    public func setTableViewBoder(color: UIColor, width: CGFloat) {
        tableView.layer.borderColor = color.cgColor
        tableView.layer.borderWidth = width
    }
    public func setTableVIewCorner(radius: CGFloat) {
        tableView.layer.cornerRadius = radius
    }
    
}

// MARK: ANIMATIONS
extension TextFieldContainerValuesTool {
    
    public enum AnimationType: String {
        case disolve
        case appearing
        case none
    }
    
    public func setAnimationParameters(type: AnimationType, duration: TimeInterval = 0.3, durationCloseAnimation: TimeInterval = 0.3, _ action: @escaping ()->Void) {
        self.typeAnimation = type
        self.durationAnimation = duration
        self.durationCloseAnimation = durationCloseAnimation
        completionAction = action
    }
    
    func startAnimationView() {
        
        switch typeAnimation {
        case .disolve:
            
            self.viewContainer.alpha = 0.0
            self.viewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: durationAnimation, animations: {
                self.viewContainer.alpha = 1.0
                self.viewContainer.layoutIfNeeded()
            }, completion: { _ in
                if let actions = self.completionAction {
                    actions()
                }
            })
            
            break
            
        case .appearing:
            
            switch containerPosition {
            case .bottom:
                
                bottomAnchorCustom.constant = -valueHeightContainer
                self.viewContainer.layoutIfNeeded()
                
                UIView.animate(withDuration: durationAnimation, animations: {
                    self.bottomAnchorCustom.constant = 0
                    self.viewContainer.layoutIfNeeded()
                }, completion: { _ in
                    if let actions = self.completionAction {
                        actions()
                    }
                })
                
                break
                
            case .top:
                
                topAnchorCustom.constant = valueHeightContainer
                self.viewContainer.layoutIfNeeded()
                
                UIView.animate(withDuration: durationAnimation, animations: {
                    self.topAnchorCustom.constant = 0
                    self.viewContainer.layoutIfNeeded()
                }, completion: { _ in
                    if let actions = self.completionAction {
                        actions()
                    }
                })
                
                break
            case .none:
                
                break
            }
            
            break
        case .none:
            break
        case .some(.none):
            break
        }
    }
    
}

// MARK: TABLE VIEW METHODS
extension TextFieldContainerValuesTool: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        cell.textLabel!.text = "\(dataForTableView?[indexPath.row] ?? "?")"
        return cell
    }
}

extension TextFieldContainerValuesTool: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" 📌 Item selected: \(indexPath.row+1)")
        self.isItemSelected = true
        self.isTextFieldPopulate = true
        self.delegateProtocol?.selectedItem(value: self.data?[indexPath.row] as Any)
        self.mainDelegate?.dismissKeyboardCustom()
    }
}

// MARK: SUPPORT METHODS
extension TextFieldContainerValuesTool {
    
    private func calculateContainerHeight(containerPosition: ContainerPositionType, totalItems: Int, textFieldYposition: CGFloat, textFieldHeight: CGFloat , windowHeight: CGFloat, topBottomSpace: CGFloat, spaceBetweenContainerAndTextField: CGFloat) -> CGFloat {
        
        var resultingHeight: CGFloat = 0.0
        
        let totalItemsHeight = CGFloat(totalItems) * cellHeight
        var usefulSpace: CGFloat = 0
        
        switch containerPosition {
        case .bottom:
            usefulSpace = windowHeight - (textFieldYposition + textFieldHeight + spaceBetweenContainerAndTextField + topBottomSpace)
            break
        case .top:
            usefulSpace = textFieldYposition - (topBottomSpace + spaceBetweenContainerAndTextField)
            break
        }
        
        if totalItemsHeight < usefulSpace {
            isContainerReduced = true
            resultingHeight = totalItemsHeight
        } else {
            isContainerReduced = false
            resultingHeight = usefulSpace
        }
        
        return resultingHeight
    }
    
}

// MARK: TEXT FIELD METHODS
extension TextFieldContainerValuesTool: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.mainDelegate?.dismissKeyboardCustom()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("textFieldDidBeginEditing")
        self.isTextFieldActived = true
        self.textFieldObservers?.createObservers()
        self.showContainerData()
        self.startAnimationView()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("textFieldDidEndEditing")
        self.textFieldObservers?.removeObservers()
        self.closeViewActions()
        
        if !isItemSelected, !isTextFieldPopulate {
            self.textFieldReference.text = ""
            self.updateTableView(newData: data!)
            self.delegateProtocol?.selectedItem(value: "")
        } else {
            self.isItemSelected = false
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        
        isTextFieldPopulate = false
        
        if sender.text?.count ?? 0 > 0 {
            //            isFinderEditing = true
            self.searchWords(words: sender.text ?? "")
        } else {
            //            isFinderEditing = false
            self.updateTableView(newData: data!)
        }
    }
    
    private func searchWords(words: String) {
        
        if data != nil, data?.count ?? 0 > 0 {
            
            dataFinderResults = [Any]()
            
            let separateWords: [String] = words.components(separatedBy: " ")
            
            for word in separateWords {
                for value in data! {
                    let valueString: String = "\(value)".uppercased()
                    if valueString.contains(word.uppercased()) {
                        dataFinderResults?.append(value)
                    }
                }
            }
            
            self.updateTableView(newData: dataFinderResults!)
            // TODO: update table view constraints.
        }
    }
    
    private func updateTableView(newData: [Any]) {
        self.dataForTableView = newData
        self.tableView.reloadData()
    }
    
}


extension UIViewController {
    
    func hideKeyboardWhenTappedAroundCustom() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardCustom))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardCustom() {
        view.endEditing(true)
    }
}


extension TextFieldContainerValuesTool: TextFieldProtocol {
    
    public func passInsetsToMoveKeyboard(insets: UIEdgeInsets, keyboardHeight: Int) {
        
        print(" ⚠️ keyboardHeight: \(keyboardHeight) ")
        
        switch containerPosition {
            
        case .bottom:
            
            if isTextFieldActived, !isContainerReduced {
                self.isTextFieldActived = false
                bottomAnchorCustom.constant = bottomAnchorCustom.constant - (CGFloat(keyboardHeight) - topBottomSpace)
                self.viewContainer.layoutIfNeeded()
            }
            
            break
            
        case .top:
            
            if insets == UIEdgeInsets.zero {
                self.mainDelegate?.view.frame.origin.y = -insets.bottom
            } else {
                self.mainDelegate?.view.frame.origin.y = (-insets.bottom) + 0
            }
            
            if !isContainerReduced {
                topAnchorCustom.constant = topAnchorCustom.constant + (CGFloat(keyboardHeight) + topBottomSpace)
                self.viewContainer.layoutIfNeeded()
            }
            
            break
            
        case .none:
            break
        }
        
    }
    
}
