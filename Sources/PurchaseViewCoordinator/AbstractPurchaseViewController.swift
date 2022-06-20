//
//  AbstractPurchaseViewController.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import UIKit
import SwiftUI

open class AbstractPurchaseViewController<
    View: PurchaseView,
    ViewModel,
    Handler: CustomActionHandler
>: UIViewController where View.Model == ViewModel, ViewModel.Action == Handler.Action {
    public typealias Coordinator = PurchaseCoordinator<ViewModel, Handler>
    
    private let coordinator: Coordinator
    private let model: ViewModel
    
    public init(purchaser: Purchaser, model: ViewModel) {
        self.model = model
        self.coordinator = Coordinator.init(model: model,
                                            purchaser: purchaser)
        super.init(nibName: nil, bundle: nil)
        
        modifyCoordinator(coordinator: coordinator)
        coordinator.load()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
                
        let controller = UIHostingController(rootView: View.init(model: model))
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            view.topAnchor.constraint(equalTo: controller.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
        ])
    }
    
    open func modifyCoordinator(coordinator: Coordinator) {
    }
}
