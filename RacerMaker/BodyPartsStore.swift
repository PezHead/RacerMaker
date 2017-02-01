//
//  BodyPartsStore.swift
//  RacerMaker
//
//  Created by David Bireta on 12/26/16.
//  Copyright © 2016 David Bireta. All rights reserved.
//

import UIKit

class BodyPartsStore {
    static let shared = BodyPartsStore()
    
    private init() {
        // Nothing here!
    }
    
    func heads() -> [UIColor] {
        return [.blue, .green, .red, .black]
    }
    
    func bodies() -> [UIColor] {
        return [.black, .lightGray, .gray]
    }
    
    func feet() -> [UIColor] {
        return [.orange, .cyan, .magenta]
    }
}
