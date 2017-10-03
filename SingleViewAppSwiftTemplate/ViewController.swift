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
// end of "move to loadAllData()"
        
// move, since this was all just testing
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
    }
// end of testing stuff to move

    
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
        }
        
        if filteredArray.count > 0 {
            return (filteredArray[0] as! Guest)
        }
        return nil

    }


    func getEntrant(entrantType: WorkerType) -> Worker? {
        
        let filteredArray = workers.filter() { $0.workerType == entrantType }
        
        if filteredArray.count > 0 {
            return filteredArray[0]
        }
        return nil
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
                
                if let employee = getEntrant(entrantType: WorkerType.Manager) {
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
                    // FIXME: Management Tier (Shift Mgr., General Mgr., Senior Mgr.)
                    return employee as Entrant
                }
                break
            
            case mainMenuItem.Vendor.rawValue:

                if let employee = getEntrant(entrantType: WorkerType.VendorStaff) {

// FIXME: what info do I need for VendorStaff?
                    dateOfBirthField.textColor = .black
                    dateOfBirthField.text = dateFormatter.string(from: employee.dateOfBirth)
                    firstNameField.text = employee.firstName
                    lastNameField.text = employee.lastName
// FIXME: not in Worker type.. do I need this? companyNameField = employee.company
                    return employee as Entrant
                }
                break
            
        default:
            print("invalid menu / submenu selection: tag=\(menuSelection)")
        }
        return currentEntrant!
    }
    
    func createEntrantFromFormData() -> AnyObject {
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
/*
        case subMenuItem.ContractEmployee.rawValue:
            break
 */
            
        default: entrant = Guest(entrantID: 99, guestType: .Classic)
        }
        
        return entrant! as AnyObject
    }
    
    @IBAction func genericFieldExit(_ sender: Any) {
        isFormComplete()
    }
    
    
    @IBAction func dobEntry(_ sender: Any) {
        // clear and set text to black
        dateOfBirthField.textColor = .black
        if dateOfBirthField.text == "MM/DD/YYYY" {
            dateOfBirthField.text = ""
        }
    }
    
    func isFormComplete() {
        var isComplete = false
        
        let dobValid = isDobValid(birthdateString: dateOfBirthField.text!)
        
        switch (lastClicked) {

            case subMenuItem.Child.rawValue:
                // FIXME: should just pass string, and let validator (try to) make it into date type to validate.
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
                    && lastNameField.text != "" {
                        isComplete = true
                }
            
            case subMenuItem.VIP.rawValue:
                isComplete = true

            case subMenuItem.Season.rawValue:
                break
            
            case subMenuItem.HourlyEmployeeFoodServices.rawValue,
             subMenuItem.HourlyEmployeeRideServices.rawValue,
             subMenuItem.HourlyEmployeeMaintenance.rawValue:
                break
            
            case subMenuItem.ContractEmployee.rawValue:
                break
            
            default: break
        }
        
        if isComplete {
            currentEntrant = createEntrantFromFormData() as! Entrant  // which will create object and
            enableGeneratePassButton()
        }
    }

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
        if isDobValid(birthdateString: dateOfBirthField.text!) {
            isFormComplete()
        } else {
            // FIXME: do an alert here
            print("\(ssnField.text!) is an invalid SSN value - please correct")
        }
    }
    
    @IBAction func validateSSN(_ sender: Any) {
        if validSSN(socialSecurityNumber: ssnField.text!) == false {
            // FIXME: do an alert here
            print("\(ssnField.text!) is an invalid SSN value - please correct")
        }
    }
    
    @IBAction func populateData(_ sender: Any) {
        currentEntrant = populateFormWithRandomPerson(menuSelection: lastClicked)
        enableGeneratePassButton()
    }
    
    @IBAction func generatePass(_ sender: Any) {
            print("who called this? (want to delete it)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

