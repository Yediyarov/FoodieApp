//
//  ContentView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 15.12.22.
//

import SwiftUI

struct RestaurantListView: View {
    
    @State private var showNewRestaurant = false
    
    @FetchRequest(
        entity: Restaurant.entity(),
        sortDescriptors: [])
    
    var restaurants: FetchedResults<Restaurant>
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants.indices, id: \.self) { index in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination:
                            RestaurantDetailView(restaurant: restaurants[index])) {
                                EmptyView()
                            }
                        .opacity(0)
                        BasicTextImageRow(restaurant: restaurants[index])
                    }
                        .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                            Button{
                                
                            } label:{
                                Image(systemName: "heart")
                            }
                            .tint(.green)
                            
                            Button{
                                
                            } label:{
                                Image(systemName: "square.and.arrow.up")
                            }
                            .tint(.orange)
                        })
                }
                .onDelete(perform: { indexSet in
                        restaurants.remove(atOffsets: indexSet)
                })
                
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            .navigationTitle("Foodie")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                Button(action: {
                    self.showNewRestaurant = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
        .accentColor(.primary)
    }
}

struct BasicTextImageRow: View {
    
    // MARK: - Binding
    
    @ObservedObject var restaurant: Restaurant
    
    // MARK: - State variables
    
    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            
            if let imageData = restaurant.image {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .frame(width: 120, height: 118)
                    .cornerRadius(20)
            }
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .contextMenu{
            Button(action: {
                self.showError.toggle()
            }) {
                HStack{
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button(action: {
                self.restaurant.isFavorite.toggle()
            }) {
                HStack{
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button(action: {
                self.showOptions.toggle()
            }){
                HStack{
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }
        .sheet(isPresented: $showOptions) {
            
            let defaultText = "Just checking in at \(restaurant.name)"
            
            if let imageData = restaurant.image,
               let imageToShare = UIImage(data: imageData) {
                ActivityView(activityItems: [defaultText, imageToShare])
            } else {
                ActivityView(activityItems: [defaultText])
            }
        }
    }
}

struct FullImageRow: View {
    
    // MARK: - Binding

    @ObservedObject var restaurant: Restaurant

    // MARK: - State variables

    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            if let imageData = restaurant.image {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .cornerRadius(20)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                        .font(.system(.title2, design: .rounded))
                        
                    Text(restaurant.type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(restaurant.location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                if restaurant.isFavorite {
                    Spacer()
                    
                    VStack(){
                        Image(systemName: "heart.fill")
                            .foregroundColor(.yellow)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .contextMenu{
            Button(action: {
                self.showError.toggle()
            }) {
                HStack{
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button(action: {
                self.restaurant.isFavorite.toggle()
            }) {
                HStack{
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button(action: {
                self.showOptions.toggle()
            }){
                HStack{
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }
        .sheet(isPresented: $showOptions) {
            
            let defaultText = "Just checking in at \(restaurant.name)"
            
            if let imageData = restaurant.image,
               let imageToShare = UIImage(data: imageData) {
                ActivityView(activityItems: [defaultText, imageToShare])
            } else {
                ActivityView(activityItems: [defaultText])
            }
        }
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
        
        RestaurantListView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Restaurant List View (Dark)")
        
//        BasicTextImageRow(restaurant: .constant(Restaurant(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", phone: "123-123123", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: true)))
//            .previewLayout(.sizeThatFits)
//            .previewDisplayName("BasicTextImageRow")
//                
//        FullImageRow(restaurant: .constant(Restaurant(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", phone: "123-123123", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: true)))
//            .previewLayout(.sizeThatFits)
//            .previewDisplayName("FullImageRow")
    }
}
