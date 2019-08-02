//
//  CustomBtnTestViewController.swift
//  labelTestDemo
//
//  Created by PCQ184 on 02/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import UIKit

class CustomBtnTestViewController: UIViewController {
    
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var txtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    //MARK:- View Methods
    private func prepareView() {

    }
    
    //MARK:- Action Mehtods
    @IBAction private func pushButtonPressed(_ button: CustomShapeButton) {
       print(button.tag)
    }    
}


