//
//  ReviewView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 22.12.22.
//

import SwiftUI

struct ReviewView: View {
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            HStack{
                Spacer()
                VStack{
                    Button(action:{})
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
                }
            }
        }
    }
}
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
