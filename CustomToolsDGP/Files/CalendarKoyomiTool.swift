//
//  CalendarKoyomiTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 03/11/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public var isCalendarKoyomiToolOpened = false

@objc public protocol CalendarKoyomiToolProtocol: class {
    @objc optional func dateSelectedValue(date: String?)
}

public class CalendarKoyomiTool {
    
    public enum ButtonsFormatType: String {
        case stickedDown
        case withConstraints
    }
    
    public enum FirstDayType: String {
        case sunday
        case monday
    }
    
    public enum CalendarLanguage: String {
        case english
        case spanish
        case catalan
    }
    
    // MARK: OBJECTS
    var mainViewContainer: UIView!
    var viewContainer: UIView!
    var stackView: UIStackView!
    var textLabelTitle: UILabel?
    var textLabelMont: UILabel?
    var stackViewButtons: UIStackView?
    var buttonAccept: UIButton?
    var buttonCancel: UIButton?
    var buttonMainContainer: UIButton!
    
    let dateTools = DateTools()
    
    var calendarKoyomi: Koyomi?
    weak var delegateCalendarKoyomiTool: CalendarKoyomiToolProtocol?
    fileprivate let invalidPeriodLength = 90
    var stackViewButtonsCalendar: UIStackView?
    var previousMonth: UIButton?
    var currentMonth: UIButton?
    var nextMonth: UIButton?
    
    // MARK: PARAMETERS
    var acceptAction: ( ()->Void )?
    var cancelAction: ( ()->Void )?
    
    var selectedDateValue = ""
    var confirmSelectionValue = false
    var languageSelectedValue: CalendarLanguage!
    var localeValue: Locale!
    let monthDateFormatted = "MMMM yyyy"
    
    // MARK: START METHODS
    public init() {
    }
    
    public func show(delegate: UIViewController, firstDayType: FirstDayType, selectionMode: SelectionMode? = nil, confirmSelection: Bool = false, calendarStyle: KoyomiStyle = .standard, title: String? = nil, activateCancelButton: Bool = false, typeFormatButtons: ButtonsFormatType = .withConstraints, calendarLanguage: CalendarLanguage) {
        
        guard !isCalendarKoyomiToolOpened else {
            return
        }
        
        isCalendarKoyomiToolOpened = true
        delegateCalendarKoyomiTool = delegate as? CalendarKoyomiToolProtocol
        
        confirmSelectionValue = confirmSelection
        selectedDateValue = dateTools.getStringDateFromDate(date: Date(), dateFormatOut: .dateDay)
        languageSelectedValue = calendarLanguage
        
        if languageSelectedValue == .spanish {
            localeValue = Locale(identifier: "es-ES")
            dateTools.dateFormatter.locale = localeValue
        } else if languageSelectedValue == .catalan {
            localeValue = Locale(identifier: "ca-ES")
            dateTools.dateFormatter.locale = localeValue
        } else {
            localeValue = Locale(identifier: "en-US")
            dateTools.dateFormatter.locale = localeValue
        }
        
        // Parameters
        let window = UIApplication.shared.keyWindow
        
        // View Container Main
        mainViewContainer = UIView()
        mainViewContainer.clipsToBounds = true
        mainViewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Button Container Main
        buttonMainContainer = UIButton()
        buttonMainContainer.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0)
        buttonMainContainer.addTarget(self, action: #selector(buttonMainContainerAction), for: .touchUpInside)
        buttonMainContainer.translatesAutoresizingMaskIntoConstraints = false
        
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
        stackView.spacing = 16
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if title != nil {
            // Label Title
            textLabelTitle = UILabel()
            textLabelTitle?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            textLabelTitle?.text = title
            textLabelTitle?.textAlignment = .center
            textLabelTitle?.numberOfLines = 2
            textLabelTitle?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            textLabelTitle?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // MARK: Calendar Koyomi
        calendarKoyomi = Koyomi(frame: .zero, sectionSpace: 3.0, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
        calendarKoyomi?.layer.cornerRadius = 4
        calendarKoyomi?.translatesAutoresizingMaskIntoConstraints = false
        calendarKoyomi?.calendarDelegate = self
        calendarKoyomi?.circularViewDiameter = 0.75
        calendarKoyomi?.currentDateFormat = "MMMM yyyy"
        calendarKoyomi?.style = calendarStyle
        if selectionMode != nil {
            calendarKoyomi?.selectionMode = selectionMode!
        }
        
        if firstDayType == .monday {
            calendarKoyomi?.weeks = (
                dateTools.weekdayNameFrom(weekdayNumber: 1, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 2, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 3, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 4, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 5, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 6, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 7, shortedString: .three, locale: localeValue)
            )
        } else {
            calendarKoyomi?.weeks = (
                dateTools.weekdayNameFrom(weekdayNumber: 0, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 1, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 2, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 3, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 4, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 5, shortedString: .three, locale: localeValue),
                dateTools.weekdayNameFrom(weekdayNumber: 6, shortedString: .three, locale: localeValue)
            )
        }
        
        // MARK: Calendar Month Text Label
        textLabelMont = UILabel()
        textLabelMont?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textLabelMont?.text = calendarKoyomi?.currentDateString()
        textLabelMont?.textAlignment = .center
        textLabelMont?.numberOfLines = 1
        textLabelMont?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabelMont?.adjustsFontSizeToFitWidth = true
        textLabelMont?.minimumScaleFactor = 0.5
        textLabelMont?.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Stack View Calendar Buttons
        stackViewButtonsCalendar = UIStackView()
        stackViewButtonsCalendar?.axis = NSLayoutConstraint.Axis.horizontal
        stackViewButtonsCalendar?.distribution = UIStackView.Distribution.fillEqually
        stackViewButtonsCalendar?.alignment = UIStackView.Alignment.fill
        stackViewButtonsCalendar?.spacing = 5
        stackViewButtonsCalendar?.clipsToBounds = true
        stackViewButtonsCalendar?.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Calendar buttons
        previousMonth = UIButton()
        previousMonth?.backgroundColor = #colorLiteral(red: 0, green: 0.4901447296, blue: 0.5543798208, alpha: 1)
        previousMonth?.setTitle("Previous", for: .normal)
        previousMonth?.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        previousMonth?.layer.cornerRadius = 4
        previousMonth?.addTarget(self, action: #selector(buttonPreviousMontAction), for: .touchUpInside)
        
        currentMonth = UIButton()
        currentMonth?.backgroundColor = #colorLiteral(red: 0, green: 0.4901447296, blue: 0.5543798208, alpha: 1)
        currentMonth?.setTitle("Current", for: .normal)
        currentMonth?.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        currentMonth?.layer.cornerRadius = 4
        currentMonth?.addTarget(self, action: #selector(buttonCurrentsMontAction), for: .touchUpInside)
        
        nextMonth = UIButton()
        nextMonth?.backgroundColor = #colorLiteral(red: 0, green: 0.4901447296, blue: 0.5543798208, alpha: 1)
        nextMonth?.setTitle("Next", for: .normal)
        nextMonth?.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        nextMonth?.layer.cornerRadius = 4
        nextMonth?.addTarget(self, action: #selector(buttonNextMontAction), for: .touchUpInside)
        
        
        if confirmSelection || activateCancelButton {
            
            // Stack View Buttons
            stackViewButtons = UIStackView()
            stackViewButtons?.axis = NSLayoutConstraint.Axis.horizontal
            stackViewButtons?.distribution = UIStackView.Distribution.fillEqually
            stackViewButtons?.alignment = UIStackView.Alignment.fill
            stackViewButtons?.spacing = 16
            stackViewButtons?.clipsToBounds = true
            stackViewButtons?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if confirmSelection {
            // Button Accept
            buttonAccept = UIButton()
            buttonAccept?.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8039215686, blue: 0.368627451, alpha: 1)
            buttonAccept?.setTitle("Accept", for: .normal)
            buttonAccept?.layer.cornerRadius = 4
            buttonAccept?.addTarget(self, action: #selector(buttonAcceptAction), for: .touchUpInside)
        }
        
        if activateCancelButton {
            buttonCancel = UIButton()
            buttonCancel?.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0.3411764706, alpha: 1)
            buttonCancel?.setTitle("Cancel", for: .normal)
            buttonCancel?.layer.cornerRadius = 4
            buttonCancel?.addTarget(self, action: #selector(buttonCancelAction), for: .touchUpInside)
            
            stackViewButtons?.addArrangedSubview(buttonCancel!)
        }
        
        if confirmSelection {
            stackViewButtons?.addArrangedSubview(buttonAccept!)
        }
        
        // Add items to stackView
        stackViewButtonsCalendar?.addArrangedSubview(previousMonth!)
        stackViewButtonsCalendar?.addArrangedSubview(currentMonth!)
        stackViewButtonsCalendar?.addArrangedSubview(nextMonth!)
        
        if title != nil {
            stackView.addArrangedSubview(textLabelTitle!)
        }
        
        stackView.addArrangedSubview(stackViewButtonsCalendar!)
        stackView.addArrangedSubview(textLabelMont!)
        stackView.addArrangedSubview(calendarKoyomi!)
        
        if confirmSelection || activateCancelButton {
            stackView.addArrangedSubview(stackViewButtons!)
        }
        
        // Add items to containers
        viewContainer.addSubview(stackView)
        mainViewContainer.addSubview(buttonMainContainer)
        mainViewContainer.addSubview(viewContainer)
        
        // Add item to screen
        window?.addSubview(mainViewContainer)
        window?.bringSubviewToFront(mainViewContainer)
        
        calendarKoyomi?.display(in: .current)
        calendarKoyomi?.select(date: Date())
        
        // MARK: CONSTRAINTS
        mainViewContainer.widthAnchor.constraint(equalToConstant: window!.bounds.width).isActive = true
        mainViewContainer.heightAnchor.constraint(equalToConstant: window!.bounds.height).isActive = true
        mainViewContainer.centerXAnchor.constraint(equalTo: window!.centerXAnchor).isActive = true
        mainViewContainer.centerYAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
        
        buttonMainContainer.topAnchor.constraint(equalTo: mainViewContainer.topAnchor).isActive = true
        buttonMainContainer.bottomAnchor.constraint(equalTo: mainViewContainer.bottomAnchor).isActive = true
        buttonMainContainer.leadingAnchor.constraint(equalTo: mainViewContainer.leadingAnchor).isActive = true
        buttonMainContainer.trailingAnchor.constraint(equalTo: mainViewContainer.trailingAnchor).isActive = true
        
        viewContainer.topAnchor.constraint(greaterThanOrEqualTo: mainViewContainer.topAnchor, constant: 50).isActive = true
        viewContainer.bottomAnchor.constraint(lessThanOrEqualTo: mainViewContainer.bottomAnchor, constant: 50).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: mainViewContainer.leadingAnchor, constant: 20).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: mainViewContainer.trailingAnchor, constant: -20).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: mainViewContainer.centerYAnchor).isActive = true
        viewContainer.centerXAnchor.constraint(equalTo: mainViewContainer.centerXAnchor).isActive = true
        
        if title != nil {
            textLabelMont?.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
            textLabelMont?.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        }
        
        textLabelTitle?.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30).isActive = true
        textLabelTitle?.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30).isActive = true
        
        calendarKoyomi?.heightAnchor.constraint(equalToConstant: 300).isActive = true
        calendarKoyomi?.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        calendarKoyomi?.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        stackViewButtonsCalendar?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackViewButtonsCalendar?.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
        stackViewButtonsCalendar?.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        if confirmSelection || activateCancelButton {
            
            stackViewButtons?.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            switch typeFormatButtons {
            case .stickedDown:
                stackViewButtons?.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
                stackViewButtons?.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
                stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 0).isActive = true
                
                stackViewButtons?.spacing = 0
                
                if confirmSelection {
                    buttonAccept?.layer.cornerRadius = 0
                }
                
                if activateCancelButton {
                    buttonCancel?.layer.cornerRadius = 0
                }
                
                break
            case .withConstraints:
                stackViewButtons?.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
                stackViewButtons?.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
                stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -10).isActive = true
                break
            }
        } else {
            stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -5).isActive = true
        }
        
        stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: 0).isActive = true
    }
    
}


// MARK: BUTTON METHODS
extension CalendarKoyomiTool {
    
    @objc func buttonMainContainerAction() {
        print("CalendarKoyomiTool: buttonMainContainerAction")
        isCalendarKoyomiToolOpened = false
        mainViewContainer.removeFromSuperview()
    }
    
    @objc func buttonAcceptAction() {
        print("CalendarKoyomiTool: buttonAcceptAction")
        closeAnimation()
        if let action = self.acceptAction {
            action()
        }
    }
    
    @objc func buttonCancelAction() {
        print("CalendarKoyomiTool: buttonCancelAction")
        isCalendarKoyomiToolOpened = false
        mainViewContainer.removeFromSuperview()
        if let action = self.cancelAction {
            action()
        }
    }
    
    public func addAcceptAction(_ action: @escaping ()->Void) {
        self.acceptAction = action
    }
    public func addCancelAction(_ action: @escaping ()->Void) {
        self.cancelAction = action
    }
    
    @objc func buttonPreviousMontAction() {
        print("CalendarKoyomiTool: buttonPreviousMontAction")
        calendarKoyomi?.display(in: .previous)
    }
    @objc func buttonCurrentsMontAction() {
        print("CalendarKoyomiTool: buttonCurrentsMontAction")
        calendarKoyomi?.display(in: .current)
    }
    @objc func buttonNextMontAction() {
        print("CalendarKoyomiTool: buttonNextMontAction")
        calendarKoyomi?.display(in: .next)
    }
    
}


// MARK: CUSTOMIZE VIEW METHODS
extension CalendarKoyomiTool {
    
    // BACKGROUND
    public func setBackgroundColor(color: UIColor) {
        mainViewContainer.backgroundColor = color
    }
    
    // BUTTON BACKGROUND
    public func setButtonBackgroundDisable() {
        buttonMainContainer.isEnabled = false
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
        stackViewButtons?.spacing = value
    }
    
    // LABEL TITLE
    public func setLabelTitleFontSize(value: CGFloat) {
        textLabelTitle?.font = textLabelTitle?.font.withSize(value)
    }
    public func setLabelTitleFontSizeAndWeight(value: CGFloat, weight: UIFont.Weight) {
        textLabelTitle?.font = UIFont.systemFont(ofSize: value, weight: weight)
    }
    public func setLabelTitleAlignment(value: NSTextAlignment) {
        textLabelTitle?.textAlignment = value
    }
    public func setLabelTitleNumberLines(value: Int) {
        textLabelTitle?.numberOfLines = value
    }
    public func setLabelTitleTextColor(color: UIColor) {
        textLabelTitle?.textColor = color
    }
    public func setLabelTitleAttributedText(attributedText: NSAttributedString) {
        textLabelTitle?.attributedText = attributedText
    }
    public func setLabelTitleHidden(isHidden: Bool) {
        textLabelTitle?.isHidden = isHidden
    }
    
    // LABEL
    public func setLabelFontSize(value: CGFloat) {
        textLabelMont?.font = textLabelMont?.font.withSize(value)
    }
    public func setLabelFontSizeAndWeight(value: CGFloat, weight: UIFont.Weight) {
        textLabelTitle?.font = UIFont.systemFont(ofSize: value, weight: weight)
    }
    public func setLabelAlignment(value: NSTextAlignment) {
        textLabelMont?.textAlignment = value
    }
    public func setLabelNumberLines(value: Int) {
        textLabelMont?.numberOfLines = value
    }
    public func setLabelTextColor(color: UIColor) {
        textLabelMont?.textColor = color
    }
    public func setLabelAttributedText(attributedText: NSAttributedString) {
        textLabelMont?.attributedText = attributedText
    }
    public func setLabelHidden(isHidden: Bool) {
        textLabelMont?.isHidden = isHidden
    }
    
    // BUTTONS
    public func setButtonAcceptBackground(color: UIColor) {
        buttonAccept?.backgroundColor = color
    }
    public func setButtonAcceptCorner(value: CGFloat) {
        buttonAccept?.layer.cornerRadius = value
    }
    public func setButtonAcceptTextColor(color: UIColor) {
        buttonAccept?.setTitleColor(color, for: .normal)
    }
    public func setButtonAcceptTitle(text: String) {
        buttonAccept?.setTitle(text, for: .normal)
    }
    public func setButtonAcceptAttributedText(attributedText: NSAttributedString) {
        buttonAccept?.setAttributedTitle(attributedText, for: .normal)
    }
    
    public func setButtonCancelBackground(color: UIColor) {
        buttonCancel?.backgroundColor = color
    }
    public func setButtonCancelCorner(value: CGFloat) {
        buttonCancel?.layer.cornerRadius = value
    }
    public func setButtonCancelTextColor(color: UIColor) {
        buttonCancel?.setTitleColor(color, for: .normal)
    }
    public func setButtonCancelTitle(text: String) {
        buttonCancel?.setTitle(text, for: .normal)
    }
    public func setButtonCancelAttributedText(attributedText: NSAttributedString) {
        buttonCancel?.setAttributedTitle(attributedText, for: .normal)
    }
    
    // CALENDAR BUTTONS
    public func setButtonPreviousMonthBackground(color: UIColor) {
        previousMonth?.backgroundColor = color
    }
    public func setButtonPreviousMonthCorner(value: CGFloat) {
        previousMonth?.layer.cornerRadius = value
    }
    public func setButtonPreviousMonthTextColor(color: UIColor) {
        previousMonth?.setTitleColor(color, for: .normal)
    }
    public func setButtonPreviousMonthTitle(text: String) {
        previousMonth?.setTitle(text, for: .normal)
    }
    public func setButtonPreviousMonthAttributedText(attributedText: NSAttributedString) {
        previousMonth?.setAttributedTitle(attributedText, for: .normal)
    }
    
    public func setButtonCurrentMonthBackground(color: UIColor) {
        currentMonth?.backgroundColor = color
    }
    public func setButtonCurrentMonthCorner(value: CGFloat) {
        currentMonth?.layer.cornerRadius = value
    }
    public func setButtonCurrentMonthTextColor(color: UIColor) {
        currentMonth?.setTitleColor(color, for: .normal)
    }
    public func setButtonCurrentMonthTitle(text: String) {
        currentMonth?.setTitle(text, for: .normal)
    }
    public func setButtonCurrentMonthAttributedText(attributedText: NSAttributedString) {
        currentMonth?.setAttributedTitle(attributedText, for: .normal)
    }
    
    public func setButtonNextMonthBackground(color: UIColor) {
        nextMonth?.backgroundColor = color
    }
    public func setButtonNextMonthCorner(value: CGFloat) {
        nextMonth?.layer.cornerRadius = value
    }
    public func setButtonNextMonthTextColor(color: UIColor) {
        nextMonth?.setTitleColor(color, for: .normal)
    }
    public func setButtonNextMonthTitle(text: String) {
        nextMonth?.setTitle(text, for: .normal)
    }
    public func setButtonNextMonthAttributedText(attributedText: NSAttributedString) {
        nextMonth?.setAttributedTitle(attributedText, for: .normal)
    }
    
    // MARK: CALENDAR KOYOMI
    public func setCalendarCornerRadius(value: CGFloat) {
        calendarKoyomi?.layer.cornerRadius = value
    }
    public func setCalendarBorder(value: CGFloat, color: UIColor) {
        calendarKoyomi?.layer.borderWidth = value
        calendarKoyomi?.layer.borderColor = color.cgColor
    }
    
    public func setCalendarSelected(color: UIColor) {
        calendarKoyomi?.selectedStyleColor = color
    }
    public func setCalendarSectionSeparator(color: UIColor) {
        calendarKoyomi?.sectionSeparatorColor = color
    }
    public func setCalendarSeparator(color: UIColor) {
        calendarKoyomi?.sectionSeparatorColor = color
    }
    public func setCalendarDaysName(color: UIColor) {
        calendarKoyomi?.weekColor = color
    }
    public func setCalendarWeekDay(color: UIColor) {
        calendarKoyomi?.weekdayColor = color
    }
    public func setSaturday(color: UIColor) {
        calendarKoyomi?.holidayColor.saturday = color
    }
    public func setSunday(color: UIColor) {
        calendarKoyomi?.holidayColor.sunday = color
    }
    public func setOtherMonth(color: UIColor) {
        calendarKoyomi?.otherMonthColor = color
    }
    public func setDayBackground(color: UIColor) {
        calendarKoyomi?.dayBackgrondColor = color
    }
    public func setWeekBackground(color: UIColor){
        calendarKoyomi?.weekBackgrondColor = color
    }
    
}

// MARK: ANIMATIONS
extension CalendarKoyomiTool {
    
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
    
    private func closeAnimation() {
        self.delegateCalendarKoyomiTool?.dateSelectedValue?(date: selectedDateValue)
        
        self.mainViewContainer.alpha = 1.0
        self.mainViewContainer.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.mainViewContainer.alpha = 0.0
            self.mainViewContainer.layoutIfNeeded()
        }, completion: { _ in
            isCalendarKoyomiToolOpened = false
            self.mainViewContainer.removeFromSuperview()
        })
    }
    
}

extension CalendarKoyomiTool: KoyomiDelegate {
    
    public func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        
        print("You Selected: \(date ?? Date())")
        
        guard date != nil else {
            self.delegateCalendarKoyomiTool?.dateSelectedValue?(date: nil)
            return
        }
        
        let dateFormatted = dateTools.getStringDateFromDate(date: date!, dateFormatOut: .dateDay)
        self.selectedDateValue = dateFormatted
        
        if !confirmSelectionValue {
            closeAnimation()
        }
        
    }
    
    public func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        textLabelMont?.text = dateTools.getStringDateFromString(date: dateString, dateFormatIn: .monthNameYear, dateFormatOut: .monthNameYear, forceLocaleDevice: true)
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    public func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        if length > invalidPeriodLength {
            print("More than \(invalidPeriodLength) days are invalid period.")
            return false
        }
        return true
    }
}

