//
//  ProgramTableViewCell.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-02.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit
import SDWebImage

class ProgramTableViewCell: UITableViewCell {

    // MARK: - Static
    static let programTableViewCellIdent = "programTableViewCellIdent"

    // MARK: - IVar
    internal var program: Program? {
        didSet {
            textLabel?.text = program?.name
            detailTextLabel?.text = program?.description

            guard let program = program else { return }
            let url = URL(string: program.image)
            imageView?.sd_setImage(with: url, completed: { (_, _, _, url) in
                self.setNeedsLayout()
            })
        }
    }

    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: ProgramTableViewCell.programTableViewCellIdent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView?.sd_cancelCurrentImageLoad()
    }

}
