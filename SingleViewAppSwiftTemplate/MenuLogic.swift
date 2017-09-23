//
//  MenuLogic.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 7/3/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

protocol Menus {}

enum mainMenuItem: Int, Menus {
    case Guest = 1
    case Employee = 2
    case Manager = 3
    case Vendor = 4
}

enum subMenuItem: Int, Menus {
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

func fadeMainMenuLabels(page: ViewController) {
    page.MainMenuButton1.setTitleColor(UIColor(red: 195.0/255, green:177.0/255, blue: 213.0/255, alpha: 1), for: .normal)
    page.MainMenuButton2.setTitleColor(UIColor(red: 195.0/255, green:177.0/255, blue: 213.0/255, alpha: 1), for: .normal)
    page.MainMenuButton3.setTitleColor(UIColor(red: 195.0/255, green:177.0/255, blue: 213.0/255, alpha: 1), for: .normal)
    page.MainMenuButton4.setTitleColor(UIColor(red: 195.0/255, green:177.0/255, blue: 213.0/255, alpha: 1), for: .normal)
}

func fadeSubMenuLabels(page: ViewController) {
    page.SubMenuButton1.setTitleColor(UIColor(red: 204.0/255, green:204.0/255, blue: 204.0/255, alpha: 1), for: .normal)
    page.SubMenuButton2.setTitleColor(UIColor(red: 204.0/255, green:204.0/255, blue: 204.0/255, alpha: 1), for: .normal)
    page.SubMenuButton3.setTitleColor(UIColor(red: 204.0/255, green:204.0/255, blue: 204.0/255, alpha: 1), for: .normal)
    page.SubMenuButton4.setTitleColor(UIColor(red: 204.0/255, green:204.0/255, blue: 204.0/255, alpha: 1), for: .normal)
}


func colorSubMenuText(whiteButton: Int, page: ViewController) {
    fadeSubMenuLabels(page: page)
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

func deactivateFormFields(page: ViewController) {
    
    page.DateOfBirthLabel.textColor = .gray
    page.dateOfBirthField.isUserInteractionEnabled = false
    page.dateOfBirthField.textColor = .lightGray
    page.dateOfBirthField.backgroundColor = UIColor(
     red: 204.0/255.0, green: 204.0/255.0,
     blue: 204.0/255.0, alpha: 1.0)
    page.dateOfBirthField.text = "MM/DD/YYYY"

    page.ssnLabel.textColor = .gray
    page.ssnField.isUserInteractionEnabled = false
    page.ssnField.textColor = .lightGray
    page.ssnField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.ssnField.text = "NNN-NN-NNNN"

    page.projectNumLabel.textColor = .gray
    page.projectNumField.isUserInteractionEnabled = false
    page.projectNumField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.projectNumField.text = ""
    
    page.firstNameLabel.textColor = .gray
    page.firstNameField.isUserInteractionEnabled = false
    page.firstNameField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.firstNameField.text = ""
    
    page.lastNameLabel.textColor = .gray
    page.lastNameField.isUserInteractionEnabled = false
    page.lastNameField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.lastNameField.text = ""
    
    page.companyNameLabel.textColor = .gray
    page.companyNameField.isUserInteractionEnabled = false
    page.companyNameField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.companyNameField.text = ""
    
    page.streetAddressLabel.textColor = .gray
    page.streetAddressField.isUserInteractionEnabled = false
    page.streetAddressField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.streetAddressField.text = ""
    
    page.cityLabel.textColor = .gray
    page.cityField.isUserInteractionEnabled = false
    page.cityField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.cityField.text = ""
    
    page.stateLabel.textColor = .gray
    page.stateField.isUserInteractionEnabled = false
    page.stateField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.stateField.text = ""
    
    page.zipLabel.textColor = .gray
    page.zipCodeField.isUserInteractionEnabled = false
    page.zipCodeField.backgroundColor = UIColor(
        red: 204.0/255.0, green: 204.0/255.0,
        blue: 204.0/255.0, alpha: 1.0)
    page.zipCodeField.text = ""
}

func setForm(page: ViewController, formType: Menus) {
    deactivateFormFields(page: page)
    switch(formType) {
        
    case subMenuItem.Child:
        
        page.DateOfBirthLabel.textColor = .black
        page.dateOfBirthField.textColor = .black
        page.dateOfBirthField.backgroundColor = .white
        page.dateOfBirthField.isUserInteractionEnabled = true
        break
        
    case subMenuItem.Classic:
        // No personal information required.
        break
        
    case subMenuItem.Senior:
        
        page.firstNameLabel.textColor = .black
        page.firstNameField.backgroundColor = .white
        page.firstNameField.isUserInteractionEnabled = true
        
        page.lastNameLabel.textColor = .black
        page.lastNameField.backgroundColor = .white
        page.lastNameField.isUserInteractionEnabled = true
        
        page.DateOfBirthLabel.textColor = .black
        page.dateOfBirthField.backgroundColor = .white
        page.dateOfBirthField.isUserInteractionEnabled = true
        break
        
    case subMenuItem.VIP:
        // No personal information required.
        break
        
    case subMenuItem.Season:
        
        page.firstNameLabel.textColor = .black
        page.firstNameField.backgroundColor = .white
        page.firstNameField.isUserInteractionEnabled = true
        
        page.lastNameLabel.textColor = .black
        page.lastNameField.backgroundColor = .white
        page.lastNameField.isUserInteractionEnabled = true
        
        page.streetAddressLabel.textColor = .black
        page.streetAddressField.backgroundColor = .white
        page.streetAddressField.isUserInteractionEnabled = true
        
        page.cityLabel.textColor = .black
        page.cityField.backgroundColor = .white
        page.cityField.isUserInteractionEnabled = true
        
        page.stateLabel.textColor = .black
        page.stateField.backgroundColor = .white
        page.stateField.isUserInteractionEnabled = true
        
        page.zipLabel.textColor = .black
        page.zipCodeField.backgroundColor = .white
        page.zipCodeField.isUserInteractionEnabled = true
        break
        
    case subMenuItem.HourlyEmployeeFoodServices,
         subMenuItem.HourlyEmployeeRideServices,
         subMenuItem.HourlyEmployeeMaintenance,
         subMenuItem.ContractEmployee:
        
        page.firstNameLabel.textColor = .black
        page.firstNameField.backgroundColor = .white
        page.firstNameField.isUserInteractionEnabled = true
        
        page.lastNameLabel.textColor = .black
        page.lastNameField.backgroundColor = .white
        page.lastNameField.isUserInteractionEnabled = true
        
        page.streetAddressLabel.textColor = .black
        page.streetAddressField.backgroundColor = .white
        page.streetAddressField.isUserInteractionEnabled = true
        
        page.cityLabel.textColor = .black
        page.cityField.backgroundColor = .white
        page.cityField.isUserInteractionEnabled = true
        
        page.stateLabel.textColor = .black
        page.stateField.backgroundColor = .white
        page.stateField.isUserInteractionEnabled = true
        
        page.zipLabel.textColor = .black
        page.zipCodeField.backgroundColor = .white
        page.zipCodeField.isUserInteractionEnabled = true
        
        page.ssnLabel.textColor = .black
        page.ssnField.backgroundColor = .white
        page.ssnField.isUserInteractionEnabled = true
        
        page.DateOfBirthLabel.textColor = .black
        page.dateOfBirthField.backgroundColor = .white
        page.dateOfBirthField.isUserInteractionEnabled = true
        break
        
    case mainMenuItem.Manager:
        // FIXME: handle Management Tier 
        
        page.firstNameLabel.textColor = .black
        page.firstNameField.backgroundColor = .white
        page.firstNameField.isUserInteractionEnabled = true
        
        page.lastNameLabel.textColor = .black
        page.lastNameField.backgroundColor = .white
        page.lastNameField.isUserInteractionEnabled = true
        
        page.streetAddressLabel.textColor = .black
        page.streetAddressField.backgroundColor = .white
        page.streetAddressField.isUserInteractionEnabled = true
        
        page.cityLabel.textColor = .black
        page.cityField.backgroundColor = .white
        page.cityField.isUserInteractionEnabled = true
        
        page.stateLabel.textColor = .black
        page.stateField.backgroundColor = .white
        page.stateField.isUserInteractionEnabled = true
        
        page.zipLabel.textColor = .black
        page.zipCodeField.backgroundColor = .white
        page.zipCodeField.isUserInteractionEnabled = true
        
        page.ssnLabel.textColor = .black
        page.ssnField.backgroundColor = .white
        page.ssnField.isUserInteractionEnabled = true
        
        page.DateOfBirthLabel.textColor = .black
        page.dateOfBirthField.backgroundColor = .white
        page.dateOfBirthField.isUserInteractionEnabled = true
        break

    case mainMenuItem.Vendor:
        // FIXME: handle Date of Visit
        
        page.firstNameLabel.textColor = .black
        page.firstNameField.backgroundColor = .white
        page.firstNameField.isUserInteractionEnabled = true
        
        page.lastNameLabel.textColor = .black
        page.lastNameField.backgroundColor = .white
        page.lastNameField.isUserInteractionEnabled = true

        page.companyNameLabel.textColor = .black
        page.companyNameField.backgroundColor = .white
        page.companyNameField.isUserInteractionEnabled = true

        // FIXME: add Date of Visit
        
        page.DateOfBirthLabel.textColor = .black
        page.dateOfBirthField.backgroundColor = .white
        page.dateOfBirthField.isUserInteractionEnabled = true
        break
        
        
        break

// FIXME: error message? can one pass an invalid form type?
    default: break
    }
}


func activateSubmenuItem(mainMenu: mainMenuItem, page: ViewController) {
    switch (mainMenu) {
        case mainMenuItem.Guest:
            
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

        // Manager and Vendor don't have submenus
        
        default:
            break
        
    }
}

func menuLogic(buttonClicked: UIButton, page: ViewController) {
    
    fadeSubMenuLabels(page: page)
    deactivateFormFields(page: page)
    if (buttonClicked.tag < 10) { // if clicked any MainMenu item
        fadeMainMenuLabels(page: page)
    } else {
        page.enablePopulateButton()
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
        page.SubMenuStackView.isHidden = true
        page.SubMenuBackgroundLabel.isHidden = true
        setForm(page: page, formType: mainMenuItem.Manager)
        page.enablePopulateButton()
        
    case mainMenuItem.Vendor.rawValue:
        page.MainMenuButton4.setTitleColor(.white, for: .normal)
        page.SubMenuStackView.isHidden = true
        page.SubMenuBackgroundLabel.isHidden = true
        setForm(page: page, formType: mainMenuItem.Vendor)
        page.enablePopulateButton()
        
    case subMenuItem.Child.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Child.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.Child)
        
    case subMenuItem.Classic.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Classic.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.Classic)
        
    case subMenuItem.Senior.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Senior.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.Senior)
        
    case subMenuItem.VIP.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.VIP.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.VIP)
        
    case subMenuItem.Season.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.Season.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.Season)

    case subMenuItem.HourlyEmployeeFoodServices.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeFoodServices.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.HourlyEmployeeFoodServices)
    
    case subMenuItem.HourlyEmployeeRideServices.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeRideServices.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.HourlyEmployeeRideServices)
    
    case subMenuItem.HourlyEmployeeMaintenance.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.HourlyEmployeeMaintenance.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.HourlyEmployeeMaintenance)
    
    case subMenuItem.ContractEmployee.rawValue:
        colorSubMenuText(whiteButton: subMenuItem.ContractEmployee.rawValue, page: page)
        setForm(page: page, formType: subMenuItem.ContractEmployee)
    
    default:
        print("unknown button clicked. tag = \(buttonClicked.tag)")
    }
}
