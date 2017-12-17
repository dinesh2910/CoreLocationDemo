//
//  TitlesViewController.swift
//  CoreLocationDemo
//
//  Created by dinesh danda on 10/3/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit

protocol PassTitles {
    func setTitles(title: String, subTitle: String)
}

class TitlesViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var subtitleTextField: UITextField!
    
    var delegate: PassTitles?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func setAnnotation(_ sender: UIButton) {
        
        guard let aTitle = titleTextField.text, titleTextField.text != "", let aSubtitle = subtitleTextField.text, subtitleTextField.text != "" else {
            print("Title and Subtitle are required")
            return
        }
        
        delegate?.setTitles(title: aTitle, subTitle: aSubtitle)
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
