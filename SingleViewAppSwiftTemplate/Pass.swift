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
                freeChild = isFreeChild(birthdateString: dateFormatter.string(from: childRequestor.dateOfBirth))
            }
            
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            accessingEntrantType = String(describing: workerRequestor.workerType)
        }
        
        // all else is mute if they can't enter
        if accessPermitted(requestor: requestor, gate: gate) {
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
    
    print("Fun Land Amusement Park")
    print("\(gate.gateName)")

    if pass.canAccess {
        if gate.gateType == .Amusement {
            print("Access Permitted for \(pass.accessingEntrantType)")
            if pass.guestCanSkipLine {
                print("with \"Skip the Line!\" privilege")
            }
            if pass.freeChild {
                print("Free Access")
            }
        } else if gate.gateType != .FoodVendor && gate.gateType != .MerchVendor {
            print("Access permitted for \(pass.accessingEntrantType)")
        }
        if (gate.gateType == .FoodVendor && pass.foodDiscount > 0) {
            print("\(pass.foodDiscount)% discount on food purchases")
        }
        if (gate.gateType == .MerchVendor && pass.merchDiscount > 0) {
                print("\(pass.merchDiscount)% discount on merchandise purchases")
        }
        print("Valid on \(dateString)\n\n")
    } else {
        print("Access not allowed for \(pass.accessingEntrantType)")
        if pass.freeChild {
            if gate is Ride {
                let ride = gate as! Ride
                if ride.ageRestricted {
                    print("(age-restricted ride)")
                }
            }
        }
        print("As of \(dateString)\n\n")
    }
}
