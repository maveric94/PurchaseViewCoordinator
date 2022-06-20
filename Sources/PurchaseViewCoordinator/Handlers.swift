//
//  Handlers.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

@MainActor
public protocol ProductLoadingActivityHandler {
    func productsLoadingStarted()
    func productsLoadingEnded(_ result: Result<Void, Error>)
}

@MainActor
public protocol RestoreActivityHandler {
    func restoreStarted()
    func restoreEnded(_ result: Result<Void, Error>)
}

@MainActor
public protocol PurchaseActivityHandler {
    func purchaseStarted()
    func purchaseEnded(_ result: Result<Void, Error>)
}

public protocol PrivacyPolicyHandler {
    func showPrivacyPolicy()
}

@MainActor
public protocol CloseHandler {
    func close()
}

public protocol CustomActionHandler {
    associatedtype Action: CustomAction
    
    func handle(action: Action)
}
