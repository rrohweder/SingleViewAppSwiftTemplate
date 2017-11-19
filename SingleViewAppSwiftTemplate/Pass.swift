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
    
    let accessAndBenefits = PermissionsAndBenefits()
    let validator = Validator()
    
    func generatePass(requestor: Entrant, gate: Gate) {
        
        if requestor is Guests || requestor is FreeChildGuests {
            
            let guestRequestor = requestor as! Guests
            accessingEntrantType = String(describing: guestRequestor.guestType) + " Guest"
            entrantCanAccess = accessAndBenefits.accessPermitted(requestor: guestRequestor, gate: gate)
            
            if requestor is FreeChildGuests {
                let childRequestor = requestor as! FreeChildGuests
                freeChild = validator.isFreeChild(birthdate: childRequestor.dateOfBirth)
            }
            
        } else if requestor is Contractors {
            let contractorRequestor = requestor as! Contractors
            accessingEntrantType = "Project # " + String(describing: contractorRequestor.projectNumber)
            entrantCanAccess = accessAndBenefits.accessPermitted(requestor: contractorRequestor, gate: gate)
        } else if requestor is VendorStaff {
            let vendorRequestor = requestor as! VendorStaff
            accessingEntrantType = "Vendor: " + String(describing: vendorRequestor.companyName)
            entrantCanAccess = accessAndBenefits.accessPermitted(requestor: vendorRequestor, gate: gate)
        } else if requestor is Workers {
            let workerRequestor = requestor as! Workers
            accessingEntrantType = String(describing: workerRequestor.workerType)
            entrantCanAccess = accessAndBenefits.accessPermitted(requestor: workerRequestor, gate: gate)
        }
        
        // all else is mute if they can't enter
        if entrantCanAccess == true {
            accessingGateType = String(describing: gate.gateType)
            foodDiscount = accessAndBenefits.discountAvailable(requestor: requestor, product: .food)
            merchDiscount = accessAndBenefits.discountAvailable(requestor: requestor, product: .merchandise)
            if requestor is Guests {
                if gate.gateType == .rideRides {
                    guestCanSkipLine = accessAndBenefits.canSkipLine(requestor: requestor, gateType: gate.gateType)
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
            if gate.gateType == .rideRides {
                print("Access Permitted for \(accessingEntrantType)")
                if guestCanSkipLine {
                    print("with \"Skip the Line!\" privilege")
                }
                if freeChild {
                    print("Free Access")
                }
            } else if gate.gateType != .foodVendor && gate.gateType != .merchVendor {
                print("Access permitted for \(accessingEntrantType)")
            }
            if (gate.gateType == .foodVendor && foodDiscount > 0) {
                print("\(foodDiscount)% discount on food purchases")
            }
            if (gate.gateType == .merchVendor && merchDiscount > 0) {
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

