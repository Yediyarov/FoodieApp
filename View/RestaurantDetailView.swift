//
//  RestaurantDetailView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 20.12.22.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    /* The dismiss environment value was first introduced in iOS 15. If your app supports lower version of iOS, you can replace it with presentationMode :
        
        @Environment(\.presentationMode) var presentationMode
        
        And, you can call the dismiss() like this:
        
        presentationMode.wrappedValue.dismiss()
     */
   
    @Environment(\.dismiss) var dismiss
    
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
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    dismiss()
                }){
                    Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                }
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
            phone: "350-233423",
            description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.",
            image: "cafedeadend",
            isFavorite: true)
        )
    }
}
