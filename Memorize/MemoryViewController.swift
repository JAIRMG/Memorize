//
//  MemoryViewController.swift
//  Memorize
//
//  Created by Jair Moreno Gaspar on 4/12/20.
//  Copyright © 2020 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var item: MemoryItem!
    var blankCount = 0
    
    let visibleTex: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Georgia", size: 28)!, .foregroundColor: UIColor.black]
    
    let invisibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        assert(item != nil, "You must provide a memory item before trying to show this view controller")
        textView.attributedText = showText(for: item)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
        textView.addGestureRecognizer(tapRecognizer)
    }

    func showText(for memoryItem: MemoryItem) -> NSAttributedString {
        let words = memoryItem.text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        let space = NSAttributedString(string: " ", attributes: visibleTex)
        
        for (index, word) in words.enumerated() {
            if index < blankCount {
                let attributedWord = NSAttributedString(string: word, attributes: visibleTex)
                output.append(attributedWord)
            } else {
                
                var strippedWord = word
                var punctuation: String?
                
                if ".,".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
                output.append(attributedWord)
                
                if let symbol = punctuation {
                    let attributtedPunctuation = NSAttributedString(string: symbol, attributes: visibleTex)
                    output.append(attributtedPunctuation)
                }
                
            }
            output.append(space)
        }
        
        return output
        
    }
    
    @objc func wordsTapped() {
        blankCount += 1
        textView.attributedText = showText(for: item)
    }

}
