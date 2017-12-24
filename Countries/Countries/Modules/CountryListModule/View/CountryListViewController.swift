//
//  CountryListViewController.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

protocol CountryListViewControllerOutput {
    func obtainCountriesList()
}

protocol CountryListViewControllerInput: class {
    func showCountryList(with: CountryListViewModel)
    func showErrorAlert(message: String)
}

final class CountryListViewController: UIViewController {

    private struct Constraint {
        static let title = "Country list"
        static let backgroundColor: UIColor = .white
        struct TableView {
            static let rowHieght: CGFloat = 44
        }
    }

    var output: CountryListViewControllerOutput?

    private var tableView: UITableView?
    private var listViewModel: CountryListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constraint.backgroundColor
        title = Constraint.title
        setupTableView()
        registerCells()
        output?.obtainCountriesList()
    }

    private func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = Constraint.TableView.rowHieght
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pinViewToSuperviewEdges()
    }

    private func registerCells() {
        tableView?.register(CountryListCell.self, forCellReuseIdentifier: CountryListCell.identifier)
    }

}

extension CountryListViewController: CountryListViewControllerInput {

    func showCountryList(with listViewModel: CountryListViewModel) {
        self.listViewModel = listViewModel
        tableView?.reloadData()
    }

    func showErrorAlert(message: String) {
        // show alert with an error message
    }

}

extension CountryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel?.cellModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = listViewModel?.cellModels[indexPath.row] else {
            return UITableViewCell()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.identifier, for: indexPath) as? CountryListCell {
            cell.update(with: cellModel)
            return cell
        }
        return UITableViewCell()
    }

}

extension CountryListViewController: UITableViewDelegate {

}
