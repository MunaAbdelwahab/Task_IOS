//
//  ProductsViewModel.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import Foundation
import CoreData
import UIKit

class ProductsViewModel: NSObject {
    private var productService: ProductsServiceProtocol

    init(productService: ProductsServiceProtocol = ProductsService()) {
        self.productService = productService
    }

    func getProducts() {
        productService.getProducts { success, model, error in
            if success, let products = model {
                self.deleteAllData("Productsl")
                self.fetchData(products: products)
            } else {
                print(error!)
                self.fetchCacheData()
            }
        }
    }
    
    var reloadTableView: (() -> Void)?
        
    var products = Products()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var productsL:[ProductsL]?
    
    var productCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func fetchCacheData() {
        do {
            self.productsL = try context.fetch(ProductsL.fetchRequest())
            reloadTableView?()
        } catch {
            
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(ProductsL.fetchRequest())
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func fetchData(products: Products) {
        self.products = products // Cache
        var vms = [ProductCellViewModel]()
        for product in products {
            let productsCache = ProductsL(context: self.context)
            productsCache.image = product.image.url
            productsCache.desc = product.productDescription
            productsCache.price = "\(product.price)"
            productsCache.imageH = Float(product.image.height)
            productsCache.imageW = Float(product.image.width)
            do {
                try self.context.save()
            } catch {
                
            }
            vms.append(createCellModel(product: product))
        }
        productCellViewModels = vms
    }
    
    func createCellModel(product: Product) -> ProductCellViewModel {
        let image = product.image.url
        let desc = product.productDescription
        let price = "\(product.price)" + "$"
        let imageHeight = CGFloat(product.image.height)
        let imageWidth = CGFloat(product.image.width)
        
        return ProductCellViewModel(image: image, desc: desc, price: price, imageHeight: imageHeight, imageWidth: imageWidth)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
}
