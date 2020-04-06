//
//  DemoCell.swift
//  TravelDiary
//
//  Created by SIM1718 on 14/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//

import FoldingCell
import UIKit

class DemoCell: FoldingCell {
    
    @IBOutlet var closeNumberLabel: UILabel!
    @IBOutlet var openNumberLabel: UILabel!
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}

// MARK: - Actions ⚡️
extension DemoCell {
    
    @IBAction func buttonHandler(_: AnyObject) {
        print("tap")
    }
}
