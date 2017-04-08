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
    var rides = [Gate]()
    var vendors = [Gate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            rides = try loadRides(inputFile: "Rides", fileType: "plist")
        } catch let error {
            print(error)
        }

        do {
            vendors = try loadVendors(inputFile: "Vendors", fileType: "plist")
        } catch let error {
            print(error)
        }
        print("Vendors and Rides loaded")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

