//
//  OrderedCollectionUtility.swift
//  HealthStaffing
//
//  Created by Chawtech on 27/02/24.
//

import Foundation


struct OrderedDictionary<Key: Hashable, Value> {
    private var keys: [Key] = []
    private var dict: [Key: Value] = [:]
    
    mutating func insert(key: Key, value: Value) {
        if !keys.contains(key) {
            keys.append(key)
        }
        dict[key] = value
    }
    
    mutating func remove(key: Key) {
        if let index = keys.firstIndex(of: key) {
            keys.remove(at: index)
            dict.removeValue(forKey: key)
        }
    }
    
    func getValue(forKey key: Key) -> Value? {
        return dict[key]
    }
    
    func getOrderedKeys() -> [Key] {
        return keys
    }
}
