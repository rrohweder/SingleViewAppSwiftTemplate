//
//  MenuLogic.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 7/3/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

enum mainMenuItem: Int {
    case Guest = 1
    case Employee = 2
    case Manager = 3
    case Vendor = 4
}

enum subMenuItem: Int {
    case Child = 11
    case Adult = 12
    case Senior = 13
    case VP = 14
}

func activateSubmenuItem(mainMenu: mainMenuItem, page: ViewController) {
    switch (mainMenu) {
        case mainMenuItem.Guest:
            // label and activate Child, Adult, Senior, VP
            page.SubMenuButton1.setTitle("Child", for: .normal)
            page.SubMenuButton2.setTitle("Adult", for: .normal)
            page.SubMenuButton3.setTitle("Senior", for: .normal)
            page.SubMenuButton4.setTitle("VP", for: .normal)
            break
        case mainMenuItem.Employee:
            // label and activate HourlyFoodServices, HourlyRideServices, HourlyMaintenance, Manager
            page.SubMenuButton1.setTitle("Food Serv.", for: .normal)
            page.SubMenuButton2.setTitle("Ride Serv.", for: .normal)
            page.SubMenuButton3.setTitle("Maintenance", for: .normal)
            page.SubMenuButton4.setTitle("Manager", for: .normal)
            break
        
        case mainMenuItem.Vendor:
            // label and activate ?, ?, ?
            break
        
        default:
            break
        
    }
}

func setForm(formType: subMenuItem) {
    switch(formType) {
        case subMenuItem.Child: break
        case subMenuItem.Adult: break
        case subMenuItem.Senior: break
        case subMenuItem.VP: break
    }
}

func menuLogic(buttonClicked: UIButton, page: ViewController) {
    
    switch (buttonClicked.tag) {
    case mainMenuItem.Guest.rawValue:
        print("main menu item Guest clicked.")
        activateSubmenuItem(mainMenu: mainMenuItem.Guest, page: page )
    case mainMenuItem.Employee.rawValue:
        print("main menu item Employee clicked.")
        activateSubmenuItem(mainMenu: mainMenuItem.Employee, page: page)
    case mainMenuItem.Manager.rawValue:
        print("main menu item Manager clicked.")
        activateSubmenuItem(mainMenu: mainMenuItem.Manager, page: page)
    case mainMenuItem.Vendor.rawValue:
        print("main menu item Vendor clicked.")
        activateSubmenuItem(mainMenu: mainMenuItem.Vendor, page: page)
    case subMenuItem.Child.rawValue:
        print("sub menu item Child clicked.")
        setForm(formType: subMenuItem.Child)
    case subMenuItem.Adult.rawValue:
        print("sub menu item Adult clicked.")
        setForm(formType: subMenuItem.Child)
    case subMenuItem.Senior.rawValue:
        print("sub menu item Senior clicked.")
        setForm(formType: subMenuItem.Senior)
    case subMenuItem.VP.rawValue:
        print("sub menu item VP clicked.")
        setForm(formType: subMenuItem.VP)
    default:
        print("unknown button clicked. tag = \(buttonClicked.tag)")
    }
    

}

