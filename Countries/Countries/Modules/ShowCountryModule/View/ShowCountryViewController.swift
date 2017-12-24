//
//  ShowCountryViewController.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit
import WebKit

protocol ShowCountryViewControllerOutput {

    func getCountry(request: ShowCountryModel.Obtain.Request)

}

protocol ShowCountryViewControllerInput: class {

    func showCountry(viewModel: ShowCountryModel.Obtain.ViewModel)

}

final class ShowCountryViewController: UIViewController {

    private struct Constraint {
        static let backgroundColor: UIColor = .white
    }

    private let output: ShowCountryViewControllerOutput
    private let country: Country
    private let descriptionLabel = UILabel()
    private let flagView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    private let bordersLabel = UILabel()

    init(output: ShowCountryViewControllerOutput,
         country: Country) {
        self.output = output
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constraint.backgroundColor
        output.getCountry(request:
            ShowCountryModel.Obtain.Request(
                country: country
            )
        )
        setupDescriptionLabel()
        setupBordersLabel()
        setupFlagView()
    }

    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
    }

    private func setupBordersLabel() {
        bordersLabel.numberOfLines = 0
        bordersLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bordersLabel.adjustsFontForContentSizeCategory = true
        bordersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bordersLabel)
        NSLayoutConstraint.activate([
            bordersLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            bordersLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            bordersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
    }

    private func setupFlagView() {
        flagView.scrollView.isScrollEnabled = false
        flagView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flagView)
        NSLayoutConstraint.activate([
            flagView.topAnchor.constraint(equalTo: bordersLabel.bottomAnchor, constant: 10),
            flagView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            flagView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            flagView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }

    private func updateFlagView(with viewModel: ShowCountryModel.Obtain.ViewModel) {
        let request = URLRequest(url: viewModel.flag)
        flagView.load(request)
    }

    private func updateBorderLabel(with viewModel: ShowCountryModel.Obtain.ViewModel) {
        guard viewModel.borders.count > 0 else {
            bordersLabel.text = "The country has no borders."
            return
        }
        bordersLabel.text = viewModel.borders.reduce("Borders:\n", { (result, newValue) in
            return result + "\(newValue)\n"
        })
    }

    private func updateDescriptionLable(with viewModel: ShowCountryModel.Obtain.ViewModel) {
        descriptionLabel.text = """
        \(viewModel.name)
        Capital: \(viewModel.capital)
        Region: \(viewModel.region)
        Area: \(String(describing: viewModel.area))
        Population: \(viewModel.population)
        """
    }
}

extension ShowCountryViewController: ShowCountryViewControllerInput {

    func showCountry(viewModel: ShowCountryModel.Obtain.ViewModel) {
        updateFlagView(with: viewModel)
        updateBorderLabel(with: viewModel)
        updateDescriptionLable(with: viewModel)
        view.setNeedsUpdateConstraints()
    }

}
