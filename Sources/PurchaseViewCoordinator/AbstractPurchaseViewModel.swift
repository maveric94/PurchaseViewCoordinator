//
//  AbstractPurchaseViewModel.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import Combine
import StoreKit

open class AbstractPurchaseViewModel<Action: CustomAction>: PurchaseViewModel {
    public typealias ViewModelCustomAction = Action
    
    public let closeAction = PassthroughSubject<Void, Never>()
    public let purchaseAction = PassthroughSubject<SKProduct, Never>()
    public let restoreAction = PassthroughSubject<Void, Never>()
    public let privacyAction = PassthroughSubject<Void, Never>()
    public let customAction = PassthroughSubject<ViewModelCustomAction, Never>()
    
    @Published
    public var products: [SKProduct]?
    
    @Published
    public var selectedProductIndex: Int?
    
    public init() {}
        
    public func productsLoadFinished(_ result: Result<[SKProduct], Error>) {
        products = try? result.get()
    }
    
    open func purchase() {
        if let index = selectedProductIndex, let products = products, products.indices.contains(index) {
            purchaseAction.send(products[index])
        }
    }
    
    open func restore() {
        restoreAction.send()
    }
    
    open func close() {
        closeAction.send()
    }
        
    open func openPrivacy() {
        privacyAction.send()
    }
    
    open func customAction(_ action: ViewModelCustomAction) {
        customAction.send(action)
    }
}
