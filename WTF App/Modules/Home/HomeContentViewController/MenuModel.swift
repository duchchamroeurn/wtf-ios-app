//
//  MenuModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import Foundation

struct MenuModel: Codable {
    let _id: String
    let name: String?
    let image: String?
    let description: String?
    let price: Double?
    let category: CategoryModel?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        
        do {
            _ = try container.decodeIfPresent(String.self, forKey: .category)
            self.category = nil
        } catch {
            self.category = try container.decodeIfPresent(CategoryModel.self, forKey: .category)
        }
    }
}
