//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PassViewControllerDelegate {
    
    var lastClicked = 0
    let dateFormatter = DateFormatter()
    var currentEntrant: Entrant?
    
    @IBOutlet weak var MainMenuButton1: UIButton!
    @IBOutlet weak var MainMenuButton2: UIButton!
    @IBOutlet weak var MainMenuButton3: UIButton!
    @IBOutlet weak var MainMenuButton4: UIButton!

    @IBOutlet weak var SubMenuButton1: UIButton!
    @IBOutlet weak var SubMenuButton2: UIButton!
    @IBOutlet weak var SubMenuButton3: UIButton!
    @IBOutlet weak var SubMenuButton4: UIButton!
    @IBOutlet weak var SubMenuButton5: UIButton!
    @IBOutlet weak var SubMenuStackView: UIStackView!
    @IBOutlet weak var SubMenuBackgroundLabel: UILabel!
    
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var DateOfBirthLabel: UILabel!
    @IBOutlet weak var ssnField: UITextField!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var projectNumField: UITextField!
    @IBOutlet weak var projectNumLabel: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var MgmtTierLabel: UILabel!
    @IBOutlet weak var MgmtTierField: UITextField!
    @IBOutlet weak var lastVisitLabel: UILabel!
    @IBOutlet weak var lastVisitField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var zipLabel: UILabel!
    
    
    func enablePopulateButton() {
        populateDataButton.isEnabled = true
        populateDataButton.backgroundColor = .white
        populateDataButton.setTitleColor(UIColor(
            red: 90.0/255.0, green: 149.0/255.0,
            blue: 143.0/255.0, alpha: 1.0), for: .normal)
    }
    
    func disablePopulateButton() {
        populateDataButton.isEnabled = false
        populateDataButton.backgroundColor = UIColor(
            red: 230.0/255.0, green: 230.0/255.0,
            blue: 230.0/255.0, alpha: 1.0)
        populateDataButton.setTitleColor(UIColor(
            red: 179.0/255.0, green: 179.0/255.0,
            blue: 179.0/255.0, alpha: 1.0),for: .normal)
    }
    
    func enableGeneratePassButton() {
        generatePassButton.isEnabled = true
        generatePassButton.backgroundColor = UIColor(
            red: 90.0/255.0, green: 149.0/255.0,
            blue: 143.0/255.0, alpha: 1.0)
        generatePassButton.setTitleColor(.white, for: .normal)
    }
    
    func disableGeneratePassButton() {
        generatePassButton.isEnabled = false
        generatePassButton.backgroundColor = UIColor(
            red: 230.0/255.0, green: 230.0/255.0,
            blue: 230.0/255.0, alpha: 1.0)
        generatePassButton.setTitleColor(UIColor(
            red: 179.0/255.0, green: 179.0/255.0,
            blue: 179.0/255.0, alpha: 1.0),for: .normal)
    }
    
    func myVCDidFinish(controller:PassViewController,text:String) {
        deactivateFormFields(page: self)
        disablePopulateButton()
        disableGeneratePassButton()
        
        if (lastClicked <= 15) {
            activateSubmenuItem(mainMenu: mainMenuItem.Guest, page: self)
        } else {
            activateSubmenuItem(mainMenu: mainMenuItem.Employee, page: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        // disable form fields, gray labels until a submenu item is selected
        deactivateFormFields(page: self)
        // disable these until user has selected a type of entrant (menu/submenu)
        disablePopulateButton()
        disableGeneratePassButton()

        /* These don't change in this exercise, but one might set default main menu button labels. I went with generic ("mainMenu1") in the storyboard, and set them at launch. */
        self.MainMenuButton1.setTitle("Guest", for: .normal)
        self.MainMenuButton2.setTitle("Employee", for: .normal)
        self.MainMenuButton3.setTitle("Manager", for: .normal)
        self.MainMenuButton4.setTitle("Vendor", for: .normal)
        
        // set submenu button labels for default main menu item (Guest)
        activateSubmenuItem(mainMenu: mainMenuItem.Guest, page: self)

        loadAllData()
        
        runRegressionTests()
        
    } // end of ViewDidLoad()

    
    @IBAction func menuHandler(_ sender: UIButton) {
        disableGeneratePassButton()
        if (sender.tag == mainMenuItem.Guest.rawValue ||
            sender.tag == mainMenuItem.Employee.rawValue) {
            disablePopulateButton()
        } else {
            enablePopulateButton()
            enableGeneratePassButton()
        }
        lastClicked = sender.tag
        menuLogic(buttonClicked: sender, page: self)
    }

    
    // FIXME: move this to another file
    func populateFormWithRandomPerson(menuSelection: Int) -> Entrant {
        switch (menuSelection) {
            case subMenuItem.Child.rawValue:
                if let freeChild = getEntrant(entrantType: GuestType.FreeChild) as! FreeChildGuest? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: freeChild.dateOfBirth)
                    return freeChild as Entrant
                }
            
            case subMenuItem.Classic.rawValue:
                // FIXME: create guest record to return
                // Nothing to display in the form, all they have is an ID
                // but we do want to use the Entrant record for pass creation
                break
            
            case subMenuItem.Senior.rawValue:
                if let senior = getEntrant(entrantType: GuestType.Senior) as! SeniorGuest? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: senior.dateOfBirth)
                    firstNameField.text = senior.firstName
                    lastNameField.text = senior.lastName
                    return senior as Entrant
                }

            
            case subMenuItem.VIP.rawValue:
                
                if let vip = getEntrant(entrantType: GuestType.VIP) as! VIPGuest? {
                    return vip as Entrant
                }
                break
            
            case subMenuItem.Season.rawValue:
                if let season = getEntrant(entrantType: GuestType.Season) as! SeasonPassGuest? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: season.dateOfBirth)
                    firstNameField.text = season.firstName
                    lastNameField.text = season.lastName
                    streetAddressField.text = season.streetAddress
                    cityField.text = season.city
                    stateField.text = season.state
                    zipCodeField.text = season.zipCode
                    return season as Entrant
                }

            case subMenuItem.HourlyEmployeeFoodServices.rawValue,
                 subMenuItem.HourlyEmployeeRideServices.rawValue,
                 subMenuItem.HourlyEmployeeMaintenance.rawValue:
            
                var wt = WorkerType.HourlyFoodServices
                
                switch (menuSelection) {
                    case subMenuItem.HourlyEmployeeFoodServices.rawValue: wt = WorkerType.HourlyFoodServices
                    case subMenuItem.HourlyEmployeeRideServices.rawValue: wt = WorkerType.HourlyRideServices
                    case subMenuItem.HourlyEmployeeMaintenance.rawValue: wt = WorkerType.HourlyMaintenance

                    default: // FIXME: what to do here?
                        break
                }
                
                if let employee = getEntrant(entrantType: wt) {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: employee.dateOfBirth)
                    ssnField.textColor = .black
                    ssnField.text = employee.socialSecurityNumber
                    firstNameField.text = employee.firstName
                    lastNameField.text = employee.lastName
                    streetAddressField.text = employee.streetAddress
                    cityField.text = employee.city
                    stateField.text = employee.state
                    zipCodeField.text = employee.zipCode
                    return employee as Entrant
                }

            case mainMenuItem.Manager.rawValue:
                
                if let mgr = getEntrant(entrantType: WorkerType.Manager) as! Manager? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: mgr.dateOfBirth)
                    ssnField.textColor = .black
                    ssnField.text = mgr.socialSecurityNumber
                    firstNameField.text = mgr.firstName
                    lastNameField.text = mgr.lastName
                    streetAddressField.text = mgr.streetAddress
                    cityField.text = mgr.city
                    stateField.text = mgr.state
                    zipCodeField.text = mgr.zipCode
                    MgmtTierField.text = mgr.mgmtTier
                    return mgr as Entrant
                }
            
            case subMenuItem.ContractEmployee.rawValue:
                
                if let contractor = getEntrant(entrantType: WorkerType.Contract) as! Contract? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: contractor.dateOfBirth)
                    ssnField.textColor = .black
                    ssnField.text = contractor.socialSecurityNumber
                    firstNameField.text = contractor.firstName
                    lastNameField.text = contractor.lastName
                    streetAddressField.text = contractor.streetAddress
                    cityField.text = contractor.city
                    stateField.text = contractor.state
                    zipCodeField.text = contractor.zipCode
                    projectNumField.text = String(contractor.projectNumber)
                    return contractor as Entrant
                }

            case mainMenuItem.Vendor.rawValue:

                if let vendorstaff = getVendorEntrant() {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: vendorstaff.dateOfBirth)
                    firstNameField.text = vendorstaff.firstName
                    lastNameField.text = vendorstaff.lastName
                    companyNameField.text = vendorstaff.companyName
                    lastVisitField.textColor = .black
                    lastVisitField.text = dateFormatter.string(from: vendorstaff.dateOfLastVisit)
                    return vendorstaff as Entrant
                }
            
        default:
            print("invalid menu / submenu selection: tag=\(menuSelection)")
        } // end of switch (menuselection)
        return currentEntrant!
    } // end of populateFormWithRandomPerson()
    
    func createEntrantFromFormData() -> Entrant {
        var entrant: Entrant?
        var wt: WorkerType
        
        switch (lastClicked) {

            case subMenuItem.Child.rawValue:
                entrant = FreeChildGuest(entrantID: 1, guestType: .FreeChild, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!)
            
            case subMenuItem.Classic.rawValue:
                entrant = Guest(entrantID: 2, guestType: .Classic)
            
            case subMenuItem.Senior.rawValue:
                entrant = SeniorGuest(entrantID: 3, guestType: .Senior, firstName: firstNameField.text!, lastName: lastNameField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!)
            
            case subMenuItem.VIP.rawValue:
                entrant = Guest(entrantID: 2, guestType: .VIP)

            case subMenuItem.Season.rawValue:
                entrant = SeasonPassGuest(entrantID: 5, guestType: .Season, firstName: firstNameField.text!, lastName: lastNameField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!, streetAddress: streetAddressField.text!, city: cityField.text!, state: stateField.text!, zipCode: zipCodeField.text!)
            
            case subMenuItem.HourlyEmployeeFoodServices.rawValue,
                 subMenuItem.HourlyEmployeeRideServices.rawValue,
                 subMenuItem.HourlyEmployeeMaintenance.rawValue:
                switch (lastClicked) {
                    case subMenuItem.HourlyEmployeeFoodServices.rawValue: wt = WorkerType.HourlyFoodServices
                    case subMenuItem.HourlyEmployeeRideServices.rawValue: wt = WorkerType.HourlyRideServices
                    case subMenuItem.HourlyEmployeeMaintenance.rawValue: wt = WorkerType.HourlyMaintenance
                // FIXME: is there another way to deal with wt value than this?
                    default: wt = WorkerType.HourlyFoodServices
                }
                entrant = Worker(entrantID: 6, workerType: wt, firstName: firstNameField.text!, lastName: lastNameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!, state: stateField.text!, zipCode: zipCodeField.text!, socialSecurityNumber: ssnField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!)
            
            case mainMenuItem.Manager.rawValue:
                entrant = Manager(entrantID: 6, workerType: .Manager, firstName: firstNameField.text!, lastName: lastNameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!, state: stateField.text!, zipCode: zipCodeField.text!, socialSecurityNumber: ssnField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!, mgmtTier: MgmtTierField.text!)
            
        case mainMenuItem.Vendor.rawValue:
            entrant = VendorStaff(entrantID: 6, workerType: .VendorStaff, firstName: firstNameField.text!, lastName: lastNameField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!, companyName: companyNameField.text!, dateOfLastVisit: dateFormatter.date(from: lastVisitField.text!)!)

            default:
                entrant = Guest(entrantID: 99, guestType: .Classic)
        } // end of switch (lastClicked)
        
        return entrant!
    } // end of createEntrantFromFormData()
    
    @IBAction func genericFieldExit(_ sender: Any) {
        // on Editing Did End (not always...)
        // isFormComplete() changed to only calling when GeneratePass button is clicked.
    }
    
    @IBAction func dobEntry(_ sender: Any) {
        dateOfBirthField.textColor = .black
        if dateOfBirthField.text == "MM/DD/YYYY" {
            dateOfBirthField.text = ""
        }
    }
    
    @IBAction func lastVisitBeginEdit(_ sender: Any) {
        lastVisitField.textColor = .black
        if lastVisitField.text == "MM/DD/YYYY" {
            lastVisitField.text = ""
        }
    }
    
    // FIXME: should just use one action, dateDone(), for both
    @IBAction func dobDone(_ sender: Any) {
        // on Primary Action Triggered
        // isFormComplete() changed to only calling when GeneratePass button is clicked.
    }    
    @IBAction func lastVisitDone(_ sender: Any) {
        // on Primary Action Triggered
        // isFormComplete() changed to only calling when GeneratePass button is clicked.
    }
    
    @IBAction func ssnEntry(_ sender: Any) {
        ssnField.textColor = .black
        if ssnField.text == "NNN-NN-NNNN" {
            ssnField.text = ""
        }
    }
    
    @IBAction func lastVisitEditBegin(_ sender: Any) {
        lastVisitField.textColor = .black
        if lastVisitField.text == "MM/DD/YYYY" {
            lastVisitField.text = ""
        }
    }
    
    func showAlert(alertMessage: String) {
        // create the alert
        let alertController = UIAlertController(title: "Invalid", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        present(alertController, animated: true, completion: nil)
    }
    
    func isFormComplete() -> Bool {
        var isComplete = false
        var missingInvalid = "Missing/Invalid entries:\n"
        
        // FIXME:  don't need this anymore?
        //  let dobValid = isDateValid(dateString: dateOfBirthField.text!)
        
        switch (lastClicked) {

            case subMenuItem.Child.rawValue:
                isComplete = true
                if isDateValid(dateString: dateOfBirthField.text!) == false {
                    missingInvalid = missingInvalid + "Date of Birth\n"
                    isComplete = false
                }
                if isComplete == false {
                    showAlert(alertMessage: missingInvalid)
                }

            case subMenuItem.Classic.rawValue:
                isComplete = true

            case subMenuItem.Senior.rawValue:
                isComplete = true
                if isDateValid(dateString: dateOfBirthField.text!) == false {
                    missingInvalid = missingInvalid + "Date of Birth\n"
                    isComplete = false
                }
                if firstNameField.text == "" {
                    missingInvalid = missingInvalid + "First Name\n"
                    isComplete = false
                }
                if lastNameField.text == "" {
                    missingInvalid = missingInvalid + "Last Name\n"
                    isComplete = false
                }

                if isComplete == false {
                    showAlert(alertMessage: missingInvalid)
                }
            
            case subMenuItem.VIP.rawValue:
                isComplete = true

            case subMenuItem.Season.rawValue:
                isComplete = true
                if isDateValid(dateString: dateOfBirthField.text!) == false {
                    missingInvalid = missingInvalid + "Date of Birth\n"
                    isComplete = false
                }
                if firstNameField.text == "" {
                    missingInvalid = missingInvalid + "First Name\n"
                    isComplete = false
                }
                if lastNameField.text == "" {
                    missingInvalid = missingInvalid + "Last Name\n"
                    isComplete = false
                }
                if streetAddressField.text == "" {
                    missingInvalid = missingInvalid + "Street Address\n"
                    isComplete = false
                }
                if cityField.text == "" {
                    missingInvalid = missingInvalid + "City\n"
                    isComplete = false
                }
                if stateField.text == "" {
                    missingInvalid = missingInvalid + "State\n"
                    isComplete = false
                }
                if isZipCodeValid(zipCode: zipCodeField.text!) == false {
                    missingInvalid = missingInvalid + "Zip Code\n"
                    isComplete = false
                }
                if isComplete == false {
                    showAlert(alertMessage: missingInvalid)
                }

            case subMenuItem.HourlyEmployeeFoodServices.rawValue,
             subMenuItem.HourlyEmployeeRideServices.rawValue,
             subMenuItem.HourlyEmployeeMaintenance.rawValue:
                isComplete = true
                if isDateValid(dateString: dateOfBirthField.text!) == false {
                    missingInvalid = missingInvalid + "Date of Birth\n"
                    isComplete = false
                }
                if isSSNValid(socialSecurityNumber: ssnField.text!) == false {
                    missingInvalid = missingInvalid + "Social Security Number\n"
                    isComplete = false
                }
                if firstNameField.text == "" {
                    missingInvalid = missingInvalid + "First Name\n"
                    isComplete = false
                }
                if lastNameField.text == "" {
                    missingInvalid = missingInvalid + "Last Name\n"
                    isComplete = false
                }
                if streetAddressField.text == "" {
                    missingInvalid = missingInvalid + "Street Address\n"
                    isComplete = false
                }
                if cityField.text == "" {
                    missingInvalid = missingInvalid + "City\n"
                    isComplete = false
                }
                if stateField.text == "" {
                    missingInvalid = missingInvalid + "State\n"
                    isComplete = false
                }
                if isZipCodeValid(zipCode: zipCodeField.text!) == false {
                    missingInvalid = missingInvalid + "Zip Code\n"
                    isComplete = false
                }
                if isComplete == false {
                    showAlert(alertMessage: missingInvalid)
                }

            case mainMenuItem.Manager.rawValue:
                isComplete = true
                if isDateValid(dateString: dateOfBirthField.text!) == false {
                    missingInvalid = missingInvalid + "Date of Birth\n"
                    isComplete = false
                }
                if isSSNValid(socialSecurityNumber: ssnField.text!) == false {
                    missingInvalid = missingInvalid + "Social Security Number\n"
                    isComplete = false
                }
                if firstNameField.text == "" {
                    missingInvalid = missingInvalid + "First Name\n"
                    isComplete = false
                }
                if lastNameField.text == "" {
                    missingInvalid = missingInvalid + "Last Name\n"
                    isComplete = false
                }
                if streetAddressField.text == "" {
                    missingInvalid = missingInvalid + "Street Address\n"
                    isComplete = false
                }
                if cityField.text == "" {
                    missingInvalid = missingInvalid + "City\n"
                    isComplete = false
                }
                if stateField.text == "" {
                    missingInvalid = missingInvalid + "State\n"
                    isComplete = false
                }
                if isZipCodeValid(zipCode: zipCodeField.text!) == false {
                    missingInvalid = missingInvalid + "Zip Code\n"
                    isComplete = false
                }
                if MgmtTierField.text == "" {
                    missingInvalid = missingInvalid + "Management Tier\n"
                    isComplete = false
                }
                if isComplete == false {
                    showAlert(alertMessage: missingInvalid)
                }

        case mainMenuItem.Vendor.rawValue:
            isComplete = true
            if firstNameField.text == "" {
                missingInvalid = missingInvalid + "First Name\n"
                isComplete = false
            }
            if lastNameField.text == "" {
                missingInvalid = missingInvalid + "Last Name\n"
                isComplete = false
            }
            if companyNameField.text == "" {
                missingInvalid = missingInvalid + "Company Name\n"
                isComplete = false
            }
            if isDateValid(dateString: lastVisitField.text!) == false {
                missingInvalid = missingInvalid + "Date of Last Visit\n"
                isComplete = false
            }
            if isComplete == false {
                showAlert(alertMessage: missingInvalid)
            }

            case subMenuItem.ContractEmployee.rawValue:
                break
            
            default: break
        } // switch (lastClicked) {
        
        if isComplete {
            currentEntrant = createEntrantFromFormData()
        }
        return isComplete

    } // isFormComplete()

// (don't have time to add to .plist file dynamically... need to finish this unit.
// if I did: https://stackoverflow.com/questions/41668166/save-data-to-plist-file-in-swift-3)
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToPass") {
            let passViewController = (segue.destination as! PassViewController)
            passViewController.entrant = currentEntrant
            passViewController.delegate = self
        }
    }
*/
    @IBAction func validateDoB(_ sender: Any) {
        if isDateValid(dateString: dateOfBirthField.text!) {
/* changed to only calling when GeneratePass button is clicked.
            isFormComplete()
        } else {
*/
            // FIXME: do an alert here
            showAlert(alertMessage: "\(dateOfBirthField.text!) is an invalid Date value - please correct")
        }
    }
    
    @IBAction func validateSSN(_ sender: Any) {
        if isSSNValid(socialSecurityNumber: ssnField.text!) == false {
            showAlert(alertMessage: "\(ssnField.text!) is an invalid SSN value - please correct")
        }
    }
    
    @IBAction func populateData(_ sender: Any) {
        currentEntrant = populateFormWithRandomPerson(menuSelection: lastClicked)
    }
    
    @IBAction func generateThePass(_ sender: Any) {
        if isFormComplete() {

            let amusementPassViewController = self.storyboard?.instantiateViewController(withIdentifier: "AmusementPassView") as! PassViewController
            
            // self.navigationController?.pushViewController(secondViewController, animated: true)
            
            amusementPassViewController.entrant = currentEntrant
            amusementPassViewController.delegate = self

            self.present(amusementPassViewController, animated: true, completion: nil)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

