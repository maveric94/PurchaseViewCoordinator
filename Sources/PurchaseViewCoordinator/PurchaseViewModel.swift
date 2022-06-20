//
//  PurchaseViewModel.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import StoreKit
import Combine

public protocol CustomAction { }

public protocol PurchaseViewModel: ObservableObject {
    associatedtype Action: CustomAction
    
    var products: [SKProduct]? { get }
    var selectedProductIndex: Int? { get set }
    
    @MainActor
    func productsLoadFinished(_ result: Result<[SKProduct], Error>)
    
    var closeAction: PassthroughSubject<Void, Never> { get }
    var purchaseAction: PassthroughSubject<SKProduct, Never> { get }
    var restoreAction: PassthroughSubject<Void, Never> { get }
    var privacyAction: PassthroughSubject<Void, Never> { get }
    var customAction: PassthroughSubject<Action, Never> { get }
    
    func close()
    func purchase()
    func restore()
    func openPrivacy()
    func customAction(_ action: Action)
}
