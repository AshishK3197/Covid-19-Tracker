//
//  ApiManager.swift
//  Covid-19 Live Tracker
//
//  Created by Ashish Kumar on 13/06/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

//class ApiManager : ObservableObject{
//
//    @Published var myCountryData = [MainData]()
//    @Published var globalData = [MainData]()
//    let home = Home()
//
//    func getData(){
//        var url = ""
//
//        if home.index == 0 {
//            url = "https://corona.lmao.ninja/v2/countries/usa?yesterday=false"
//        }
//        else{
//            url = "https://corona.lmao.ninja/v2/all/?today"
//        }
//
//        let session = URLSession(configuration: .default)
//
//        if let url = URL(string: url){
//            let task = session.dataTask(with: url) { (data, _, error) in
//                if(error != nil){
//                    print(error?.localizedDescription)
//                    return
//                }
//                else{
//                    if let safeData = data{
//                        do{
//                            let decodedData = try JSONDecoder().decode(MainData.self, from: safeData)
//                            DispatchQueue.main.async {
//                                self.data.append(decodedData)
//                            }
//
//                        }
//                        catch{
//                            print(error)
//                        }
//                    }
//
//                }
//
//            }
//            task.resume()
//        }
//
//
//    }
//}
//
//
