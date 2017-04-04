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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWorkerInit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // First just make sure the initializer creates the object with the correct
        // data assigned to the correct properties
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
        var date = dateFormatter.date(from: "1953-12-18")!
        
        var oneEmp = Worker(workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
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

        date = dateFormatter.date(from: "1899-12-18")!
        oneEmp = Worker(workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
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
    func testWorkerAccess () {
        let gate = Gate(gateType: GateType.Amusement)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        
        var oneEmp = Worker(workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)

        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Kitchen) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Office) == false)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .RideControl) == false)

        oneEmp = Worker(workerType: .HourlyRideServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Kitchen) == false)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Maintenance) == false)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Office) == false)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .RideControl) == true)

        oneEmp = Worker(workerType: .HourlyMaintenance, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Kitchen) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Maintenance) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Office) == false)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .RideControl) == true)

        oneEmp = Worker(workerType: .Manager, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Kitchen) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Maintenance) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .Office) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneEmp, gateType: .RideControl) == true)

    }

    // FIXME: expand the cases in guest access tests.

    func testGuestAccess () {
        let gate = Gate(gateType: GateType.Amusement)
        let oneGuest = Guest(guestType: .Classic)
        XCTAssert(gate.AccessPermitted(requestor: oneGuest, gateType: .Amusement) == true)
        XCTAssert(gate.AccessPermitted(requestor: oneGuest, gateType: .Office) == false)
    }
    
    func testWorkerDiscount() {
        let gate = Gate(gateType: GateType.Amusement)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "1953-12-18")!
        
        var oneWorker = Worker(workerType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Food) == 15)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Merchandise) == 25)

        oneWorker = Worker(workerType: .HourlyRideServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Food) == 15)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Merchandise) == 25)

        oneWorker = Worker(workerType: .HourlyMaintenance, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Food) == 15)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Merchandise) == 25)

        oneWorker = Worker(workerType: .Manager, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Food) == 25)
        XCTAssert(gate.discountAvailable(requestor: oneWorker, product: .Merchandise) == 25)
    
    }
    
    func testGuestDiscount() {

        var gate = Gate(gateType: GateType.Amusement)

        var oneGuest = Guest(guestType: .Classic)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Merchandise) == 0)
        
        oneGuest = Guest(guestType: .VIP)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 10)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Merchandise) == 20)
        
        oneGuest = Guest(guestType: .FreeChild)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Merchandise) == 0)
        
        gate = Gate(gateType: GateType.Kitchen)
        
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Merchandise) == 0)

// FIXME: I don't really have different discounts per gate, only per product... need to fix.
        
        oneGuest = Guest(guestType: .VIP)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 10)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Merchandise) == 20)

        gate = Gate(gateType: GateType.Kitchen)
        oneGuest = Guest(guestType: .FreeChild)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 0)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Merchandise) == 0)
    }
    
    func testGuestPrivilege() {
        var gate = Gate(gateType: GateType.Amusement)
        
        var oneGuest = Guest(guestType: .Classic)
        XCTAssert(gate.guestRolesSkipPrivilege(gate.gateType
            requestor: oneGuest, product: .Food) == 0)
        
        oneGuest = Guest(guestType: .VIP)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 10)
        
        oneGuest = Guest(guestType: .FreeChild)
        XCTAssert(gate.discountAvailable(requestor: oneGuest, product: .Food) == 0)

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
