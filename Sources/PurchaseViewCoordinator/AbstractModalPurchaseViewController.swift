//
//  AbstractModalPurchaseViewController.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import UIKit

open class AbstractModalPurchaseViewController<
    View: PurchaseView,
    ViewModel,
    Handler: CustomActionHandler
>: AbstractPurchaseViewController<View, ViewModel, Handler>
where View.Model == ViewModel, ViewModel.Action == Handler.Action {
    open override func modifyCoordinator(coordinator: Coordinator) {
        super.modifyCoordinator(coordinator: coordinator)
        coordinator.closeHandler = ModalCloseViewHandler(controller: self)
    }
}

public class ModalCloseViewHandler: CloseHandler {
    unowned let controller: UIViewController
    public init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func close() {
        controller.dismiss(animated: true)
    }
}
