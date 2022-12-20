//
//  ActivityView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 19.12.22.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> some UIViewController {
        
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        
        return activityController
}
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
