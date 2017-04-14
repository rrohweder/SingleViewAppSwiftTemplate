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
    var workers = [Worker]()
    var guests = [Guest]()
    
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
        
        for guest in guests {
            for ride in rides {
                printPaperPass(requestor: guest, gate: ride)
            }
        }
        for worker in workers {
            for ride in rides {
                printPaperPass(requestor: worker, gate: ride)
            }
        }
        for guest in guests {
            for vendor in vendors {
                printPaperPass(requestor: guest, gate: vendor)
            }
        }
        for worker in workers {
            for vendor in vendors {
                printPaperPass(requestor: worker, gate: vendor)
            }
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

