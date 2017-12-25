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

    private let router: CountryListRouter
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var output: CountryListViewControllerOutput?
    private var viewModels: [CountryListModel.Obtain.ViewModel.CellViewModel]?
    private var filtredViewModels: [CountryListModel.Obtain.ViewModel.CellViewModel]?

    init(router: CountryListRouter,
         output: CountryListViewControllerOutput) {
        self.router = router
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constraint.backgroundColor
        navigationItem.title = Constraint.title
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        registerCells()
        setupSearchController()
        output?.obtainCountriesList(request: CountryListModel.Obtain.Request())
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = Constraint.TableView.rowHieght
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pinToSuperviewMarginEdges()
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

    func showCountries(viewModel: CountryListModel.Obtain.ViewModel) {
        self.viewModels = viewModel.cellModels
        tableView.reloadData()
    }

    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        showDetailViewController(alertController, sender: nil)
    }

}

extension CountryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltering ? filtredViewModels : viewModels)?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cellModel = (isFiltering ? filtredViewModels : viewModels)?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.identifier, for: indexPath) as? CountryListCell
        else {
            return UITableViewCell()
        }
        cell.update(with: cellModel)
        return cell
    }

}

extension CountryListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        guard let cellModel = (isFiltering ? filtredViewModels : viewModels)?[indexPath.row] else {
            return
        }
        router.showCountry(cellModel.model)
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
