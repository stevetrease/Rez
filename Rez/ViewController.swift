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
    
    
    var externalWindow: UIWindow!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    
    @objc func screenDidConnect (notification: NSNotification) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        if let screen = notification.object as? UIScreen {
            self.initExternalScreen (externalScreen: screen)
        }
        
        drawScreen()
    }
    
    
    func initExternalScreen (externalScreen: UIScreen) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        self.externalWindow = UIWindow (frame: externalScreen.bounds)
        self.externalWindow.screen = externalScreen
        let view = UIView (frame: self.externalWindow.frame)
        view.backgroundColor = .white
        self.externalWindow.addSubview(view)
        self.externalWindow.isHidden = false
        
        let screenWidth = Int(view.bounds.size.width)
        let screenHeight = Int(view.bounds.size.height)
        
        
        let label = UILabel()
        view.addSubview(label)
         
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.textAlignment = .center
        label.text = "\(screenWidth) x \(screenHeight)"
    }
    
    
    @objc func screenDidDisconnect (notification: NSNotification) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        guard let _ = notification.object as? UIScreen else {
            return
        }
        
        self.externalWindow.isHidden = true
        
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
        
        screenTwoLabel.text = ""
        print ("screens: \(UIScreen.screens.count)")
        for screen in UIScreen.screens {
            var sWidth = Int(screen.bounds.width)
            var sHeight = Int(screen.bounds.height)
            screenTwoLabel.text = screenTwoLabel.text! + "\n" + "\(sWidth) x \(sHeight) = "
            print ("- \(sWidth) x \(sHeight)")
            
            sWidth = Int(screen.currentMode!.size.width)
            sHeight = Int(screen.currentMode!.size.height)
            screenTwoLabel.text = screenTwoLabel.text! + "\(sWidth) x \(sHeight)"
        }
    }
}
