//
//  ViewController.swift
//  lpsgame
//
//  
//  Copyright © 2019 Juanjo&Juanjo. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.sendSubviewToBack(UIImageView (image: UIImage(named: "fondo")))
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ciudad")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

