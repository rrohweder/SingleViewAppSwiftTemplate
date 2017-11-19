//
//  RegressionTests.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

// in addition to the Unit Tests, I wanted a to perform a pass that
// displayed permissions and benefits for every entrant, at every area

//  these only exist to for-loop through, generating passes for test purposes
var vendors = [Vendor]()
var nonpublics = [NonPublic]()
var workers = [Workers]()
var guests = [AnyObject]()
var vendorFolks = [VendorStaff]()
var contractorFolks = [Contractors]()

func runRegressionTests() -> Void {
    
    let pass = Pass()

    for guest in guests {
        for ride in rides {
            pass.printPaperPass(requestor: guest as! Entrant, gate: ride)
        }
        for vendor in vendors {
            pass.printPaperPass(requestor: guest as! Entrant, gate: vendor)
        }
        for nonpublic in nonpublics {
            pass.printPaperPass(requestor: guest as! Entrant, gate: nonpublic)
        }
    }
    for worker in workers {
        for ride in rides {
            pass.printPaperPass(requestor: worker, gate: ride)
        }
        for vendor in vendors {
            pass.printPaperPass(requestor: worker, gate: vendor)
        }
        for nonpublic in nonpublics {
            pass.printPaperPass(requestor: worker, gate: nonpublic)
        }
    }

    for vendorStaff in vendorFolks {
        for ride in rides {
            pass.printPaperPass(requestor: vendorStaff, gate: ride)
        }
        for vendor in vendors {
            pass.printPaperPass(requestor: vendorStaff, gate: vendor)
        }
        for nonpublic in nonpublics {
            pass.printPaperPass(requestor: vendorStaff, gate: nonpublic)
        }
    }
}
