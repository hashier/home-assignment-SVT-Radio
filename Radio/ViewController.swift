//
//  ViewController.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-01.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RESTClient().getProgram { (res) in
            print(res)
        }
    }

}

