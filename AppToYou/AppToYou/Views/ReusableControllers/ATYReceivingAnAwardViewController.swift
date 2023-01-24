//
//  ATYReceivingAnAwardViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYReceivingAnAwardViewController: UIViewController {

    @IBOutlet weak var takeAwardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.cornerRadius = 25
        takeAwardButton.layer.cornerRadius = 25
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func takeAwardButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
