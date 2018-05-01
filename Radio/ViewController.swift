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
            switch res {
            case .success(let progs):
                for (i, prog) in progs.enumerated() {
                    print(i, prog.name)
                }
            case .failure(let e):
                print(e)
            }
        }
    }

}
