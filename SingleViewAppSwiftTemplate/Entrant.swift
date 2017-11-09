//
//  Entrant.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/6/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

let maxFreeChildAge = 5
let minSeniorAge = 65
let dateFormatter = DateFormatter()

//  these only exist to for-loop through, generating passes for test purposes
var vendors = [Vendor]()
var nonpublics = [NonPublic]()
var workers = [Worker]()
var guests = [AnyObject]()
var vendorFolks = [VendorStaff]()
var contractorFolks = [Contract]()


protocol Entrant {
    var entrantID: Int { get }
}

func isSSNValid(socialSecurityNumber: String) -> Bool {
    var isValid = false
    var regexForSSN:NSRegularExpression
    var matches = [NSTextCheckingResult]()
    
    // actual valid SSN needs to match one of these regexs
    // (from https://www.codeproject.com/Articles/651609/Validating-Social-Security-Numbers-through-Regular)
    // ^(?!219-09-9999|078-05-1120)(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4}$   (with dashes)
    // ^(?!219099999|078051120)(?!666|000|9\d{2})\d{3}(?!00)\d{2}(?!0{4})\d{4}$    (without dashes)
    
    regexForSSN = try! NSRegularExpression(pattern: "^(?!219-09-9999|078-05-1120)(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$", options: [])
    matches = regexForSSN.matches(in: socialSecurityNumber, options: [], range: NSRange(location: 0, length: socialSecurityNumber.characters.count))
    if matches.count == 1 {
        isValid = true
    } else {
        regexForSSN = try! NSRegularExpression(pattern: "^(?!219099999|078051120)(?!666|000|9\\d{2})\\d{3}(?!00)\\d{2}(?!0{4})\\d{4}$", options: [])
        matches = regexForSSN.matches(in: socialSecurityNumber, options: [], range: NSRange(location: 0, length: socialSecurityNumber.characters.count))
        if matches.count == 1 {
            isValid = true
        }
    }
    return isValid
}

func isZipCodeValid(zipCode: String) -> Bool {
    var isValid = false
    var regexForZip:NSRegularExpression
    var matches = [NSTextCheckingResult]()

    regexForZip = try! NSRegularExpression(pattern: "^\\d{5}$", options: [])
    matches = regexForZip.matches(in: zipCode, options: [], range: NSRange(location: 0, length: zipCode.characters.count))
    if matches.count == 1 {
        isValid = true
    } else {
        regexForZip = try! NSRegularExpression(pattern: "^\\d{5}-\\d{4}$", options: [])
        matches = regexForZip.matches(in: zipCode, options: [], range: NSRange(location: 0, length: zipCode.characters.count))
        if matches.count == 1 {
            isValid = true
        }
    }
    return isValid
}

func isDateValid(dateString: String) -> Bool {

    if (
        dateString == "MM/DD/YYYY" || dateString.trimmingCharacters(in: NSCharacterSet.whitespaces) == "") {
        return false
    }
    let now = Date()
    let calendar = Calendar.current
    dateFormatter.dateFormat = "MM/dd/yyyy"
    if let date = dateFormatter.date(from: dateString) {
        let ageComponents = calendar.dateComponents([.year, .day], from: date, to: now)
        if (ageComponents.year! > 0 && ageComponents.year! < 120) ||
            (ageComponents.year! == 0 && ageComponents.day! > 0)  {  // at least one day old
            return true
        }
    }
    return false
}

func isFreeChild(birthdateString: String) -> Bool {
    let now = Date()
    let calendar = Calendar.current
    let birthDate = dateFormatter.date(from: birthdateString)!

    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
    if ageComponents.year! <= maxFreeChildAge {
        return true
    } else {
        return false
    }
}

func isSenior(birthdateString: String) -> Bool {
    let now = Date()
    let calendar = Calendar.current
    let birthDate = dateFormatter.date(from: birthdateString)!

    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
    if ageComponents.year! >= minSeniorAge {
        return true
    } else {
        return false
    }
}




