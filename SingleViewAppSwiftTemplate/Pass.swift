//
//  Pass.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 4/12/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class Pass {
    var entrantCanAccess = false
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
            entrantCanAccess = accessPermitted(requestor: guestRequestor, gate: gate)
            
            if requestor is FreeChildGuest {
                let childRequestor = requestor as! FreeChildGuest
                freeChild = isFreeChild(birthdateString: dateFormatter.string(from: childRequestor.dateOfBirth))
            }
            
        } else if requestor is Contract {
            let contractorRequestor = requestor as! Contract
            accessingEntrantType = "Project # " + String(describing: contractorRequestor.projectNumber)
            entrantCanAccess = accessPermitted(requestor: contractorRequestor, gate: gate)
        } else if requestor is VendorStaff {
            let vendorRequestor = requestor as! VendorStaff
            accessingEntrantType = "Vendor: " + String(describing: vendorRequestor.companyName)
            entrantCanAccess = accessPermitted(requestor: vendorRequestor, gate: gate)
        } else if requestor is Worker {
            let workerRequestor = requestor as! Worker
            accessingEntrantType = String(describing: workerRequestor.workerType)
            entrantCanAccess = accessPermitted(requestor: workerRequestor, gate: gate)
        }
        
        // all else is mute if they can't enter
        if entrantCanAccess == true {
            accessingGateType = String(describing: gate.gateType)
            foodDiscount = discountAvailable(requestor: requestor, product: .Food)
            merchDiscount = discountAvailable(requestor: requestor, product: .Merchandise)
            if requestor is Guest {
                if gate.gateType == .RideRides {
                    guestCanSkipLine = canSkipLine(requestor: requestor, gateType: gate.gateType)
                }
            }
        }
    } // generatePass()
    
    func printPaperPass(requestor: Entrant, gate: Gate) {

        generatePass(requestor: requestor, gate: gate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let dateString = dateFormatter.string(from: Date())
        
        print("Fun Land Amusement Park")
        print("\(gate.gateName)")

        if entrantCanAccess {
            if gate.gateType == .RideRides {
                print("Access Permitted for \(accessingEntrantType)")
                if guestCanSkipLine {
                    print("with \"Skip the Line!\" privilege")
                }
                if freeChild {
                    print("Free Access")
                }
            } else if gate.gateType != .FoodVendor && gate.gateType != .MerchVendor {
                print("Access permitted for \(accessingEntrantType)")
            }
            if (gate.gateType == .FoodVendor && foodDiscount > 0) {
                print("\(foodDiscount)% discount on food purchases")
            }
            if (gate.gateType == .MerchVendor && merchDiscount > 0) {
                    print("\(merchDiscount)% discount on merchandise purchases")
            }
            print("Valid on \(dateString)\n\n")
        } else {
            print("Access not allowed for \(accessingEntrantType)")
            if freeChild {
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
}

