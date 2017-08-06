//
//  SettingsViewController.swift
//  tippy
//
//  Created by Vijayanand on 8/3/17.
//  Copyright © 2017 Vijayanand. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var excellentTextValue: UITextField!
    @IBOutlet weak var normalTextValue: UITextField!
    @IBOutlet weak var averageTextValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        excellentTextValue.text = defaults.object(forKey: "excellentTextValue") as? String
        normalTextValue.text = defaults.object(forKey: "normalTextValue") as? String
        averageTextValue.text = defaults.object(forKey: "averageTextValue") as? String
    }

    @IBAction func saveTipSettings(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(excellentTextValue.text, forKey: "excellentTextValue")
        defaults.set(normalTextValue.text, forKey: "normalTextValue")
        defaults.set(averageTextValue.text, forKey: "averageTextValue")
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

}
