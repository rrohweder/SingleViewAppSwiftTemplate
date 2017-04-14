//
//  SingleViewAppSwiftTemplateTests.swift
//  SingleViewAppSwiftTemplateTests
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import XCTest
@testable import SingleViewAppSwiftTemplate

class SingleViewAppSwiftTemplateTests: XCTestCase {
    
    var gate:Gate!
    var anyWorker:Worker!
    var anyGuest:Guest!
    
    override func setUp() {
        super.setUp()
        
        // create one of each needed object:
        
        gate = Gate(gateID: 1, gateType: GateType.Amusement, gateName: "Whirlygig")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        anyWorker = Worker(entrantID: 1000, workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateOfBirth: date)
        
        anyGuest = Guest(entrantID: 1, guestType: .Classic)
    }
    
    override func tearDown() {
        // swift will handle dealloc of objects.
        super.tearDown()
    }
    
    func testWorkerAccess () {
        
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Kitchen) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Office) == false)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .RideControl) == false)

        anyWorker.workerType = .HourlyRideServices
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Kitchen) == false)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Office) == false)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .RideControl) == true)

        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Kitchen) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Maintenance) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Office) == false)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .RideControl) == true)

        anyWorker.workerType = .Manager
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Kitchen) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Maintenance) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .Office) == true)
        XCTAssert(accessPermitted(requestor: anyWorker, gateType: .RideControl) == true)
    }

    func testGuestAccess () {

        anyGuest.guestType = .Classic
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Kitchen) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .RideControl) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Office) == false)
        
        anyGuest.guestType = .VIP
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Kitchen) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .RideControl) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Office) == false)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Amusement) == true)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Kitchen) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .RideControl) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Maintenance) == false)
        XCTAssert(accessPermitted(requestor: anyGuest, gateType: .Office) == false)
    }
    
    func testWorkerDiscount() {

        anyWorker.workerType = .HourlyFoodServices
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

        anyWorker.workerType = .HourlyRideServices
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

        anyWorker.workerType = .Manager
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Food) == 25)
        XCTAssert(discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
    
    }
    
    func testGuestDiscount() {

        // There typically wouldn't be different discounts per gate, only per product.
        // it maybe makes sense for an entrant to get X% for ANY food, Y% for ANY merchandise.
        // so I can skip the gate layer...

        gate.gateType = .Amusement

        anyGuest.guestType = .Classic
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        anyGuest.guestType = .VIP
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 10)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 20)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        gate.gateType = .Kitchen
        
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        anyGuest.guestType = .VIP
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 10)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 20)

        gate.gateType = GateType.Kitchen
        anyGuest.guestType = .FreeChild
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
    }
    
    func testGuestSkipPrivilege() {
        anyGuest.guestType = .Classic
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .Amusement) == false)
        
        anyGuest.guestType = .VIP
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .Amusement) == true)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(canSkipLine(requestor: anyGuest, gateType: .Amusement) == false)

        anyWorker.workerType = .HourlyFoodServices
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
        anyWorker.workerType = .HourlyRideServices
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
        anyWorker.workerType = .Manager
        XCTAssert(canSkipLine(requestor: anyWorker, gateType: .Amusement) == false)
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
