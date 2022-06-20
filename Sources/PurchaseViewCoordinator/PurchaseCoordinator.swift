//
//  PurchaseCoordinator.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import Combine

@MainActor
public class PurchaseCoordinator<
    Model: PurchaseViewModel,
    Handler: CustomActionHandler
> where Model.Action == Handler.Action {
    public let model: Model
    public let purchaser: Purchaser
    public var productLoadingHandler: ProductLoadingActivityHandler?
    public var restoreHandler: RestoreActivityHandler?
    public var purchaseHandler: PurchaseActivityHandler?
    public var privacyPolicyHandler: PrivacyPolicyHandler?
    public var closeHandler: CloseHandler?
    public var customActionHandler: Handler?
    
    public var shouldCloseOnRestore = true
    public var shouldCloseOnPurchase = true
    
    private var cancellables = [AnyCancellable]()
    
    required init(model: Model,
                  purchaser: Purchaser) {
        
        self.model = model
        self.purchaser = purchaser

        model.purchaseAction.sink { [unowned self] product in
            self.purchaseHandler?.purchaseStarted()
            Task {
                do {
                    try await purchaser.purchase(product: product)
                    self.purchaseHandler?.purchaseEnded(.success(()))
                    
                    if self.shouldCloseOnPurchase {
                        self.closeHandler?.close()
                    }
                } catch {
                    self.purchaseHandler?.purchaseEnded(.failure(error))
                }
            }
        }.store(in: &cancellables)
        
        model.restoreAction.sink { [unowned self] _ in
            self.restoreHandler?.restoreStarted()
            Task {
                do {
                    let result = try await purchaser.restore()
                    self.restoreHandler?.restoreEnded(.success(()))
                    
                    if result, self.shouldCloseOnRestore {
                        self.closeHandler?.close()
                    }
                } catch {
                    self.restoreHandler?.restoreEnded(.failure(error))
                }
            }
        }.store(in: &cancellables)
        
        model.privacyAction.sink { [unowned self] _ in
            self.privacyPolicyHandler?.showPrivacyPolicy()
        }.store(in: &cancellables)
        
        model.closeAction.sink { [unowned self] _ in
            self.closeHandler?.close()
        }.store(in: &cancellables)
        
        model.customAction.sink { [unowned self] action in
            self.customActionHandler?.handle(action: action)
        }.store(in: &cancellables)
    }
    
    func load() {
        productLoadingHandler?.productsLoadingStarted()
        
        Task {
            do {
                let products = try await purchaser.loadProducts()
                model.productsLoadFinished(.success(products))
                productLoadingHandler?.productsLoadingEnded(.success(()))
            } catch {
                model.productsLoadFinished(.failure(error))
                productLoadingHandler?.productsLoadingEnded(.failure(error))
            }
        }
    }
}
