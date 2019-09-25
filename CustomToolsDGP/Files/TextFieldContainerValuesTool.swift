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
    var data: [Any]?
    weak var delegateProtocol: TextFieldContainerValuesToolProtocol?
    var cellHeight: CGFloat = 50
    var valueHeightContainer: CGFloat!
    var closeAnimationActivated: AnimationType = .none
    var containerPosition: ContainerPositionType!
    var durationCloseAnimation: Double = 0.3
    
    var leadingAnchorCustom: NSLayoutConstraint!
    var trailingAnchorCustom: NSLayoutConstraint!
    var topAnchorCustom: NSLayoutConstraint!
    var bottomAnchorCustom: NSLayoutConstraint!
    
    // MARK: START METHODS
    public func show(delegate: TextFieldContainerValuesToolProtocol, textField: UITextField, textFieldSeparation: CGFloat = 10, containerPosition: ContainerPositionType, data: [Any], cellHeightValue: CGFloat = 50) {
        
        // Initial control to not duplicate alerts
        guard !isTextFieldContainerValuesToolOpen else {
            return
        }
        
        // Parameters
        let window = UIApplication.shared.keyWindow
        
        self.containerPosition = containerPosition
        isTextFieldContainerValuesToolOpen = true
        self.delegateProtocol = delegate
        self.data = data
        self.cellHeight = cellHeightValue
        
        valueHeightContainer = calculateContainerHeight(
            containerPosition: containerPosition,
            totalItems: data.count,
            textFieldYposition: textField.layer.position.y,
            textFieldHeight: textField.bounds.height,
            windowHeight: window!.layer.bounds.height,
            topBottomSpace: 50,
            spaceBetweenContainerAndTextField: 10
        )
        
        // View Container
        viewContainer = UIView()
        viewContainer.layer.cornerRadius = 6
        viewContainer.clipsToBounds = true
        viewContainer.layer.borderWidth = 3
        viewContainer.layer.borderColor = #colorLiteral(red: 0.1604149618, green: 0.1736847846, blue: 0.192962541, alpha: 1)
        viewContainer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.95)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Table View
        tableView = UITableView(frame: .zero)
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
        viewContainer.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 0).isActive = true
        
        switch containerPosition {
        case .bottom:
            viewContainer.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldSeparation).isActive = true
            viewContainer.heightAnchor.constraint(lessThanOrEqualToConstant: valueHeightContainer).isActive = true

            break
        case .top:
            
            viewContainer.heightAnchor.constraint(lessThanOrEqualToConstant: valueHeightContainer).isActive = true
            viewContainer.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -textFieldSeparation).isActive = true
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
        
        switch closeAnimationActivated {
        case .disolve:
            self.viewContainer.alpha = 1.0
            self.viewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: durationCloseAnimation, animations: {
                self.viewContainer.alpha = 0.0
                self.viewContainer.layoutIfNeeded()
            }, completion: { _ in
                self.completionActions()
                
            })
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

        case .none:
            completionActions()
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
    
    public func setAnimationView(type: AnimationType, duration: TimeInterval = 0.3, durationCloseAnimation: TimeInterval = 0.3, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        self.closeAnimationActivated = type
        
        switch type {
        case .disolve:
            
            self.viewContainer.alpha = 0.0
            self.viewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: duration, animations: {
                self.viewContainer.alpha = 1.0
                self.viewContainer.layoutIfNeeded()
            }, completion: { _ in
                completionAction = action
                if let actions = completionAction {
                    actions()
                }
            })
            
            break
        case .appearing:
            
            self.durationCloseAnimation = durationCloseAnimation
            viewContainer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            viewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            
            switch containerPosition {
            case .bottom:
                
                bottomAnchorCustom.constant = -valueHeightContainer
                self.viewContainer.layoutIfNeeded()
                
                UIView.animate(withDuration: duration, animations: {
                    self.bottomAnchorCustom.constant = 0
                    self.viewContainer.layoutIfNeeded()
                }, completion: { _ in
                    completionAction = action
                    if let actions = completionAction {
                        actions()
                    }
                })
                
                break
                
            case .top:
                
                topAnchorCustom.constant = valueHeightContainer
                self.viewContainer.layoutIfNeeded()
                
                UIView.animate(withDuration: duration, animations: {
                    self.topAnchorCustom.constant = 0
                    self.viewContainer.layoutIfNeeded()
                }, completion: { _ in
                    completionAction = action
                    if let actions = completionAction {
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
        }
    }
    
}

// MARK: TABLE VIEW METHODS
extension TextFieldContainerValuesTool: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        cell.textLabel!.text = "\(data?[indexPath.row] ?? "?")"
        return cell
    }
}

extension TextFieldContainerValuesTool: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Item selected: \(indexPath.row+1)")
        delegateProtocol?.selectedItem(value: data?[indexPath.row] as Any)
        closeViewActions()
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
            resultingHeight = totalItemsHeight
        } else {
            resultingHeight = usefulSpace
        }
        
        return resultingHeight
    }
    
}

// MARK: TEXT FIELD METHODS
extension TextFieldContainerValuesTool {
    
    
    
    
}
