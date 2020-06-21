//
//  Utility.swift
//  Covid-19 Live Tracker
//
//  Created by Ashish Kumar on 20/06/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class Utility{
    
    func getHeight(value: Int , height: CGFloat,lastValue: Int) -> CGFloat{
        
        if lastValue != 0{
            let converted = CGFloat(value) / CGFloat(lastValue)
             
            return converted * height
        }
        else{
            return 0
        }
    }
}


class Host: UIHostingController<ContentView>{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
