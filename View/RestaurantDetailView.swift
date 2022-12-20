//
//  RestaurantDetailView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 20.12.22.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    var restaurant: Restaurant
    
    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .ignoresSafeArea()
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(
            name: "Cafe Deadend",
            type: "Cafe",
            location: "Hong Kong",
            image: "cafedeadend",
            isFavorite: true)
        )
    }
}
