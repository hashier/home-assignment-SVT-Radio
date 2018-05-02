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

        RESTClient().getTimetable { (timetableResult) in
            switch timetableResult {
            case .success(let timetable):
                for (i, prog) in timetable.programs.enumerated() {
                    print(i, prog.name)
                }
                print("Showing \(timetable.pagination.size) of \(timetable.pagination.total)")
            case .failure(let e):
                print(e)
            }
        }
    }

}
