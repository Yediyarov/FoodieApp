//
//  ReviewView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 22.12.22.
//

import SwiftUI

struct ReviewView: View {

    @Binding var isDisplayed: Bool
    var restaurant: Restaurant
    @State private var showRatings = false
    
    var body: some View {
        ZStack{
            
            Image(uiImage: UIImage(data: restaurant.image)!)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Color.black
                .ignoresSafeArea()
                .opacity(0.6)
                .background(.ultraThinMaterial)

            HStack{
                Spacer()
                VStack{
                    Button(action:{
                        withAnimation(.easeOut(duration: 0.3)) {
                                self.isDisplayed = false
                            }
                    })
                    {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .padding()
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading){
                ForEach(Restaurant.Rating.allCases, id: \.self){
                    rating in
                    
                    HStack{
                        Image(rating.image)
                        Text(rating.rawValue.capitalized)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .opacity(showRatings ? 1.0 : 0)
                    .offset(x: showRatings ? 0 : 1000)
                    .animation(.easeOut.delay(Double(Restaurant.Rating.allCases.firstIndex(of:rating)!) * 0.05), value: showRatings)
                    .onTapGesture {
                        self.restaurant.rating = rating
                        self.isDisplayed = false
                    }
                }
            }
        }
        .onAppear{
            showRatings.toggle()
        }
    }
}


struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(isDisplayed: .constant(true), restaurant: (PersistenceController.testData?.first)!)
    }
}
