//
//  BaseViewController.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
