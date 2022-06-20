//
//  Purchaser.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import StoreKit

public protocol Purchaser {
    func loadProducts() async throws -> [SKProduct]
    func restore() async throws -> Bool
    func purchase(product: SKProduct) async throws
}
