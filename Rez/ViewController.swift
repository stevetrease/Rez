//
//  ViewController.swift
//  Rez
//
//  Created by Steve on 10/11/2018.
//  Copyright © 2018 Steve. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resLabel: UILabel!
    @IBOutlet weak var orientationLabel: UILabel!
    @IBOutlet weak var screenTwoLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        // Do any additional setup after loading the view, typically from a nib.
        
        screenTwoLabel.isHidden = true
        drawScreen()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver (self, selector: #selector(ViewController.screenDidConnect), name: UIScreen.didConnectNotification, object: nil)
        notificationCenter.addObserver (self, selector: #selector(ViewController.screenDidDisconnect), name: UIScreen.didDisconnectNotification, object: nil)
        notificationCenter.addObserver (self, selector: #selector(ViewController.drawScreen), name: UIScreen.modeDidChangeNotification, object: nil)
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        drawScreen()
    }
    
    
    @objc func screenDidConnect () {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        let extScreen = UIScreen.screens.last
        print (extScreen?.bounds.width)
        print (extScreen?.bounds.height)
        print (extScreen?.currentMode!.size.height)
        print (extScreen?.currentMode!.size.height)
        drawScreen()
    }
    
    @objc func screenDidDisconnect () {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        drawScreen()
    }
    
    
    @objc func drawScreen () {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        let screen = UIScreen.main
        
        var screenWidth = Int(screen.bounds.width)
        var screenHeight = Int(screen.bounds.height)
        let screenScale = Int(screen.scale)
        resLabel.text = "\(screenWidth) x \(screenHeight) (\(screenScale)x)"
        screenWidth = Int(screen.currentMode!.size.width)
        screenHeight = Int(screen.currentMode!.size.height)
        resLabel.text = resLabel.text! + " = " + "\(screenWidth) x \(screenHeight)"
        
        if UIDevice.current.orientation.isLandscape {
            orientationLabel.text = "Landscape"
        } else {
            orientationLabel.text = "Portrait"
        }
        

        if UIScreen.screens.count == 1 {
            screenTwoLabel.isHidden = true
        } else {
            screenTwoLabel.isHidden = false
            
            screenTwoLabel.text = ""
            print ("screens: \(UIScreen.screens.count)")
            for screen in UIScreen.screens {
                var sWidth = Int(screen.bounds.width)
                var sHeight = Int(screen.bounds.height)
                screenTwoLabel.text = screenTwoLabel.text! + "\n" + "\(sWidth) x \(sHeight) = "
                print ("- \(sWidth) x \(sHeight)")
                
                sWidth = Int(screen.currentMode!.size.width)
                sHeight = Int(screen.currentMode!.size.height)
                screenTwoLabel.text = screenTwoLabel.text! + "\(sWidth) x \(sHeight)" + "\n"
            }
        }
        
    }
    
}
