//
//  PassViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 9/23/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

protocol PassViewControllerDelegate {
    func myVCDidFinish(controller:PassViewController,text:String)
}

class PassViewController: UIViewController {

    var entrant: Entrant? = nil
    var delegate:PassViewControllerDelegate? = nil
    
    @IBOutlet weak var EntrantName: UILabel!
    @IBOutlet weak var EntrantPassType: UILabel!
    @IBOutlet weak var PermissionsAndBenefits: UILabel!
    @IBOutlet weak var EntrantPicture: UIImageView!
    
    @IBOutlet weak var TestResultsDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributesDictionary = [NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)] // wouldn't this be the default (as set in the storyboard)?
            // PermissionsAndBenefits.font]
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary as [String : Any])
        
        EntrantPicture.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        EntrantPicture.layer.borderWidth = 2

        var strings = [String]()
        EntrantPicture.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        EntrantPicture.layer.borderWidth = 2

        // FIXME: move these functions to their own file(s)
        func getMyPermissionsAndBenfits(requestor: Entrant) {
            if requestor is FreeChildGuest {
                strings.append("Unlimited Rides")
            }
            let foodDiscount = discountAvailable(requestor: requestor, product: .Food)
            if (foodDiscount > 0) {
                strings.append("\(foodDiscount)% Food Discount")
            }
            let merchDiscount = discountAvailable(requestor: requestor, product: .Merchandise)
            if (merchDiscount > 0) {
                strings.append("\(merchDiscount)% Merch Discount")
            }
            
            for string: String in strings
            {
                let bulletPoint: String = "\u{2022}"
                let formattedString: String = "\(bulletPoint) \(string)\n"
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
                
                let paragraphStyle = createParagraphAttribute()
                attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
                
                fullAttributedString.append(attributedString)
            }
            
            PermissionsAndBenefits.attributedText = fullAttributedString
        }

    func createParagraphAttribute() ->NSParagraphStyle
    {
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        return paragraphStyle
    }
        
    func setEntrantImage(entrantImageID: Int) {
        if let imageUrlPath = Bundle.main.url(forResource: String(entrantImageID), withExtension: "jpg") {
            let data = NSData(contentsOf: imageUrlPath)
            EntrantPicture.image = UIImage(data: data! as Data)
        } else {  // load NoImage image
            if let imageUrlPath = Bundle.main.url(forResource: "NoEntrantImage", withExtension: "jpg") {
                let data = NSData(contentsOf: imageUrlPath)
                EntrantPicture.image = UIImage(data: data! as Data)
            }
        }
    }
        
    if entrant != nil {
        if  entrant is Guest {
            let guest = entrant as! Guest
            switch (guest.guestType) {
            case .FreeChild:
                let freeChildGuest = guest as! FreeChildGuest
                EntrantName.text = "************"
                EntrantPassType.text = "Child Guest Pass"
                getMyPermissionsAndBenfits(requestor: entrant!)
                setEntrantImage(entrantImageID: freeChildGuest.entrantID)

            case .Classic:
                let classicGuest = guest as! ClassicGuest
                EntrantName.text = "************"
                EntrantPassType.text = "Classic Guest Pass"
                getMyPermissionsAndBenfits(requestor: entrant!)
                setEntrantImage(entrantImageID: classicGuest.entrantID)

            case .VIP:
                let vipGuest = guest as! VIPGuest
                EntrantName.text = "************"
                EntrantPassType.text = "VIP Guest Pass"
                getMyPermissionsAndBenfits(requestor: vipGuest)
                setEntrantImage(entrantImageID: vipGuest.entrantID)
                
            case .Season:
                let seasonGuest = guest as! SeasonPassGuest
                EntrantName.text = "\(seasonGuest.firstName) \(seasonGuest.lastName)"
                EntrantPassType.text = "Season Pass Guest Pass"
                getMyPermissionsAndBenfits(requestor: seasonGuest)
                setEntrantImage(entrantImageID: seasonGuest.entrantID)
                
            case .Senior:
                let seniorGuest = guest as! SeniorGuest
                EntrantName.text = "\(seniorGuest.firstName) \(seniorGuest.lastName)"
                EntrantPassType.text = "Senior Guest Pass"
                getMyPermissionsAndBenfits(requestor: seniorGuest)
                setEntrantImage(entrantImageID: seniorGuest.entrantID)
                
            }
            
        } else if entrant is Worker {
            let worker = entrant as! Worker
            switch (worker.workerType) {
            case .HourlyFoodServices, .HourlyMaintenance, .HourlyRideServices:
                EntrantName.text = "\(worker.firstName) \(worker.lastName)"
                switch (worker.workerType) {
                case .HourlyFoodServices: EntrantPassType.text = "Food Services Worker Pass"
                case .HourlyMaintenance: EntrantPassType.text = "Maintenance Worker Pass"
                case .HourlyRideServices: EntrantPassType.text = "Ride Services Worker Pass"
                default: break
                }
                getMyPermissionsAndBenfits(requestor: worker)
                setEntrantImage(entrantImageID: worker.entrantID)

            case .Manager:
                let manager = worker as! Manager // FIXME: cannot cast worker to mgr? why not?
                EntrantName.text = "\(manager.firstName) \(manager.lastName)"
                EntrantPassType.text = "Manager Guest Pass"
                getMyPermissionsAndBenfits(requestor: entrant!)
                setEntrantImage(entrantImageID: manager.entrantID)
                
            case .Contract:
                let contractor = worker as! Contract
                EntrantName.text = "\(contractor.firstName) \(contractor.lastName)"
                EntrantPassType.text = "Contractor Guest Pass"
                getMyPermissionsAndBenfits(requestor: entrant!)
                setEntrantImage(entrantImageID: contractor.entrantID)

            case .VendorStaff:
                let vendorFolk = entrant as! VendorStaff
                EntrantName.text = "\(vendorFolk.firstName) \(vendorFolk.lastName)"
                EntrantPassType.text = "Vendor Staff Pass"
                getMyPermissionsAndBenfits(requestor: entrant!)
                setEntrantImage(entrantImageID: vendorFolk.entrantID)
                
            }
        }
    }
}
    
    @IBAction func RideAccessCheck(_ sender: Any) {
        let ride = Ride(gateID: 1, gateType: GateType.RideRides, gateName: "Rides", ageRestricted: false)
        let restrictedRide = Ride(gateID: 1, gateType: GateType.RideRides, gateName: "Rides", ageRestricted: true)

        var resultsText = "\nAccess to Rides "
        if accessPermitted(requestor: entrant!, gate: restrictedRide) {
            resultsText = resultsText + "permitted\n"
        } else {
            resultsText = resultsText + "not permitted\n"
        }
        TestResultsDisplay.text = resultsText
    }

    @IBAction func AreaAccessCheck(_ sender: Any) {
        var resultsText = "\n"

        let rideControl = NonPublic(gateID: 1, gateType: .RideControl, gateName: "Ride Control Areas")
        let amusementAreas = NonPublic(gateID: 1, gateType: .Amusement, gateName: "Amusement Areas")
        let kitchen = NonPublic(gateID: 1, gateType: .Kitchen, gateName: "Kitchen Areas")
        let maintenance = NonPublic(gateID: 1, gateType: .Maintenance, gateName: "Maintenance Areas")
        let office = NonPublic(gateID: 1, gateType: .Office, gateName: "Office Areas")

        resultsText = resultsText + "Access to Amusement Areas "
        if accessPermitted(requestor: entrant!, gate: amusementAreas) {
            resultsText = resultsText + "permitted\n"
        } else {
            resultsText = resultsText + "not permitted\n"
        }

        resultsText = resultsText + "Access to Kitchen Areas "
        if accessPermitted(requestor: entrant!, gate: kitchen) {
            resultsText = resultsText + "permitted\n"
        } else {
            resultsText = resultsText + "not permitted\n"
        }
        
        resultsText = resultsText + "Access to Maintenance Areas "
        if accessPermitted(requestor: entrant!, gate: maintenance) {
            resultsText = resultsText + "permitted\n"
        } else {
            resultsText = resultsText + "not permitted\n"
        }

        resultsText = resultsText + "Access to Office Areas "
        if accessPermitted(requestor: entrant!, gate: office) {
            resultsText = resultsText + "permitted\n"
        } else {
            resultsText = resultsText + "not permitted\n"
        }
        TestResultsDisplay.text = resultsText
    }
    
    @IBAction func DiscountAccessCheck(_ sender: Any) {
        var resultsText = "\n"
        let foodDiscount = discountAvailable(requestor: entrant!, product: .Food)
        if (foodDiscount > 0) {
            resultsText = resultsText + "\(foodDiscount)% Food Discount\n"
        } else {
            resultsText = "No Food Discount\n"
        }
        let merchDiscount = discountAvailable(requestor: entrant!, product: .Merchandise)
        if (merchDiscount > 0) {
            resultsText = resultsText + "\(merchDiscount)% Merch Discount\n"
        } else {
            resultsText = resultsText + "No Merch Discount\n"
        }
        TestResultsDisplay.text = resultsText
    }
    
    @IBAction func CreateNewPass(_ sender: Any) {
        if (delegate != nil) {
            delegate!.myVCDidFinish(controller: self, text: "done")
            self.dismiss(animated: true)
        }
    }
}
