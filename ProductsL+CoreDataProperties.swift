//
//  ProductsL+CoreDataProperties.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//
//

import Foundation
import CoreData


extension ProductsL {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsL> {
        return NSFetchRequest<ProductsL>(entityName: "ProductsL")
    }

    @NSManaged public var image: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: String?
    @NSManaged public var imageH: Float
    @NSManaged public var imageW: Float

}

extension ProductsL : Identifiable {

}
