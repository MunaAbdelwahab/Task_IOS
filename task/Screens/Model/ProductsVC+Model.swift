//
//  ProductsVC+Model.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let image: Image
    let price: Int
    let productDescription: String
}

// MARK: - Image
struct Image: Codable {
    let url: String
    let width, height: Int
}

typealias Products = [Product]
