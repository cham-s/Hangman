//
//  ViewController.swift
//  Hangman
//
//  Created by chams on 27/11/2018.
//  Copyright © 2018 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var letterTextfiled: UITextField!
    @IBOutlet weak var wrongsLabel: UILabel!
    var wrongs = 0 {
        didSet {
            wrongsLabel.text = "Wrongs: \(wrongs)/7"
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

