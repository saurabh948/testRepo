//
//  ResponseCell.swift
//  EngineerAITest
//
//  Created by PCQ184 on 02/08/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import Foundation
import UIKit

class ResponseCell: UITableViewCell{
    
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblDate      : UILabel!
    @IBOutlet weak var toggleSwitch : UISwitch!
    
    static let cellIdentifier = "ResponseCell"
}
