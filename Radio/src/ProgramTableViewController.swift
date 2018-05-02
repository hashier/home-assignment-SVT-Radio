//
//  ProgramTableViewController.swift
//  Radio
//
//  Created by Christopher Lössl on 2018-05-02.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit

class ProgramTableViewController: UITableViewController {

    // MARK: - IVar
    var data: Timetable?

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTitle()

        tableView.register(ProgramTableViewCell.self, forCellReuseIdentifier: ProgramTableViewCell.programTableViewCellIdent)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        RESTClient().getTimetable { (timetableResult) in
            switch timetableResult {
            case .success(let timetable):
                self.data = timetable
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.updateTitle()
            case .failure(let e):
                print(e)
                let alert = UIAlertController.infoAlert(title: "Error", message: e.localizedDescription)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: - Methods
extension ProgramTableViewController {
    private func updateTitle() {
        var string = "Program"
        if let data = data {
            string = "Program \(data.pagination.size) of \(data.pagination.total)"
        }
        DispatchQueue.main.async {
            self.title = string
        }
    }
}

// MARK: - Table view data source
internal extension ProgramTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.programs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.programTableViewCellIdent, for: indexPath) as! ProgramTableViewCell

        cell.program = data?.programs[indexPath.row]

        return cell
    }

}

// MARK: - Table view data source
internal extension ProgramTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewController = DetailViewController.instantiateViewController(with: (data?.programs[indexPath.row])!)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
