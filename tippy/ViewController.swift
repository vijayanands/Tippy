//
//  ViewController.swift
//  tippy
//
//  Created by Vijayanand on 8/2/17.
//  Copyright © 2017 Vijayanand. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPicker: UIPickerView!
    
    var tipPickerFields = ["Bad Service", "Good Service", "Excellent Service",  "No Tip"]
    var tipPercentages = [10, 10, 10, 0]
    var tipSelected2 : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tipPicker.delegate = self
        self.tipPicker.dataSource = self
        self.tipPicker.backgroundColor = UIColor .cyan
        self.tipPicker.selectRow(1, inComponent: 0, animated: false)
        loadTipDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadTipDefaults()
        setFields()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in tipPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ tipPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipPickerFields.count
    }
    
    func pickerView(_ tipPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipPickerFields[row]
    }
    
    func pickerView(_ tipPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipSelected2 = row
        loadTipDefaults()
        setFields()
    }
    
    func pickerView(_ tipPicker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 15)
        
        // where data is an Array of String
        label.text = tipPickerFields[row]
        
        return label
    }
    
    func loadTipDefaults() {
        let defaultBadServiceTip = "15"
        let defaultGoodServiceTip = "18"
        let defaultExcellentServiceTip = "22"
        let defaults = UserDefaults.standard
        if let averageServiceTip = defaults.object(forKey: "averageTextValue") {
            tipPercentages[0] = Int (averageServiceTip as! String)!
        } else {
            defaults.set(defaultBadServiceTip, forKey: "averageTextValue")
            tipPercentages[0] = Int (defaultBadServiceTip)!
        }
        if let normalServiceTip = defaults.object(forKey: "normalTextValue") {
            tipPercentages[1] = Int (normalServiceTip as! String)!
            
        } else {
            defaults.set(defaultGoodServiceTip, forKey: "normalTextValue")
            tipPercentages[1] = Int (defaultGoodServiceTip)!
        }
        if let excellentServiceTip = defaults.object(forKey: "excellentTextValue") {
            tipPercentages[2] = Int (excellentServiceTip as! String)!
        } else {
            defaults.set(defaultExcellentServiceTip, forKey: "excellentTextValue")
            tipPercentages[2] = Int (defaultExcellentServiceTip)!
        }
        defaults.synchronize()
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        setFields();
    }
    
    func setFields() {
        let bill = Double(billField.text!) ?? 0
        let tipPercentage = tipPercentages[tipSelected2]
        let tip = bill * Double(tipPercentage)/100
        let total = bill + tip
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
    }
}

