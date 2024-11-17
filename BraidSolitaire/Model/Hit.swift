//
//  Object.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 13.11.24.
//

import Foundation
struct Hit:  Codable, Equatable{
    var id: Int?
    var imageHeight: Int?
    var imageSize: Int
    var imageWidth: Int?
    var largeImageURL: String?
    var pageURL: String?
}
