//
//  UIFactory.swift
//  MomenWeatherApp
//
//  Created by Momen Shataly on 02.11.20.
//

import Foundation
import UIKit
public class UIFactory {
    public static func createConfirmAlertView(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        return alertController
    }

    public static func createCollectionView(frame: CGRect = .zero, layout: UICollectionViewLayout = UICollectionViewFlowLayout(), allowsSelection: Bool = false) -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.allowsSelection = allowsSelection
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}
