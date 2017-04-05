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
        
        gate = Gate(gateType: GateType.Amusement)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        anyWorker = Worker(workerID: 1000, workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
        anyGuest = Guest(guestID: 1, guestType: .Classic)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWorkerInit() {
        // First just make sure the initializer creates the object with the correct
        // data assigned to the correct properties

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        
        let oneEmp = Worker(workerID: 1001, workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)

        XCTAssert(
            oneEmp.workerType == .HourlyFoodServices &&
            oneEmp.firstName == "Roger" &&
            oneEmp.lastName == "Rohweder" &&
            oneEmp.streetAddress == "1205 Goldenview Ct" &&
            oneEmp.city == "Durham" &&
            oneEmp.state == "NC" &&
            oneEmp.zipCode == "27713" &&
            oneEmp.socialSecurityNumber == "329-50-6903" &&
            oneEmp.dateofBirth == date
        )

        
// FIXME: don't MAKE the object and then test it, test it in the init, and fail (return nil)
        
        XCTAssert(oneEmp.workerType == .HourlyFoodServices)
        XCTAssert(oneEmp.firstName == "Roger")
        XCTAssert(oneEmp.lastName == "Rohweder")
        XCTAssert(oneEmp.streetAddress == "1205 Goldenview Ct")
        XCTAssert(oneEmp.city == "Durham")
        XCTAssert(oneEmp.state == "NC")
        XCTAssert(oneEmp.zipCode == "27713")
        XCTAssert(oneEmp.socialSecurityNumber == "329-50-6903")
        XCTAssert(oneEmp.dateofBirth > dateFormatter.date(from: "1900-01-01")!)
    }
// down to here
    
    func testWorkerAccess () {
        
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Kitchen) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Office) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .RideControl) == false)

        anyWorker.workerType = .HourlyRideServices
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Kitchen) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Office) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .RideControl) == true)

        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Kitchen) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Maintenance) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Office) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .RideControl) == true)

        anyWorker.workerType = .Manager
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Kitchen) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Maintenance) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .Office) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyWorker, gateType: .RideControl) == true)
    }

    // FIXME: expand the cases in guest access tests.

    func testGuestAccess () {

        anyGuest.guestType = .Classic
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Kitchen) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .RideControl) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Office) == false)
        
        anyGuest.guestType = .VIP
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Kitchen) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .RideControl) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Office) == false)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Kitchen) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .RideControl) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: anyGuest, gateType: .Office) == false)
    }
    
    func testWorkerDiscount() {

        anyWorker.workerType = .HourlyFoodServices
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

        anyWorker.workerType = .HourlyRideServices
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

        anyWorker.workerType = .HourlyMaintenance
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Food) == 15)
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)

        anyWorker.workerType = .Manager
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Food) == 25)
        XCTAssert(gate.discountAvailable(requestor: anyWorker, product: .Merchandise) == 25)
    
    }
    
    func testGuestDiscount() {

        // There typically wouldn't be different discounts per gate, only per product.
        // it maybe makes sense for an entrant to get X% for ANY food, Y% for ANY merchandise.
        // so I can skip the gate layer...

        gate.gateType = .Amusement

        anyGuest.guestType = .Classic
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        anyGuest.guestType = .VIP
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Food) == 10)
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Merchandise) == 20)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        gate.gateType = .Kitchen
        
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
        
        anyGuest.guestType = .VIP
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Food) == 10)
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Merchandise) == 20)

        gate.gateType = GateType.Kitchen
        anyGuest.guestType = .FreeChild
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: anyGuest, product: .Merchandise) == 0)
    }
    
    func testGuestSkipPrivilege() {
        anyGuest.guestType = .Classic
        XCTAssert(gate.guestCanSkipLine(requestor: anyGuest, gateType: .Amusement) == false)
        
        anyGuest.guestType = .VIP
        XCTAssert(gate.guestCanSkipLine(requestor: anyGuest, gateType: .Amusement) == true)
        
        anyGuest.guestType = .FreeChild
        XCTAssert(gate.guestCanSkipLine(requestor: anyGuest, gateType: .Amusement) == false)

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
