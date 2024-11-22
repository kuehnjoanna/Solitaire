//
//  ModelContextProvider.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 21.11.24.
//

import Foundation
import SwiftData
class ModelContextProvider {
    static let container: ModelContainer = {
        do {
            return try ModelContainer(for: GameResults.self)
        } catch {
            fatalError("Failed to configure SwiftData ModelContainer")
        }
    }()
    
}
