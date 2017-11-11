//
//  RegressionTests.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

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
