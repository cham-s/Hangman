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
    let maxWrong = 7
    var wrongs = 0 {
        didSet {
            wrongsLabel.text = "Wrongs: \(wrongs)/\(maxWrong)"
            if wrongs == maxWrong {
                presentAlert(title: "Game Over", message: "Try again", actionTitle: "Play Again")
                setNewWord()
            }
        }
    }
    
    var words = [String]()
    var usedLetter = [Character]()
    var currentWord = [Character]()
    
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
        usedLetter.removeAll()
        currentWord.removeAll()
        let index = Int.random(in: 0..<words.count)
        currentWord = Array(words.remove(at: index))
        let blanks = String(repeating: "_", count: currentWord.count)
        wordLabel.text = blanks
        print(currentWord)
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
    
    func replace(letter: Character) {
        var arrayWordLabel = Array(wordLabel.text!)
        let newWord: String
        let indices = currentWord.enumerated().compactMap {
            $0.element == letter ? $0.offset : nil
        }
        for i in indices {
            arrayWordLabel[i] = letter
        }
        newWord = String(arrayWordLabel)
        
        if newWord.contains("_") {
            wordLabel.text = newWord
        } else {
            presentAlert(title: "Great Job!",
                         message: "\(newWord)! You guessed right Let's play with an other word",
                         actionTitle: "OK")
            setNewWord()
        }
    }
    
    func presentAlert(title: String, message: String, actionTitle: String)  {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if let text = letterTextfiled.text, let letter = text.first {
            if currentWord.contains(letter) {
                if !usedLetter.contains(letter) {
                    replace(letter: letter)
                    usedLetter.append(letter)
                } else {
                    presentAlert(title: "Letter Already Used",
                                 message: "Please pick another letter",
                                 actionTitle: "Retry")
                }
            } else {
                presentAlert(title: "Wrong",
                             message: "Please try again",
                             actionTitle: "Retry")
                wrongs += 1
            }
        }
    }
}
