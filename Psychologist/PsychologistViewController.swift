//
//  ViewController.swift
//  Psychologist
//
//  Created by Angelo Wong on 3/5/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    
    @IBAction func nothing(sender: UIButton) {
        //why do segues in code? can do if/else for segueing
        performSegueWithIdentifier("nothing", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //NOTE: this code will work for happiness MVC regardless of whether or not it is embedded in a Nav Controller
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let hvc = destination as? HappinessViewController {
            //faceView outlet would not be set
            if let identifier = segue.identifier {
                switch identifier {
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }

}

