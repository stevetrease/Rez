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
    @IBOutlet weak var sCountLabel: UILabel!
    @IBOutlet weak var orientationLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        // Do any additional setup after loading the view, typically from a nib.
        
        drawScreen()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver (self, selector: #selector(ViewController.drawScreen), name: UIScreen.didConnectNotification, object: nil)
        notificationCenter.addObserver (self, selector: #selector(ViewController.drawScreen), name: UIScreen.didDisconnectNotification, object: nil)
        notificationCenter.addObserver (self, selector: #selector(ViewController.drawScreen), name: UIScreen.modeDidChangeNotification, object: nil)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        drawScreen()
    }
    
    
    @objc func drawScreen () {
        let screenSize = UIScreen.main.bounds
        let screenWidth = Int(screenSize.width)
        let screenHeight = Int(screenSize.height)
        let screenScale = Int(UIScreen.main.scale)
        let screenCount = UIScreen.screens.count
        
        let orientationString: String
        if UIDevice.current.orientation.isLandscape {
            orientationString = "Landscape"
        } else {
            orientationString = "Portrait"
        }
        
        resLabel.text = "\(screenWidth) x \(screenHeight) (\(screenScale))"
        sCountLabel.text = "\(screenCount)"
        orientationLabel.text = orientationString
    }

}

