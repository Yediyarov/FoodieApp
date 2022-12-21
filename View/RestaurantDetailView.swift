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
        
        ScrollView{
            VStack(alignment: .leading){
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay{
                        VStack{
                            Image(systemName: (restaurant.isFavorite ? "heart.fill" : "heart"))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                                .foregroundColor((restaurant.isFavorite ? .yellow : .white))
                                .padding()
                                .padding(.top, 40)
                                .font(.system(size: 30))
                        }
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text(restaurant.name)
                                .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                                .bold()
                            Text(restaurant.type)
                                .font(.system(.headline, design: .rounded))
                                .background(Color.black)
                                .padding(.all, 5)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                        .foregroundColor(.white)
                        .padding()
                    }
                
                Text(restaurant.description)
                    .padding()
                
                HStack(alignment: .top){
                    VStack(alignment: .leading){
                        Text("ADDRESS")
                            .font(.system(.headline, design: .rounded))
                        Text(restaurant.location)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading){
                        Text("PHONE")
                            .font(.system(.headline, design: .rounded))
                        Text(restaurant.phone)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                }
                .padding(.horizontal)
                
            }
                
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    dismiss()
                }){
                    Text("\(Image(systemName: "chevron.left"))")
                }
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RestaurantDetailView(restaurant: Restaurant(
                name: "Cafe Deadend",
                type: "Coffee & Tea",
                location: "Robert Robertson, 1234 NW Bobcat Lane, St. Robert",
                phone: "350-233423",
                description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.",
                image: "cafedeadend",
                isFavorite: true)
            )
        }
        .accentColor(.white)
    }
}
