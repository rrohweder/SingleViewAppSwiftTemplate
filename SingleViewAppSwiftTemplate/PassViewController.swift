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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributesDictionary = [NSFontAttributeName : PermissionsAndBenefits.font]
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary as [String : Any])
        
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
                    
                default: break
                }
            } else if entrant is VendorStaff {
                let vendorFolk = entrant as! VendorStaff
                EntrantName.text = "\(vendorFolk.firstName) \(vendorFolk.lastName)"
                EntrantPassType.text = "Vendor Staff Pass"
                getMyPermissionsAndBenfits(requestor: entrant!)
                setEntrantImage(entrantImageID: vendorFolk.entrantID)
            }
        }
        

    }
    
// FIXME: need a different hook to falling back to main screen
    @IBAction func RideAccessAsExit(_ sender: Any) {
        if (delegate != nil) {
            delegate!.myVCDidFinish(controller: self, text: "done")
            self.dismiss(animated: true)
        }

    }
    
}
