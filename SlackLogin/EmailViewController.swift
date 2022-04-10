//
//  EmailViewController.swift
//  SlackLogin
//
//  Created by metanet on 2022/04/10.
//

import UIKit

class EmailViewController: UIViewController {
    
    var bottomMargin: CGFloat?

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var palceholderLabel: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var titleLabelBottomConstraint: NSLayoutConstraint!
    
    @IBAction func movePrevious(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var tokens = [NSObjectProtocol]()
    
    deinit {
        tokens.forEach {
            NotificationCenter.default.removeObserver($0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.alpha = 0.0
        
        titleLabelBottomConstraint.constant = 20
        
        bottomConstraint.constant = bottomMargin ?? 0.0
        
        UIView.performWithoutAnimation {
            self.view.layoutIfNeeded()
        }
        
        var token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = frameValue.cgRectValue
                //self?.bottomConstraint.constant = keyboardFrame.size.height
                self?.bottomConstraint.constant = self?.bottomMargin ?? keyboardFrame.size.height
                UIView.animate(withDuration: 0.3) {
                    self?.view.layoutIfNeeded()
                }
            }
        }
        
        tokens.append(token)
        
        token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil
                                                       , queue: OperationQueue.main
                                                       , using: { [weak self] (noti) in
            self?.bottomConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3) {
                self?.view.layoutIfNeeded()
            }
            
        })
        
        tokens.append(token)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        palceholderLabel.alpha = (textField.text ?? "").count > 0 ? 0.0 : 1.0
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let finalText = NSMutableString(string: textField.text ?? "")
        finalText.replaceCharacters(in: range, with: string)
        
        palceholderLabel.alpha = finalText.length > 0 ? 0.0 : 1.0
        
        UIView.animate(withDuration: 0.3) {
            [weak self] in
            self?.titleLabel.alpha = finalText.length > 0 ? 1.0 : 0.0
            self?.titleLabelBottomConstraint.constant = finalText.length > 0 ? 0 : -20
            self?.view.layoutIfNeeded()
        }
        
        return true
    }
}
