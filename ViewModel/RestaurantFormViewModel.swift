//
//  RestaurantFormViewModel.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 11.01.23.
//

import Foundation
import Combine
import UIKit


class RestaurantFormViewModel: ObservableObject {
// Input
    @Published var name: String = ""
    @Published var type: String = ""
    @Published var location: String = ""
    @Published var phone: String = ""
    @Published var description: String = ""
    @Published var image: UIImage = UIImage()

    init(restaurant: Restaurant? = nil) {

        if let restaurant = restaurant {
            self.name = restaurant.name
            self.type = restaurant.type
            self.location = restaurant.location
            self.phone = restaurant.phone
            self.description = restaurant.summary
            self.image = UIImage(data: restaurant.image) ?? UIImage()
        }
    }
}
