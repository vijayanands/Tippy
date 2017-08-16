//
//  SettingsViewController.swift
//  tippy
//
//  Created by Vijayanand on 8/3/17.
//  Copyright © 2017 Vijayanand. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var averageTextValue: UITextField!
    @IBOutlet weak var normalTextValue: UITextField!
    @IBOutlet weak var excellentTextValue: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tipSelectionStyle: UISegmentedControl!
    @IBOutlet weak var taxPercent: UITextField!
    @IBOutlet weak var excludeTaxSwitch: UISwitch!
    @IBOutlet weak var tipSliderMinValue: UITextField!
    @IBOutlet weak var tipSliderMaxValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDefaults()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadDefaults()
    }
    
    func loadDefaults() {
        let defaults = UserDefaults.standard
        if let textValue = defaults.object(forKey: "excellentTextValue") {
            excellentTextValue.text =  textValue as? String
        } else {
            excellentTextValue.text =  "18"
        }
        if let textValue = defaults.object(forKey: "normalTextValue") {
            normalTextValue.text = textValue as? String
        } else {
            normalTextValue.text = "15"
        }
        if let textValue = defaults.object(forKey: "averageTextValue") {
            averageTextValue.text = textValue as? String
        } else {
            averageTextValue.text = "12"
        }
        
        if let useSlider = defaults.object(forKey: "tipSelectionStyleSlider") as? Bool {
            if (useSlider == false) {
                tipSelectionStyle.selectedSegmentIndex = 1
            } else {
                tipSelectionStyle.selectedSegmentIndex = 0
            }
        } else {
            tipSelectionStyle.selectedSegmentIndex = 0
        }
        if let excludeTaxValue = defaults.object(forKey: "excludeTax") as? Bool {
            if (excludeTaxValue == true) {
                excludeTaxSwitch.isOn = true
            } else {
                excludeTaxSwitch.isOn = false
            }
        } else {
            excludeTaxSwitch.isOn = true
        }
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(excellentTextValue.text, forKey: "excellentTextValue")
        defaults.set(normalTextValue.text, forKey: "normalTextValue")
        defaults.set(averageTextValue.text, forKey: "averageTextValue")
        defaults.set(taxPercent.text, forKey: "taxPercent")
        defaults.set(tipSliderMinValue.text, forKey: "tipSliderMinValue")
        defaults.set(tipSliderMaxValue.text, forKey: "tipSliderMaxValue")
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func changedTipSelectionStyle(_ sender: UISegmentedControl) {
        let defaults = UserDefaults.standard
        if (tipSelectionStyle.selectedSegmentIndex == 0) {
            defaults.set(true, forKey: "tipSelectionStyleSlider")
        } else {
            defaults.set(false, forKey: "tipSelectionStyleSlider")
        }
        defaults.synchronize();
    }
    
    @IBAction func excludeTaxSwitchAction(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        
        if (sender.isOn == true) {
            defaults.set(true, forKey: "excludeTax");
        } else {
            defaults.set(false, forKey: "excludeTax");
        }
        defaults.synchronize()
    }
}
