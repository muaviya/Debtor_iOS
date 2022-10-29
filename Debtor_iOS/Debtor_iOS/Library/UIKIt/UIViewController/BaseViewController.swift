//
//  BaseViewController.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    typealias OnBackButtonTap = () -> Void
    
    var rootView: View { view as! View }
    var onBackButtonTap: OnBackButtonTap?
    
    override func loadView() {
        view = View.loadView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            onBackButtonTap?()
        }
    }
    
}
