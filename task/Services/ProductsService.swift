//
//  ProductsService.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import Foundation

protocol ProductsServiceProtocol {
    func getProducts(completion: @escaping (_ success: Bool, _ results: Products?, _ error: String?) -> ())
}

class ProductsService: ProductsServiceProtocol {
    func getProducts(completion: @escaping (Bool, Products?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://api.npoint.io/2a0560747dd74084ee7c", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Products.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Products to model")
                }
            } else {
                completion(false, nil, "Error: Products GET Request failed")
            }
        }
    }
}
