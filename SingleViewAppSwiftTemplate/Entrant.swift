//
//  Entrant.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/6/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

let maxChildAge = 5

protocol Entrant {
    var entrantID: Int { get }
}

func validSSN(socialSecurityNumber: String) -> Bool {
    if socialSecurityNumber.characters.count == 9 {
        return true
    } else {
        return false
    }
}

func validZipCode(zipCode: String) -> Bool {
    if (zipCode.characters.count == 5 || zipCode.characters.count == 9) {
        return true
    } else {
        return false
    }
}

func isChild(birthdate: Date) -> Bool {
    let now = Date()
    let calendar = Calendar.current
    
    let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
    if ageComponents.year! <= maxChildAge {
        return true
        
    } else {
        return false
    }
}


