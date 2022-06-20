//
//  CustomActionBlockHandler.swift
//  PurchaseViewCoordinator
//
//  Created by Anton Protko on 17.06.22.
//

public class CustomActionBlockHandler<Action: CustomAction>: CustomActionHandler {    
    let block: (Action) -> Void
    
    public init(block: @escaping (Action) -> Void) {
        self.block = block
    }
    
    public func handle(action: Action) {
        block(action)
    }
}

