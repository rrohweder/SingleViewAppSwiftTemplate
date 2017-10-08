//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PassViewControllerDelegate {

    // FIXME: can they both be Gate, or are they subclasses? Or is Gate a protocol?
    var rides = [Ride]()
    var vendors = [Vendor]()
    var nonpublics = [NonPublic]()
    var workers = [Worker]()
    var guests = [AnyObject]()
    var vendorFolks = [VendorStaff]()
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
        // so what clearing do I need to do when I return from PassViewController?
        deactivateFormFields(page: self)
        disablePopulateButton()
        disableGeneratePassButton()
        
        // I need to reset the SubMenu, SHOULD do it based upon the (last) mainmenu..
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
        disablePopulateButton()
        disableGeneratePassButton()

        /* These don't change in this exercise, but one might set default main menu button labels. I went with generic ("mainMenu1") in the storyboard, and set them at launch. */
        self.MainMenuButton1.setTitle("Guest", for: .normal)
        self.MainMenuButton2.setTitle("Employee", for: .normal)
        self.MainMenuButton3.setTitle("Manager", for: .normal)
        self.MainMenuButton4.setTitle("Vendor", for: .normal)
        
        // set submenu button labels for default main menu item (Guest)
        activateSubmenuItem(mainMenu: mainMenuItem.Guest, page: self)
       
// move to loadAllData() ?
        do {
            rides = try loadRides(inputFile: "Rides", fileType: "plist") as! [Ride]
        } catch let error {
            print(error)
        }

        do {
            vendors = try loadVendors(inputFile: "Vendors", fileType: "plist") as! [Vendor]
        } catch let error {
            print(error)
        }
        
        do {
            nonpublics = try loadNonPublics(inputFile: "NonPublics", fileType: "plist") as! [NonPublic]
        } catch let error {
            print(error)
        }
        
        do {
            workers = try loadWorkers(inputFile: "Workers", fileType: "plist")
        } catch let error {
            print(error)
        }

        do {
            guests = try loadGuests(inputFile: "Guests", fileType: "plist")
        } catch let error {
            print(error)
        }
        
        do {
            vendorFolks = try loadVendorStaff(inputFile: "VendorStaff", fileType: "plist")
        } catch let error {
            print(error)
        }

// end of "move to loadAllData()"
        
/* move, since this was all just testing
        for guest in guests {
            for ride in rides {
                printPaperPass(requestor: guest as! Entrant, gate: ride)
            }
            for vendor in vendors {
                printPaperPass(requestor: guest as! Entrant, gate: vendor)
            }
            for nonpublic in nonpublics {
                printPaperPass(requestor: guest as! Entrant, gate: nonpublic)
            }
        }
        for worker in workers {
            for ride in rides {
                printPaperPass(requestor: worker, gate: ride)
            }
            for vendor in vendors {
                printPaperPass(requestor: worker, gate: vendor)
            }
            for nonpublic in nonpublics {
                printPaperPass(requestor: worker, gate: nonpublic)
            }
        }
         end of testing stuff to move
*/
        
    } // end of ViewDidLoad()

    
    @IBAction func menuHandler(_ sender: UIButton) {
        disableGeneratePassButton()
        if (sender.tag == mainMenuItem.Guest.rawValue ||
            sender.tag == mainMenuItem.Employee.rawValue) {
            disablePopulateButton()
        }
        lastClicked = sender.tag
        menuLogic(buttonClicked: sender, page: self)
    }

    // use filter to get JUST the records I want
    func getEntrant(entrantType: GuestType) -> Guest? {
        var filteredArray = [AnyObject]()
        
        switch entrantType {
        case GuestType.FreeChild:
            filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.FreeChild }
            break
            
        case GuestType.Classic:
            filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.Classic }
            break
            
        case GuestType.Season:
            filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.Season }
            break
            
        case GuestType.Senior:
            filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.Senior }
            break
            
        case GuestType.VIP:
            filteredArray = guests.filter() { ($0 as! Guest).guestType == GuestType.VIP }
            break
        } // end switch (entrantType)
        
        if filteredArray.count > 0 {
            return (filteredArray[0] as! Guest)
        }
        return nil

    } // end getEntrant(Guest)

    func getEntrant(entrantType: WorkerType) -> Worker? {
        let filteredArray = workers.filter() { $0.workerType == entrantType }
        if filteredArray.count > 0 {
            return filteredArray[0]
        }
        return nil
    } // end getEntrant(worker)

    func getVendorEntrant() -> VendorStaff? {
        if vendorFolks.count > 0 {
            return vendorFolks[0]
        }
        return nil
    } // end getVendorEntrant()

    
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
                // FIXME: create guest record to return
                break
            
            case subMenuItem.Season.rawValue:
                if let season = getEntrant(entrantType: GuestType.Season) as! SeasonPassGuest? {
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
        isFormComplete()
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
        isFormComplete()
    }    
    @IBAction func lastVisitDone(_ sender: Any) {
        // on Primary Action Triggered
        isFormComplete()
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
    
    func isFormComplete() {
        var isComplete = false
        
        let dobValid = isDateValid(dateString: dateOfBirthField.text!)
        
        switch (lastClicked) {

            case subMenuItem.Child.rawValue:
                if dobValid {
                    isComplete = true
                }
            
            case subMenuItem.Classic.rawValue:
                isComplete = true

            case subMenuItem.Senior.rawValue:
                 // firstName, lastName, dob
                if dobValid
                    && isSenior(birthdateString: dateOfBirthField.text!)
                    && firstNameField.text != ""
                    && lastNameField.text != ""
                {
                        isComplete = true
                }
            
            case subMenuItem.VIP.rawValue:
                isComplete = true

            case subMenuItem.Season.rawValue:
                if firstNameField.text != ""
                    && lastNameField.text != ""
                    && streetAddressField.text != ""
                    && cityField.text != ""
                    && stateField.text != ""
                    && isZipCodeValid(zipCode: zipCodeField.text!)
                    && isDateValid(dateString: dateOfBirthField.text!)

                {
                        isComplete = true
                }
            
            case subMenuItem.HourlyEmployeeFoodServices.rawValue,
             subMenuItem.HourlyEmployeeRideServices.rawValue,
             subMenuItem.HourlyEmployeeMaintenance.rawValue:
                if dobValid
                    && isSSNValid(socialSecurityNumber: ssnField.text!)
                    && firstNameField.text != ""
                    && lastNameField.text != ""
                    && streetAddressField.text != ""
                    && cityField.text != ""
                    && stateField.text != ""
                    && isZipCodeValid(zipCode: zipCodeField.text!)
                {
                    isComplete = true
                }

            case mainMenuItem.Manager.rawValue:
                if dobValid
                    && isSSNValid(socialSecurityNumber: ssnField.text!)
                    && firstNameField.text != ""
                    && lastNameField.text != ""
                    && streetAddressField.text != ""
                    && cityField.text != ""
                    && stateField.text != ""
                    && isZipCodeValid(zipCode: zipCodeField.text!)
                    && MgmtTierField.text != ""
                {
                    isComplete = true
                }
            
        case mainMenuItem.Vendor.rawValue:
            if dobValid
                && firstNameField.text != ""
                && lastNameField.text != ""
                && companyNameField.text != ""
                && isDateValid(dateString: lastVisitField.text!)
            {
                isComplete = true
            }

            case subMenuItem.ContractEmployee.rawValue:
                break
            
            default: break
        } // switch (lastClicked) {
        
        if isComplete {
            currentEntrant = createEntrantFromFormData()
            enableGeneratePassButton()
        }
    } // isFormComplete()

// (don't have time to add to .plist file dynamically... need to finish this usit.
// if I did: https://stackoverflow.com/questions/41668166/save-data-to-plist-file-in-swift-3)
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToPass") {
            let passViewController = (segue.destination as! PassViewController)
            passViewController.entrant = currentEntrant
            passViewController.delegate = self
        }
    }
    
    @IBAction func validateDoB(_ sender: Any) {
        if isDateValid(dateString: dateOfBirthField.text!) {
            isFormComplete()
        } else {
            // FIXME: do an alert here
            print("\(dateOfBirthField.text!) is an invalid SSN value - please correct")
        }
    }
    
    @IBAction func validateSSN(_ sender: Any) {
        if isSSNValid(socialSecurityNumber: ssnField.text!) == false {
            // FIXME: do an alert here
            print("\(ssnField.text!) is an invalid SSN value - please correct")
        }
    }
    
    @IBAction func populateData(_ sender: Any) {
        currentEntrant = populateFormWithRandomPerson(menuSelection: lastClicked)
        enableGeneratePassButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

