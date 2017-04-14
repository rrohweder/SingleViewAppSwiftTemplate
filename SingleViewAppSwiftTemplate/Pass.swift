//
//  Pass.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/12/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class Pass {
    var canAccess = false
    var accessingGateType = "Unknown"
    var accessingEntrantType = "Unknown"
    var foodDiscount = 0
    var merchDiscount = 0
    var guestCanSkipLine = false
    var freeChild = false
    
    func generatePass(requestor: Entrant, gate: Gate) {
        
        if requestor is Guest || requestor is FreeChildGuest {
            
            let guestRequestor = requestor as! Guest
            accessingEntrantType = String(describing: guestRequestor.guestType) + " Guest"

            if requestor is FreeChildGuest {
                let childRequestor = requestor as! FreeChildGuest
                freeChild = isChild(birthdate: childRequestor.dateOfBirth)
            }
            
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            accessingEntrantType = String(describing: workerRequestor.workerType)
        }
        
        // all else is mute if they can't enter
        if accessPermitted(requestor: requestor, gateType: gate.gateType) {
            canAccess = true
            accessingGateType = String(describing: gate.gateType)
            foodDiscount = discountAvailable(requestor: requestor, product: .Food)
            merchDiscount = discountAvailable(requestor: requestor, product: .Merchandise)
            if requestor is Guest {
                if gate is Ride {
                    guestCanSkipLine = canSkipLine(requestor: requestor, gateType: gate.gateType)
                }
            }
        }
    }
}

func printPaperPass(requestor: Entrant, gate: Gate) {
    
    let pass = Pass()

    pass.generatePass(requestor: requestor, gate: gate)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    let dateString = dateFormatter.string(from: Date())
    
    if pass.canAccess {
        
        print("Fun Land Amusement Park")
            print("Access for \(pass.accessingEntrantType) at \(gate.gateName)")
        if gate.gateType == .Amusement {
            if pass.freeChild {
                print("Child with Free Access")
            }
            if pass.guestCanSkipLine {
                print("with \"Skip the Line!\" privilege")
            }
        }
        if (gate.gateType == .FoodVendor && pass.foodDiscount > 0) {
            print("\(pass.foodDiscount)% discount on food purchases")
        }
        if (gate.gateType == .MerchVendor && pass.merchDiscount > 0) {
                print("\(pass.merchDiscount)% discount on merchandise purchases")
        }
        print("Valid on \(dateString)\n\n")
    } else {
            print("Access not allowed for \(pass.accessingEntrantType) at \(gate.gateName)")
            print("As of \(dateString)\n\n")
    }
}
