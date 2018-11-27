//
//  ViewController.swift
//  Hangman
//
//  Created by chams on 27/11/2018.
//  Copyright © 2018 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var letterTextfiled: UITextField!
    @IBOutlet weak var wrongsLabel: UILabel!
    var wrongs = 0 {
        didSet {
            wrongsLabel.text = "Wrongs: \(wrongs)/7"
        }
    }
    
    var words = [String]()
    var usedLetter = [Character]()
    var currentWord = [Character]()
    var usedWord = [String]()
    
    override func viewDidLoad() {
        letterTextfiled.delegate = self
        super.viewDidLoad()
        loadWordsDefault()
        setNewWord()
    }
    
    // Mark: TexField Delegate Method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        textField.text = ""
        return true
    }
    
    func setNewWord() {
        let index = Int.random(in: 0..<words.count)
        currentWord = Array(words.remove(at: index))
        let blanks = String(repeating: "_ ", count: currentWord.count)
        wordLabel.text = blanks
    }
    
    func loadWordsDefault() {
        if let wordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let contents = try? String(contentsOfFile: wordsPath) {
                words = contents.components(separatedBy: "\n")
            } else {
                words = ["hello", "world"]
            }
        } else {
            words = ["hello", "world"]
        }
        words.shuffle()
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
    }
}

