//
//  DetailViewController.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-02.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    // MARK: - IVar
    private var program = Program()

    // MARK: - IBOutlet
    @IBOutlet private weak var image: UIImageView! {
        didSet {
            let url = URL(string: program.image)
            image.sd_setImage(with: url)
        }
    }
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var detail: UILabel!
    @IBOutlet private weak var category: UILabel!

    // MARK: - Init
    class func instantiateViewController(with program: Program) -> DetailViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController-StoryboardID") as! DetailViewController
        viewController.program = program
        return viewController
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
    }

}

// MARK: - Methods
extension DetailViewController {
    fileprivate func setupLabels() {
        name.text = program.name
        detail.text = program.description
        category.text = program.category
    }
}
