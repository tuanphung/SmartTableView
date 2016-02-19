//
//  ATSignal.swift
//  Pods
//
//  Created by Tuan Phung on 1/10/16.
//
//

import Foundation

public class ATSignal {
    public var identifier: String
    public var associatedObject: Any?
    
    init(identifider: String, associatedObject: Any?) {
        self.identifier = identifider
        self.associatedObject = associatedObject
    }
}
