//
//  AccessRules.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 10/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

/*
import Foundation

// should benefits also be loaded into a plist file?

class AccessRules {
    // should this class contain the function(s) that answer questions about access? YES
    // dump permissionsAndBenefits file? Copy some or all of it here?
    // need to replace all logic that uses guestRolesAccess, workerRolesAccess with this:
    var byGuestRole:  [GuestType:[GateType:Bool]]
    var byWorkerRole:  [WorkerType:[GateType:Bool]]
    var byProjectNum: [Int:[GateType:Bool]]
    var byCompanyName: [String:[String:Bool]]
    
    init()
    {
        // FIXME: test for required values, return nil if not complete. Alert?
        self.byGuestRole = loadRules(inputFile: "AccessRules", fileType: "plist")
        

     static func importRules(fromFile name: String, ofType type: String) throws -> [String: AnyObject]? { // a type method
         guard let path = Bundle.main.path(forResource: name, ofType: type) else {
             throw EntrantImportError.invalidResource(resourceName: name)
         }
         guard let allRules = NSDictionary.init(contentsOfFile: path) as! [String: AnyObject]? else {
             throw EntrantImportError.conversionFailure(resourceName: name)
         }
         return allRules
     }
}
*/
