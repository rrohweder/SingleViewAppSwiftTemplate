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
    case Classic = 12
    case Senior = 13
    case VIP = 14
    case Season = 15
    case HourlyEmployeeFoodServices = 16
    case HourlyEmployeeRideServices = 17
    case HourlyEmployeeMaintenance = 18
    case ContractEmployee = 19
}

func colorSubMenuText(whiteButton: Int, page: ViewController) {
    page.SubMenuButton1.setTitleColor(.gray, for: .normal)
    page.SubMenuButton2.setTitleColor(.gray, for: .normal)
    page.SubMenuButton3.setTitleColor(.gray, for: .normal)
    page.SubMenuButton4.setTitleColor(.gray, for: .normal)
    page.SubMenuButton5.setTitleColor(.gray, for: .normal)
    switch (whiteButton) {
    case 11:
        page.SubMenuButton1.setTitleColor(.white, for: .normal)
    case 12:
        page.SubMenuButton2.setTitleColor(.white, for: .normal)
    case 13:
        page.SubMenuButton3.setTitleColor(.white, for: .normal)
    case 14:
        page.SubMenuButton4.setTitleColor(.white, for: .normal)
    case 15:
        page.SubMenuButton5.setTitleColor(.white, for: .normal)
    case 16:
        page.SubMenuButton1.setTitleColor(.white, for: .normal)
    case 17:
        page.SubMenuButton2.setTitleColor(.white, for: .normal)
    case 18:
        page.SubMenuButton3.setTitleColor(.white, for: .normal)
    case 19:
        page.SubMenuButton4.setTitleColor(.white, for: .normal)
    default:
        print("invalid submenu button number")
        
    }
}

func activateSubmenuItem(mainMenu: mainMenuItem, page: ViewController) {
    switch (mainMenu) {
        case mainMenuItem.Guest:
            // label and activate Child, Classic, Senior, VIP
            
            if page.SubMenuStackView.isHidden == true {
                page.SubMenuBackgroundLabel.isHidden = false
                page.SubMenuStackView.isHidden = false
            }
            
            page.SubMenuButton1.setTitle("Free Child", for: .normal)
            page.SubMenuButton1.tag = subMenuItem.Child.rawValue
            
            page.SubMenuButton2.setTitle("Classic", for: .normal)
            page.SubMenuButton2.tag = subMenuItem.Classic.rawValue
            
            page.SubMenuButton3.setTitle("Senior", for: .normal)
            page.SubMenuButton3.tag = subMenuItem.Senior.rawValue
            
            page.SubMenuButton4.isHidden = false
            page.SubMenuButton4.setTitle("VIP", for: .normal)
            page.SubMenuButton4.tag = subMenuItem.VIP.rawValue
            
            page.SubMenuButton5.isHidden = false
            page.SubMenuButton5.setTitle("Season Pass", for: .normal)
            page.SubMenuButton5.tag = subMenuItem.Season.rawValue
            
            colorSubMenuText(whiteButton: subMenuItem.Child.rawValue, page: page)

            break
        
        case mainMenuItem.Employee:
            // label and activate HourlyFoodServices, HourlyRideServices, HourlyMaintenance, Manager
            if page.SubMenuStackView.isHidden == true {
                page.SubMenuBackgroundLabel.isHidden = false
                page.SubMenuStackView.isHidden = false
            }

            page.SubMenuButton1.setTitle("Food Serv.", for: .normal)
            page.SubMenuButton1.tag = subMenuItem.HourlyEmployeeFoodServices.rawValue

            page.SubMenuButton2.setTitle("Ride Serv.", for: .normal)
            page.SubMenuButton2.tag = subMenuItem.HourlyEmployeeRideServices.rawValue
            
            page.SubMenuButton3.setTitle("Maintenance", for: .normal)
            page.SubMenuButton3.tag = subMenuItem.HourlyEmployeeMaintenance.rawValue
        
            page.SubMenuButton4.isHidden = true
            page.SubMenuButton5.isHidden = true
            colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeFoodServices.rawValue, page: page)

/* these cases don't occur -- no submenu for them
        case mainMenuItem.Manager:
            // hide submenu, set form?
            break
        
        case mainMenuItem.Vendor:
            // hide submenu, set form?
            break
*/
        default:
            break
        
    }
}

func setForm(formType: subMenuItem) {
    switch(formType) {
        case subMenuItem.Child:
            // Date of Birth
        break
        
        case subMenuItem.Classic:
            // No personal information required.
        break
        
        case subMenuItem.Senior:
            /*
            -First Name
            -Last Name
            -Date of Birth
             */
        break
        
        case subMenuItem.VIP:
            // No personal information required.
        break
        
        case subMenuItem.Season:
            /*
            -First Name
            -Last Name
            -Street Address
            -City
            -State
            -Zip Code
            -Date of Birth
            */

        break
        
        case subMenuItem.HourlyEmployeeFoodServices,
         subMenuItem.HourlyEmployeeRideServices,
         subMenuItem.HourlyEmployeeMaintenance,
         subMenuItem.ContractEmployee:
         /*
            -First Name
            -Last Name
            -Street Address
            -City
            -State
            -Zip Code
            -Social Security Number
            -Date of Birth
            */
        break
    }
}

func menuLogic(buttonClicked: UIButton, page: ViewController) {
    if (buttonClicked.tag < 10) {
        page.MainMenuButton1.setTitleColor(.gray, for: .normal)
        page.MainMenuButton2.setTitleColor(.gray, for: .normal)
        page.MainMenuButton3.setTitleColor(.gray, for: .normal)
        page.MainMenuButton4.setTitleColor(.gray, for: .normal)
    } else {
        print("sub", terminator:"")
    }
    print("menu item \(buttonClicked.tag) clicked.")
    
    
    switch (buttonClicked.tag) {
        
    case mainMenuItem.Guest.rawValue:
        page.MainMenuButton1.setTitleColor(.white, for: .normal)
        activateSubmenuItem(mainMenu: mainMenuItem.Guest, page: page )
        
    case mainMenuItem.Employee.rawValue:
        page.MainMenuButton2.setTitleColor(.white, for: .normal)
        activateSubmenuItem(mainMenu: mainMenuItem.Employee, page: page)
        
    case mainMenuItem.Manager.rawValue:
        page.MainMenuButton3.setTitleColor(.white, for: .normal)
        // hide submenu, display form
        page.SubMenuStackView.isHidden = true
        page.SubMenuBackgroundLabel.isHidden = true
        
        
    case mainMenuItem.Vendor.rawValue:
        page.MainMenuButton4.setTitleColor(.white, for: .normal)
        page.SubMenuStackView.isHidden = true
        // hide submenu, display form
        
    case subMenuItem.Child.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Child.rawValue, page: page)
        setForm(formType: subMenuItem.Child)
        
    case subMenuItem.Classic.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Classic.rawValue, page: page)
        setForm(formType: subMenuItem.Classic)
        
    case subMenuItem.Senior.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Senior.rawValue, page: page)
        setForm(formType: subMenuItem.Senior)
        
    case subMenuItem.VIP.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.VIP.rawValue, page: page)
        setForm(formType: subMenuItem.VIP)
        
    case subMenuItem.Season.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Season.rawValue, page: page)
        setForm(formType: subMenuItem.Season)

    case subMenuItem.HourlyEmployeeFoodServices.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeFoodServices.rawValue, page: page)
        setForm(formType: subMenuItem.HourlyEmployeeFoodServices)
    
    case subMenuItem.HourlyEmployeeRideServices.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeRideServices.rawValue, page: page)
        setForm(formType: subMenuItem.HourlyEmployeeRideServices)
    
    case subMenuItem.HourlyEmployeeMaintenance.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeMaintenance.rawValue, page: page)
        setForm(formType: subMenuItem.HourlyEmployeeMaintenance)
    
    case subMenuItem.ContractEmployee.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.ContractEmployee.rawValue, page: page)
        setForm(formType: subMenuItem.ContractEmployee)
    
    default:
        print("unknown button clicked. tag = \(buttonClicked.tag)")
    }
    

}

