//
//  EmptyCustomAction.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

public class EmptyCustomAction: CustomAction { }

public class EmptyCustomActionHandler: CustomActionHandler {
    public typealias Action = EmptyCustomAction
    
    public func handle(action: Action) {
    }
}

