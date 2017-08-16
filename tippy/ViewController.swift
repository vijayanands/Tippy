//
//  ViewController.swift
//  tippy
//
//  Created by Vijayanand on 8/2/17.
//  Copyright © 2017 Vijayanand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipSelectionSlider: UISlider!
    @IBOutlet weak var tipSelectionButtons: UISegmentedControl!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipStringLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipSelectionSegment: UISegmentedControl!
    
    @IBOutlet weak var tipSliderMinValue: UILabel!
    @IBOutlet weak var tipSliderMaxValue: UILabel!
    
    var tipPercentages = [10, 10, 10]
    var tipSelected : Int = 1
    var tipSelectionStyleSlider = false
    var taxPercent = 8.25
    var excludeTax = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.billField.becomeFirstResponder()
        loadDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.billField.becomeFirstResponder()
        loadDefaults()
        setFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSliderSelectionVisibility() {
        if (tipSelectionStyleSlider == true) {
            self.tipSelectionButtons.isHidden = true
            self.tipSelectionSlider.isHidden = false
            self.tipSliderMaxValue.isHidden = false
            self.tipSliderMinValue.isHidden = false
        } else {
            self.tipSelectionButtons.isHidden = false
            self.tipSelectionSlider.isHidden = true
            self.tipSliderMaxValue.isHidden = true
            self.tipSliderMinValue.isHidden = true
        }
    }
    
    func loadDefaults() {
        let defaultBadServiceTip = "15"
        let defaultGoodServiceTip = "18"
        let defaultExcellentServiceTip = "22"
        let defaults = UserDefaults.standard
        // determine use of slider/buttons for tip
        if let useSlider = defaults.object(forKey: "tipSelectionStyleSlider") {
            tipSelectionStyleSlider = useSlider as! Bool
        } else {
            tipSelectionStyleSlider = true
        }
        // get tax percentage from defaults
        if let tax=defaults.object(forKey: "taxPercent") {
            taxPercent = Double (tax as! String)!
        } else {
            taxPercent = 8.25
        }
        // include Tax in Tip Calculation?
        if let excludeTaxValue = defaults.object(forKey: "excludeTax") {
            excludeTax = (excludeTaxValue as? Bool)!
        } else {
            excludeTax = true
        }
        
        if (tipSelectionStyleSlider == true) {
            var tipSliderMin = "0"
            var tipSliderMax = "30"
            // Initialize Slider Defaults
            if let min=defaults.object(forKey: "tipSliderMinValue") {
                tipSliderMin = (min as! String)
            } else {
                tipSliderMin = "0"
            }
            tipSlider.minimumValue = Float(tipSliderMin)!
            
            if let max=defaults.object(forKey: "tipSliderMaxValue") {
                tipSliderMax = (max as! String)
            } else {
                tipSliderMax = "30"
            }
            tipSlider.maximumValue = Float(tipSliderMax)!
            
            let tipValue = Float((tipSlider.minimumValue + tipSlider.maximumValue)/2)
            tipSlider.value = tipValue
            tipSliderMinValue.text = String(format: "%.0f", tipSlider.minimumValue)
            tipSliderMaxValue.text = String(format: "%.0f", tipSlider.maximumValue)
        } else {
            // Initialize Button Defaults
            if let averageServiceTip = defaults.object(forKey: "averageTextValue") {
                tipPercentages[0] = Int (averageServiceTip as! String)!
                tipSelectionSegment.setTitle(averageServiceTip as? String, forSegmentAt: 0)
            } else {
                defaults.set(defaultBadServiceTip, forKey: "averageTextValue")
                tipPercentages[0] = Int (defaultBadServiceTip)!
                tipSelectionSegment.setTitle(defaultBadServiceTip, forSegmentAt: 0)
            }
            if let normalServiceTip = defaults.object(forKey: "normalTextValue") {
                tipPercentages[1] = Int (normalServiceTip as! String)!
                tipSelectionSegment.setTitle(normalServiceTip as? String, forSegmentAt: 1)
            } else {
                defaults.set(defaultGoodServiceTip, forKey: "normalTextValue")
                tipPercentages[1] = Int (defaultGoodServiceTip)!
                tipSelectionSegment.setTitle(defaultGoodServiceTip, forSegmentAt: 1)
            }
            if let excellentServiceTip = defaults.object(forKey: "excellentTextValue") {
                tipPercentages[2] = Int (excellentServiceTip as! String)!
                tipSelectionSegment.setTitle(excellentServiceTip as? String, forSegmentAt: 2)
            } else {
                defaults.set(defaultExcellentServiceTip, forKey: "excellentTextValue")
                tipPercentages[2] = Int (defaultExcellentServiceTip)!
                tipSelectionSegment.setTitle(defaultExcellentServiceTip, forSegmentAt: 2)
            }
        }
        defaults.synchronize()
        setSliderSelectionVisibility()
    }

    @IBAction func tipSliderValueChanged(_ sender: Any) {
        setFields()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        setFields();
    }
    
    @IBAction func tipSelectionChanged(_ sender: Any) {
        setFields();
    }
    
    func setFields() {
        let bill = Double(billField.text!) ?? 0
        var tipPercentage = 0
        if (tipSelectionStyleSlider == true) {
            tipPercentage = Int(tipSlider.value)
        } else {
            tipPercentage = tipPercentages[ tipSelectionSegment.selectedSegmentIndex]
        }

        let tax = Double((bill * taxPercent)/100)
        var tip = 0.0
        if (excludeTax == true) {
            tip = bill * Double(tipPercentage)/100
        } else {
            tip = (bill+tax) * Double(tipPercentage)/100
        }
        let total = bill + tax + tip
        
        tipStringLabel.text = String("Tip (\(tipPercentage)%)")
        tipLabel.text = String(format: "%.2f", tip)
        taxLabel.text = String(format: "%.2f", tax)
        totalLabel.text = String(format: "%.2f", total)
    }
}

