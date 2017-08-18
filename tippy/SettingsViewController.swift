//
//  SettingsViewController.swift
//  tippy
//
//  Created by Vijayanand on 8/3/17.
//  Copyright © 2017 Vijayanand. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var averageTextValue: UITextField!
    @IBOutlet weak var normalTextValue: UITextField!
    @IBOutlet weak var excellentTextValue: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tipSelectionStyle: UISegmentedControl!
    @IBOutlet weak var taxPercent: UITextField!
    @IBOutlet weak var excludeTaxSwitch: UISwitch!
    @IBOutlet weak var tipSliderMinValue: UITextField!
    @IBOutlet weak var tipSliderMaxValue: UITextField!

    @IBOutlet weak var localePicker: UIPickerView!
    let localeData = ["Default", "US", "UK"]
    var localeString = "Default"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.localePicker.delegate = self
        self.localePicker.dataSource = self
        loadLocalePickerSelected()
        loadDefaults()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.localePicker.delegate = self
        self.localePicker.dataSource = self
        loadDefaults()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if let maximumTip = defaults.object(forKey: "tipSliderMaxValue") {
            tipSliderMaxValue.text = maximumTip as? String
        } else {
            tipSliderMaxValue.text = "30"
        }
        if let minimumTip = defaults.object(forKey: "tipSliderMinValue") {
            tipSliderMinValue.text = minimumTip as? String
        } else {
            tipSliderMinValue.text = "0"
        }
    }
    
    func loadLocalePickerSelected() {
        let defaults = UserDefaults.standard
        if let locale = defaults.object(forKey: "localeString") as? String {
            if locale .isEqual("UK") {
                localePicker.selectRow(2, inComponent: 0, animated: false)
            } else {
                if locale .isEqual("US") {
                    localePicker.selectRow(1, inComponent: 0, animated: false)
                } else {
                    localePicker.selectRow(0, inComponent: 0, animated: false)
                }
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return localeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.localeString = localeData[row]
        setLocale()
        return localeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.localeString = localeData[row]
        setLocale()
    }
    
    func setLocale() {
        let defaults = UserDefaults.standard
        if self.localeString .isEqual("US") || self.localeString .isEqual("Default") {
            defaults.set(true, forKey: "usLocaleSet")
            defaults.set(false, forKey: "ukLocaleSet")
        }
        if self.localeString .isEqual("UK") {
            defaults.set(true, forKey: "ukLocaleSet");
            defaults.set(false, forKey: "usLocaleSet");
        }
        defaults.set(self.localeString, forKey: "localeString")
        defaults.synchronize()
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
