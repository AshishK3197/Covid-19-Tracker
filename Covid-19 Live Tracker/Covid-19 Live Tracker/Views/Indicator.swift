//
//  Indicator.swift
//  Covid-19 Live Tracker
//
//  Created by Ashish Kumar on 13/06/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    
}
