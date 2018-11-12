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
        
        guard let screen = notification.object as? UIScreen else {
            return
        }

        // let extScreen = UIScreen.screens.last
        let externalScreen = screen
        print ("xs = \(externalScreen.bounds.width) x \(externalScreen.bounds.height) = \(externalScreen.currentMode!.size.width) x \(externalScreen.currentMode!.size.height)")
        
        let vc = ExternalViewController()
        
        let externalWindow = UIWindow(frame: externalScreen.bounds)
        externalWindow.screen = externalScreen
        externalWindow.rootViewController = vc
        externalWindow.isHidden = false
        
        // let view1 = UIView (frame: CGRect (x:10, y:10, width:50, height:50))
        // view1.backgroundColor = .red
        
        // vc.view = view1
        // vc.view.backgroundColor = .gray
        
        drawScreen()
    }
    
    
    @objc func screenDidDisconnect (notification: NSNotification) {
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
        
        guard let _ = notification.object as? UIScreen else {
            return
        }
        
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



class ExternalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print (NSURL (fileURLWithPath: "\(#file)").lastPathComponent!, "\(#function)")
    }
}

