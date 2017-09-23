//
//  PassViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Roger Rohweder on 9/23/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {

    var entrant: Entrant? = nil
    
    @IBOutlet weak var EntrantName: UILabel!
    @IBOutlet weak var EntrantPassType: UILabel!
    @IBOutlet weak var PermissionsAndBenefits: UILabel!
    
    @IBOutlet weak var EntrantPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if entrant != nil {
            if  entrant is Guest {
                let guest = entrant as! Guest
                switch (guest.guestType) {
                case .Season:
                    let seasonGuest = guest as! SeasonPassGuest
                    EntrantName.text = "\(seasonGuest.firstName) \(seasonGuest.lastName)"
                    EntrantPassType.text = "Season Pass Guest Pass"
                    PermissionsAndBenefits.text = "Unknown"
                    // FIXME: load pic
                    // EntrantPicture.image =
                    
                case .Senior:
                    let seniorGuest = guest as! SeniorGuest
                    EntrantName.text = "\(seniorGuest.firstName) \(seniorGuest.lastName)"
                    EntrantPassType.text = "Senior Guest Pass"
                    PermissionsAndBenefits.text = "Unknown"
                    
                default: break
                }
            }
        }
        

    }
}
