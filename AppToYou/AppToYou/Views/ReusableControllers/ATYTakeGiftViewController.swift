//
//  ATYGiftViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYTakeGiftViewController: UIViewController {

    @IBOutlet weak var thanksButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        thanksButton.layer.cornerRadius = 25
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func thanksButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
