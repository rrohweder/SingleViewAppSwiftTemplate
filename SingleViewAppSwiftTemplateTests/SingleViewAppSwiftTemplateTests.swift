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
    
    func testEmployeeInit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // First just make sure the initializer creates the object with the correct
        // data assigned to the correct properties
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
        var date = dateFormatter.date(from: "1953-12-18")!
        
        var oneEmp = Employee(employeeType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
        XCTAssert(
            oneEmp.employeeType == .HourlyFoodServices &&
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
        oneEmp = Employee(employeeType: .HourlyFoodServices, firstName: "Roger", lastName: "Rohweder", streetAddress: "1205 Goldenview Ct", city: "Durham", state: "NC", zipCode: "27713", socialSecurityNumber: "329-50-6903", dateofBirth: date)
        
        XCTAssert(oneEmp.employeeType == .HourlyFoodServices)
        XCTAssert(oneEmp.firstName == "Roger")
        XCTAssert(oneEmp.lastName == "Rohweder")
        XCTAssert(oneEmp.streetAddress == "1205 Goldenview Ct")
        XCTAssert(oneEmp.city == "Durham")
        XCTAssert(oneEmp.state == "NC")
        XCTAssert(oneEmp.zipCode == "27713")
        XCTAssert(oneEmp.socialSecurityNumber == "329-50-6903")
        XCTAssert(oneEmp.dateofBirth > dateFormatter.date(from: "1900-01-01")!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
