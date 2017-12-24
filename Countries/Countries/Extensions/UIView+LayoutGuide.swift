//
//  UIView+LayoutGuide.swift
//  Countries
//
//  Created by Eli Ponkratenko on 24/12/2017.
//  Copyright © 2017 Eli Ponkratenko. All rights reserved.
//

import UIKit

extension UIView {

    func pinViewToSuperviewMarginEdges() {
        guard let superview = superview else {
            fatalError("Miss a superview for \(self)")
        }
        var guide = superview.layoutMarginsGuide
        if #available(iOS 11, *) {
            guide = superview.safeAreaLayoutGuide
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: guide.topAnchor),
            leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
    }

}
