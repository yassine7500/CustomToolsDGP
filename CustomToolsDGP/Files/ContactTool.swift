//
//  ContactTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 08/08/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import Contacts

public class ContactTool {
    
    public init() {
    }
    
    public func createContact(givenName: String, workEmail: String, departmentName: String, note: String) -> CNContact {
        
        // Creating a mutable object to add to the contact
        let contact = CNMutableContact()
        
        contact.imageData = Data() // The profile picture as a NSData object
        contact.givenName = givenName
        contact.departmentName = departmentName
        contact.note = note
        
        let workEmail = CNLabeledValue(label: CNLabelWork, value: workEmail as NSString)
        contact.emailAddresses = [workEmail]
        
        return contact
    }
    
    public func shareContacts(contacts: [CNContact], viewController: UIViewController) throws {
        
        guard let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        
        var filename = NSUUID().uuidString
        
        // Create a human friendly file name if sharing a single contact.
        if let contact = contacts.first, contacts.count == 1 {
            if let fullname = CNContactFormatter().string(from: contact) {
                filename = fullname.components(separatedBy: " ").joined(separator: "")
            }
        }
        
        let fileURL = directoryURL
            .appendingPathComponent(filename)
            .appendingPathExtension("vcf")
        
        let data = try CNContactVCardSerialization.data(with: contacts)
        
        print("filename: \(filename)")
        print("contact: \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
        
        try data.write(to: fileURL, options: [.atomicWrite])
        
        let activityViewController = UIActivityViewController(
            activityItems: [fileURL],
            applicationActivities: nil
        )
        
        viewController.present(activityViewController, animated: true, completion: {})
    }
    
}
