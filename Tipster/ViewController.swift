//
//  ViewController.swift
//  Tipster
//
//  Created by Kaan Kabalak on 7/6/17.
//  Copyright © 2017 Kaan Kabalak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var percentage = 10
    var price = ""
    var tip = 0.0
    var isDecimal = false
    var countAfterDecimal = 0
    var groupSize = 1

    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var groupSlider: UISlider!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var groupSizeLabel: UILabel!
    
    @IBOutlet var percentageLabelCollection: [UILabel]!
    
    @IBOutlet var tipLabelCollection: [UILabel]!
    
    @IBOutlet var totalLabelCollection: [UILabel]!
    
    @IBAction func digitButtonPressed(_ sender: UIButton) {
        print(isDecimal)
        if( (sender.currentTitle!) != "C") {
            if(price == "" && ( (sender.currentTitle!) == "0" || (sender.currentTitle!) == ".") ) {
                
            }
            else if ( (sender.currentTitle!) == "." &&
                !isDecimal) {
                isDecimal = true
                price += (sender.currentTitle!)
            }
            else if ( (sender.currentTitle!) == "." &&
                isDecimal) {
            }
            else if (isDecimal && countAfterDecimal < 2){
                price += (sender.currentTitle!)
                countAfterDecimal += 1
            }
            else if (isDecimal && countAfterDecimal >= 2){
            }
            else {
                price += (sender.currentTitle!)
            }
        }
        else {
            price = ""
            countAfterDecimal = 0
            isDecimal = false
        }
        reloadUI()
        print(sender.currentTitle!)
    }
    
    @IBAction func groupSizeChanged(_ sender: UISlider) {
        groupSize = Int(sender.value)
        groupSizeLabel.text = "Group Size: \(groupSize)"
        reloadUI()
    }
    
    @IBAction func tipAmountChanged(_ sender: UISlider) {
        percentage = Int(sender.value)
        reloadUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        priceLabel.text = ""
        groupSizeLabel.text = "Group Size: 1"
        for i in 0..<tipLabelCollection.count {
            tipLabelCollection[i].text = "0.00"
        }
        for i in 0..<totalLabelCollection.count {
            totalLabelCollection[i].text = "0.00"
        }
        for i in 0..<percentageLabelCollection.count {
            percentageLabelCollection[i].text = "\(percentage+(5*i))%"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadUI() {
        if(price == "") {
            viewDidLoad()
        }
        else {
            priceLabel.text = price
            
            for i in 0..<percentageLabelCollection.count {
                percentageLabelCollection[i].text = "\(percentage+(5*i))%"
            }
            for i in 0..<tipLabelCollection.count {
                tipLabelCollection[i].text = String(format: "%.2f", Double(price)!*Double(percentage+5*i)/(100*Double(groupSize)))
            }
            for i in 0..<totalLabelCollection.count {
                totalLabelCollection[i].text = String(format: "%.2f", (Double(price)!+(Double(price)!*Double(percentage+5*i)/100))/Double(groupSize))
            }
        }
    }

}

