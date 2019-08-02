//
//  ViewController.swift
//  labelTestDemo
//
//  Created by PCQ184 on 28/06/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class ViewController: UIViewController {
    
    @IBOutlet private weak var testTextField: SkyFloatingLabelTextField!
    //Counter outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    let activeUnderLineColor = UIColor(red: 1/255, green: 175/255, blue: 191/255, alpha: 1.000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UInt8.max &+ 1)
        counterLabel.text = String(counterView.counter)
        prepareFields()
    }

    private func prepareFields() {
        testTextField.placeholder           = "User Name"
        testTextField.title                 = "User Name"
        testTextField.titleColor            = activeUnderLineColor
        testTextField.selectedTitleColor    = activeUnderLineColor
        testTextField.selectedLineColor     = activeUnderLineColor
    }
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            if counterView.counter < 8 {
                counterView.counter += 1
            }
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
    }
}
/*
    Date                        Task
 29/07/2019    Health kit integreation and voice recognition
 30/07/2019    Working on Checklist screens symptoms managment through screens
 31/07/2019    Worked on checklist and toilet screens
 01/08/2019    Setting up network layer for login api's
 */

