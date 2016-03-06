//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Angelo Wong on 3/6/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import Foundation
import UIKit

//why not use segue directly from HappinessViewController?
//HappinessViewController is just a viewing controller and has nothing to do with diagnosis history
class DiagnosedHappinessViewController : HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    //subclass didSet will happen even when superclass's didSet is done.
    //so now this leeches off superclass happiness whenever it is set.
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    //need this variable to keep track of diagnostic history as every time you
    //click on a diagnosis, the segue creates a BRAND NEW MVC and so diagnostichistory
    //starts out an empty array each time.
    //NSUserDefaults is shared throughout the entire app as opposed to one MVC.
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int] {
        get {
            return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.DefaultsKey)
        }
    }
    
    //storyboard struct, basically to keep track of all the particular strings
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self //delegate allows someone else control how presentation works.
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None //do not adapt on iPhone to a modal (don't substitute the popover)
    }
}