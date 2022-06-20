//
//  ModalPrivacyPolicyHandler.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import UIKit

public class ModalPrivacyPolicyHandler: PrivacyPolicyHandler {
    unowned let controller: UIViewController
    let privacyPolicyFactory: () -> UIViewController
    
    public init(controller: UIViewController,
                privacyPolicyFactory: @escaping () -> UIViewController) {
        self.controller = controller
        self.privacyPolicyFactory = privacyPolicyFactory
    }
    
    public func showPrivacyPolicy() {
        controller.present(privacyPolicyFactory(), animated: true)
    }
}


