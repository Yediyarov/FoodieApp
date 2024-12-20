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
    @State private var showReview = false
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var restaurant: Restaurant
    
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                Image(uiImage: UIImage(data: restaurant.image)!)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay{
                        VStack{
                        
                        HStack(alignment: .bottom) {
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
                            
                            if let rating = restaurant.rating, !showReview {
                                Image(rating.image)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .padding([.bottom, .trailing])
                                    .transition(.scale)
                            }
                        }
                        .animation(.spring(response: 0.2, dampingFraction: 0.3, blendDuration: 0.3
                                          ), value: restaurant.rating)
                        }
                    }
                
                Text(restaurant.summary)
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
                
                
                NavigationLink(destination:
                    MapView(location: restaurant.location)
                            .edgesIgnoringSafeArea(.all)
                ){
                    MapView(location: restaurant.location)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(20)
                .padding()
                
                
                Button{
                    self.showReview.toggle()
                }
                label:{
                   Text("Rate it")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .tint(Color("NavigationBarTitle"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 25))
                .controlSize(.large)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
            }
                
        }
        .ignoresSafeArea()
        .overlay(
            self.showReview ?
            ZStack{
                ReviewView(isDisplayed: $showReview, restaurant: restaurant)
                    .navigationBarHidden(true)
            }
            : nil
        )
        
        .onChange(of: restaurant) { _ in
            if self.context.hasChanges {
                try? self.context.save()
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar{
            
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    dismiss()
                }){
                    Text("\(Image(systemName: "chevron.left"))")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    restaurant.isFavorite.toggle()
                }) {
                    Image(systemName: restaurant.isFavorite ? "heart.fill": "heart")
                        .font(.system(size: 25))
                        .foregroundColor(restaurant.isFavorite ? .yellow : .white)
                        
                }
                .opacity(showReview ? 0 : 1)
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RestaurantDetailView(restaurant: (PersistenceController.testData?.first)!)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        .accentColor(.white)
    }
}
