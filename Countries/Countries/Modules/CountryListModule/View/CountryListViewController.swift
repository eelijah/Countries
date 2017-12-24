//
//  CountryListViewController.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

final class CountryListViewController: UIViewController {

    private struct Constraint {
        static let title = "Country list"
        static let backgroundColor: UIColor = .white
        struct TableView {
            static let rowHieght: CGFloat = 44
        }
    }

    var output: CountryListViewControllerOutput?

    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var viewModels: [CountryListCellViewModel]?
    private var filtredViewModels: [CountryListCellViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constraint.backgroundColor
        title = Constraint.title
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        registerCells()
        setupSearchController()
        output?.obtainCountriesList()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = Constraint.TableView.rowHieght
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pinViewToSuperviewMarginEdges()
    }

    private func registerCells() {
        tableView.register(CountryListCell.self, forCellReuseIdentifier: CountryListCell.identifier)
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

}

extension CountryListViewController: CountryListViewControllerInput {

    func showCountryList(with listViewModel: CountryListTableViewModel) {
        self.viewModels = listViewModel.cellModels
        tableView.reloadData()
    }

    func showErrorAlert(message: String) {
        // show alert with an error message
    }

}

extension CountryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltering ? filtredViewModels : viewModels)?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = (isFiltering ? filtredViewModels : viewModels)?[indexPath.row] else {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

}

extension CountryListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            filtredViewModels = viewModels?.filter {
                $0.name.lowercased().contains(text.lowercased())
            }
        }
        tableView.reloadData()
    }

}
