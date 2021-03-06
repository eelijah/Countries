//
//  ShowCountryViewController.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit
import WebKit

final class ShowCountryViewController: UIViewController {

    private struct Constraint {
        static let backgroundColor: UIColor = .white
        struct DescriptionLabel {
            static let inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
        struct BordersLabel {
            static let inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
        struct FlagView {
            static let inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
    }

    private let output: ShowCountryViewControllerOutput
    private let country: Country
    private let descriptionLabel = UILabel()
    private let flagView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    private let bordersLabel = UILabel()
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    private lazy var measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter = self.numberFormatter
        return formatter
    }()

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
        navigationItem.title = country.nativeName
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
            descriptionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                                  constant: Constraint.DescriptionLabel.inset.top),
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
            bordersLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                              constant: Constraint.BordersLabel.inset.top),
            bordersLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            bordersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
    }

    private func setupFlagView() {
        flagView.scrollView.isScrollEnabled = false
        flagView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flagView)
        NSLayoutConstraint.activate([
            flagView.topAnchor.constraint(equalTo: bordersLabel.bottomAnchor,
                                          constant: Constraint.FlagView.inset.top),
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
        bordersLabel.text = "Borders:\n" + viewModel.borders.joined(separator: "\n")
    }

    private func updateDescriptionLable(with viewModel: ShowCountryModel.Obtain.ViewModel) {
        descriptionLabel.text = """
        \(viewModel.name)
        Capital: \(viewModel.capital)
        Region: \(viewModel.region)
        Area: \(measurementFormatter.string(from: viewModel.area))
        Population: \(numberFormatter.string(from: NSNumber(value: viewModel.population))!)
        """
    }
}

extension ShowCountryViewController: ShowCountryViewControllerInput {

    func showCountry(viewModel: ShowCountryModel.Obtain.ViewModel) {
        updateFlagView(with: viewModel)
        updateBorderLabel(with: viewModel)
        updateDescriptionLable(with: viewModel)
    }

}
