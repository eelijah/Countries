//
//  CountryListCell.swift
//  Countries
//
//  Created by Eli Ponkratenko on 23/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {

    private struct Constants {
        static let backgroundColor: UIColor = .white
        struct CodeLabel {
            static let insets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        }
    }

    static var identifier: String {
        return String(describing: self)
    }

    private let nameLabel = UILabel()
    private let codeLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonSetup() {
        contentView.backgroundColor = Constants.backgroundColor
        setupNameLabel()
        setupCodeLabel()
    }

    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.backgroundColor = Constants.backgroundColor
        contentView.addSubview(nameLabel)
        let margins = contentView.layoutMarginsGuide
        nameLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }

    private func setupCodeLabel() {
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.backgroundColor = Constants.backgroundColor
        contentView.addSubview(codeLabel)
        let margins = contentView.layoutMarginsGuide
        NSLayoutConstraint(item: codeLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: nameLabel,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: Constants.CodeLabel.insets.top).isActive = true
        codeLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        codeLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    func update(with model: CountryListCellViewModel) {
        nameLabel.text = model.name
        codeLabel.text = model.code
    }

}
