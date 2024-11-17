//
//  ApiRepository.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import Foundation
protocol ApiRepository{
    func fetchRandomImages() async throws -> [Hit]
}
