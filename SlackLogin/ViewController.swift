//
//  ViewController.swift
//  SlackLogin
//
//  Created by metanet on 2022/04/09.
//

import UIKit

class ViewController: UIViewController {

    let charSet: CharacterSet = {
        var cs = CharacterSet.lowercaseLetters
        cs.insert(charactersIn: "0123456789")
        cs.insert(charactersIn: "-")
        
        return cs.inverted
    }()
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBOutlet weak var palceholderLabel: UILabel!
    
    @IBOutlet weak var placeholderLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count > 0 {
            guard string.rangeOfCharacter(from: charSet) == nil else {
                return false
            }
        }
        
        return true
        
    }
    
    
}
    



