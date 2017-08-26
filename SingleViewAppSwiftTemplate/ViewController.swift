//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // FIXME: can they both be Gate, or are they subclasses? Or is Gate a protocol?
    var rides = [Ride]()
    var vendors = [Vendor]()
    var nonpublics = [NonPublic]()
    var workers = [Worker]()
    var guests = [AnyObject]()
    
    // current problem: sender is the clicked button, but guestButton and employeeButton are nil?
    // the buttons have been 'painted', and are active, so why would the @IBOutlet be nil?

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
    
    
    override func viewDidLoad() {
        var childGuest: FreeChildGuest
        super.viewDidLoad() 

        // disable form fields, gray labels until a submenu item is selected
        deactivateFormFields(page: self)
        
        // set default main menu button labels:
        self.MainMenuButton1.setTitle("Guest", for: .normal)
        self.MainMenuButton1.setTitleColor(.white, for: .normal)
        
        self.MainMenuButton2.setTitle("Employee", for: .normal)
        self.MainMenuButton2.setTitleColor(.gray, for: .normal)
        
        self.MainMenuButton3.setTitle("Manager", for: .normal)
        self.MainMenuButton3.setTitleColor(.gray, for: .normal)
        
        self.MainMenuButton4.setTitle("Vendor", for: .normal)
        self.MainMenuButton4.setTitleColor(.gray, for: .normal)
        
        // set submenu button labels for default main menu item (Guest)
        activateSubmenuItem(mainMenu: mainMenuItem.Guest, page: self)

       
// move to loadAllData()
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
        
        
        menuLogic(buttonClicked: sender, page: self)
        
        
/*
         
    can I "see" the buttons from MenuLogic (or anywhere outside of the ViewController object)? YES
         
    if TopMenuItem clicked:
         - highlight it (white instead of gray)
         - re-draw submenu
         - highlight first submenu item, disable others
         - enable / disable fields in form based on submenu item selected.
         
     if submenu item clicked:
         - highlight first submenu item, disable others
         - enable / disable fields in form based on submenu item selected.

         let selectedTopMenu = X,
         let selectedSubMenu = Y
         
*/
        
 /*
        switch (sender.tag) {

        case mainMenuItem.Guest.rawValue:
            print("Guest button, control state = \(guestButton.state), isHighlighted = \(guestButton.isHighlighted)")
            menuLogic()
 
        default:
            print("button, tag = \(sender.tag), Title = \(sender.titleLabel?.text ?? "unknown") control state = \(sender.state), isHighlighted = \(sender.isHighlighted)")

        }
 */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

