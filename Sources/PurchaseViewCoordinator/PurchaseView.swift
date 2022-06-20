//
//  PurchaseView.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

import SwiftUI

public protocol PurchaseView: View {
    associatedtype Model: PurchaseViewModel
    
    init(model: Model)
}
