//
//  Models.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
