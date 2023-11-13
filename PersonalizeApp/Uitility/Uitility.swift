//
//  JsonFileToData.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

func presentPopover(_ parentViewController: UIViewController, _ viewController: UIViewController, sender: UIView, size: CGSize, arrowDirection: UIPopoverArrowDirection = .down, x: CGFloat = 0, y: CGFloat = 0) {
    viewController.preferredContentSize = size
    viewController.modalPresentationStyle = .popover
    if let pres = viewController.presentationController {
        pres.delegate = (parentViewController as! any UIAdaptivePresentationControllerDelegate)
    }
    parentViewController.present(viewController, animated: true)
    if let pop = viewController.popoverPresentationController {
        pop.sourceView = sender
        pop.sourceRect = CGRect(x: sender.bounds.minX + x, y: sender.bounds.minY + y, width: sender.bounds.width, height: sender.bounds.height)
        pop.permittedArrowDirections = arrowDirection
        pop.backgroundColor = .white
    }
}


