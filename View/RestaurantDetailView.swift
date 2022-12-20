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
        
        ZStack(alignment: .top) {
            
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Color.black
                .frame(height:100)
                .opacity(0.8)
                .cornerRadius(20)
                .padding()
                .overlay{
                    VStack(spacing: 5){
                        Text(restaurant.name)
                        Text(restaurant.type)
                        Text(restaurant.location)
                    }
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.white)
                }
            
        }
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
