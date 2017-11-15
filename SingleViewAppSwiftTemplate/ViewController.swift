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
    var currentEntrant: Entrant? = nil
    
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
        currentEntrant = nil
        deactivateFormFields(page: self)
        disablePopulateButton()
        disableGeneratePassButton()
        
        if (lastClicked <= 15) {
            activateSubmenuItem(mainMenu: mainMenuItem.guest, page: self)
        } else {
            activateSubmenuItem(mainMenu: mainMenuItem.employee, page: self)
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
        activateSubmenuItem(mainMenu: mainMenuItem.guest, page: self)

        loadAllData()
        
        // a quick view entrants access in the Xcode console
        runRegressionTests()
        
    } // end of ViewDidLoad()

    
    @IBAction func menuHandler(_ sender: UIButton) {
        disableGeneratePassButton()
        if (sender.tag == mainMenuItem.guest.rawValue ||
            sender.tag == mainMenuItem.employee.rawValue) {
            disablePopulateButton()
        } else {
            enablePopulateButton()
            enableGeneratePassButton()
        }
        lastClicked = sender.tag
        menuLogic(buttonClicked: sender, page: self)
    }

    func populateFormWithRandomPerson(menuSelection: Int) -> Entrant {
        switch (menuSelection) {
            case subMenuItem.child.rawValue:
                if let freeChild = getEntrant(entrantType: GuestType.freeChild) as! FreeChildGuests? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: freeChild.dateOfBirth)
                    return freeChild as Entrant
                }
            
            case subMenuItem.classic.rawValue:
                if let classic = getEntrant(entrantType: GuestType.classic) {
                    return classic as Entrant
                }
            
            case subMenuItem.senior.rawValue:
                if let senior = getEntrant(entrantType: GuestType.senior) as! SeniorGuests? {
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: senior.dateOfBirth)
                    firstNameField.text = senior.firstName
                    lastNameField.text = senior.lastName
                    return senior as Entrant
                }

            
            case subMenuItem.vIP.rawValue:
                if let vip = getEntrant(entrantType: GuestType.vIP) {
                    return vip as Entrant
                }
            
            case subMenuItem.season.rawValue:
                if let season = getEntrant(entrantType: GuestType.season) as! SeasonPassGuests? {
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

            case subMenuItem.hourlyEmployeeFoodServices.rawValue,
                 subMenuItem.hourlyEmployeeRideServices.rawValue,
                 subMenuItem.hourlyEmployeeMaintenance.rawValue:
            
                var wt = WorkerType.hourlyFoodServices
                
                switch (menuSelection) {
                    case subMenuItem.hourlyEmployeeFoodServices.rawValue: wt = WorkerType.hourlyFoodServices
                    case subMenuItem.hourlyEmployeeRideServices.rawValue: wt = WorkerType.hourlyRideServices
                    case subMenuItem.hourlyEmployeeMaintenance.rawValue: wt = WorkerType.hourlyMaintenance

                    default:
                        print("Unexpected menu selection \(menuSelection)")
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

            case mainMenuItem.manager.rawValue:
                
                if let mgr = getEntrant(entrantType: WorkerType.manager) as! Managers? {
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
            
            case subMenuItem.contractEmployee.rawValue:
                
                if let contractor = getEntrant(entrantType: WorkerType.contract) as! Contractors? {
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

            case mainMenuItem.vendor.rawValue:

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

            case subMenuItem.child.rawValue:
                entrant = FreeChildGuests(entrantID: 1, guestType: .freeChild, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!)
            
            case subMenuItem.classic.rawValue:
                entrant = Guests(entrantID: 2, guestType: .classic)
            
            case subMenuItem.senior.rawValue:
                entrant = SeniorGuests(entrantID: 3, guestType: .senior, firstName: firstNameField.text!, lastName: lastNameField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!)
            
            case subMenuItem.vIP.rawValue:
                entrant = Guests(entrantID: 2, guestType: .vIP)

            case subMenuItem.season.rawValue:
                entrant = SeasonPassGuests(entrantID: 5, guestType: .season, firstName: firstNameField.text!, lastName: lastNameField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!, streetAddress: streetAddressField.text!, city: cityField.text!, state: stateField.text!, zipCode: zipCodeField.text!)
            
            case subMenuItem.hourlyEmployeeFoodServices.rawValue,
                 subMenuItem.hourlyEmployeeRideServices.rawValue,
                 subMenuItem.hourlyEmployeeMaintenance.rawValue:
                switch (lastClicked) {
                    case subMenuItem.hourlyEmployeeFoodServices.rawValue: wt = WorkerType.hourlyFoodServices
                    case subMenuItem.hourlyEmployeeRideServices.rawValue: wt = WorkerType.hourlyRideServices
                    case subMenuItem.hourlyEmployeeMaintenance.rawValue: wt = WorkerType.hourlyMaintenance
                    default: wt = WorkerType.hourlyFoodServices // since even though it can't get here, the compiler complains that it wasn't set on the next line...
                }
                entrant = Workers(entrantID: 6, workerType: wt, firstName: firstNameField.text!, lastName: lastNameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!, state: stateField.text!, zipCode: zipCodeField.text!, socialSecurityNumber: ssnField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!)
            
            case mainMenuItem.manager.rawValue:
                entrant = Managers(entrantID: 6, workerType: .manager, firstName: firstNameField.text!, lastName: lastNameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!, state: stateField.text!, zipCode: zipCodeField.text!, socialSecurityNumber: ssnField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!, mgmtTier: MgmtTierField.text!)
            
            case mainMenuItem.vendor.rawValue:
                entrant = VendorStaff(entrantID: 6, workerType: .vendorStaff, firstName: firstNameField.text!, lastName: lastNameField.text!, dateOfBirth: dateFormatter.date(from: dateOfBirthField.text!)!, companyName: companyNameField.text!, dateOfLastVisit: dateFormatter.date(from: lastVisitField.text!)!)

                default:
                    entrant = Guests(entrantID: 99, guestType: .classic)
        }
        
        return entrant!
    }
    
    @IBAction func genericFieldExit(_ sender: Any) {
        // on Editing Did End (not always...)
        // isFormComplete() changed to only calling when GeneratePass button is clicked.
    }
    
    // clear the sample text
    @IBAction func dobEntry(_ sender: Any) {
        dateOfBirthField.textColor = .black
        if dateOfBirthField.text == "MM/DD/YYYY" {
            dateOfBirthField.text = ""
        }
    }
    
    // clear the sample text
    @IBAction func lastVisitBeginEdit(_ sender: Any) {
        lastVisitField.textColor = .black
        if lastVisitField.text == "MM/DD/YYYY" {
            lastVisitField.text = ""
        }
    }
    
    // validate dateOfBithField when user exits
    @IBAction func dobDone(_ sender: Any) {
        // on Primary Action Triggered
        if isDateValid(dateString: dateOfBirthField.text!) == false {
            showAlert(alertTitle: "Missing/Invalid Data", alertMessage: "\(dateOfBirthField.text!) is an invalid Date value - please correct")
        }
    }
    
    // validate lastVisit (date) when user exits
    @IBAction func lastVisitDone(_ sender: Any) {
        // on Primary Action Triggered
        if isDateValid(dateString: lastVisitField.text!) == false {
            showAlert(alertTitle: "Missing/Invalid Data", alertMessage: "\(lastVisitField.text!) is an invalid Date value - please correct")
        }
    }
    
    // clear the sample text
    @IBAction func ssnEntry(_ sender: Any) {
        ssnField.textColor = .black
        if ssnField.text == "NNN-NN-NNNN" {
            ssnField.text = ""
        }
    }
    
    func showAlert(alertTitle: String, alertMessage: String) {
        // create the alert
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        present(alertController, animated: true, completion: nil)
    }
    
    func isFormComplete() -> Bool {
        var isComplete = false
        var missingInvalid = "Missing/Invalid entries:\n"
        
        if currentEntrant != nil { // then populated by getEntrant
            return true
        }
        
        switch (lastClicked) {

            case subMenuItem.child.rawValue:
                isComplete = true
                if isDateValid(dateString: dateOfBirthField.text!) == false {
                    missingInvalid = missingInvalid + "Date of Birth\n"
                    isComplete = false
                }
                if isComplete == false {
                    showAlert(alertTitle: "Missing/Invalid Data", alertMessage: missingInvalid)
                }

            case subMenuItem.classic.rawValue:
                isComplete = true

            case subMenuItem.senior.rawValue:
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
                    showAlert(alertTitle: "Missing/Invalid Data", alertMessage: missingInvalid)
                }
            
            case subMenuItem.vIP.rawValue:
                isComplete = true

            case subMenuItem.season.rawValue:
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
                    showAlert(alertTitle: "Missing/Invalid Data", alertMessage: missingInvalid)
                }

            case subMenuItem.hourlyEmployeeFoodServices.rawValue,
             subMenuItem.hourlyEmployeeRideServices.rawValue,
             subMenuItem.hourlyEmployeeMaintenance.rawValue:
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
                    showAlert(alertTitle: "Missing/Invalid Data", alertMessage: missingInvalid)
                }

            case mainMenuItem.manager.rawValue:
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
                    showAlert(alertTitle: "Missing/Invalid Data", alertMessage: missingInvalid)
                }

        case mainMenuItem.vendor.rawValue:
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
                showAlert(alertTitle: "Missing/Invalid Data", alertMessage: missingInvalid)
            }

            case subMenuItem.contractEmployee.rawValue:
                break
            
            default: break
        } // switch (lastClicked) {

        if isComplete {
            currentEntrant = createEntrantFromFormData()
        }
        return isComplete

    } // isFormComplete()

// could add data entered in the form to .plist file (new record), but that is
// not a requirement for this unit.
// if I did: https://stackoverflow.com/questions/41668166/save-data-to-plist-file-in-swift-3)
    
/* I had linked the GeneratePass button to this seque, but needed to do other work before
     the seque, so am (attempting?) the seque in code in generateThePass() (below) instead.
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToPass") {
            let passViewController = (segue.destination as! PassViewController)
            passViewController.entrant = currentEntrant
            passViewController.delegate = self
        }
    }
*/
    
    @IBAction func validateDoB(_ sender: Any) {
        if isDateValid(dateString: dateOfBirthField.text!) == false {
            showAlert(alertTitle: "Missing/Invalid Data", alertMessage: "\(dateOfBirthField.text!) is an invalid Date value - please correct")
        }
    }
    
    @IBAction func validateSSN(_ sender: Any) {
        if isSSNValid(socialSecurityNumber: ssnField.text!) == false {
            showAlert(alertTitle: "Missing/Invalid Data", alertMessage: "\(ssnField.text!) is an invalid SSN value - please correct")
        }
    }
    
    @IBAction func populateData(_ sender: Any) {
        currentEntrant = populateFormWithRandomPerson(menuSelection: lastClicked)
        if currentEntrant == nil  {
            showAlert(alertTitle: "Missing Data", alertMessage: "Could not find record for that entrant type")
        }
    }
    
    @IBAction func generateThePass(_ sender: Any) {
        if isFormComplete() {
            let amusementPassViewController = self.storyboard?.instantiateViewController(withIdentifier: "AmusementPassView") as! PassViewController
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

