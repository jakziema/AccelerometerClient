//
//  ViewController.swift
//  XYZ2
//
//  Created by Jakub on 23.04.2016.
//  Copyright © 2016 Jakub. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController{
    
    let motionManager = CMMotionManager()
    
    var x : Double = 0
    var y : Double = 0
    var z : Double = 0
    
    var parser: NSXMLParser = NSXMLParser()
    
    @IBAction func sendMessageButton(sender: AnyObject) {
        
        let message = makeXML(calculate(x, y: y, z: z))
        
        
        SocketIOManager.sharedInstance.sendMessage(message)
    
        
        
    }
    
    @IBAction func connectToServerButton(sender: AnyObject) {
        SocketIOManager.sharedInstance.establishConnection()
    }
    
    @IBAction func disconnectButton(sender: AnyObject) {
        SocketIOManager.sharedInstance.closeConnection()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        motionManager.accelerometerUpdateInterval = 1
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
                
                if let accelerometerData = accelerometerData {
                    
                    self.x = accelerometerData.acceleration.x
                    self.y = accelerometerData.acceleration.y
                    self.z = accelerometerData.acceleration.z
                    
                    
                    print("X: \((accelerometerData.acceleration.x))")
                    print("Y: \((accelerometerData.acceleration.y))")
                    print("Z: \((accelerometerData.acceleration.z))")
                }
                
                if(NSError != nil) {
                    print("\(NSError)")
                }
            }
        } else {
            print("Accelerometer not avaiable")
        }
        }
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculate (x: Double, y: Double, z: Double) -> Double {
        
        let value = sqrt((pow(x, Double(2)) + pow(y, Double(2)) + pow(z, Double(2))))
        
        return value
    }
    
    func makeXML(value: Double) -> String {
    
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Dane><Data>\(NSDate())</Data><Modul>\(value)</Modul></Dane>"
    }
 
    
}

extension Double {
    func withDigits(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}


