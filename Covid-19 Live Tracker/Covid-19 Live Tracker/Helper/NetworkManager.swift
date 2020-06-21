//
//  NetworkManager.swift
//  Covid-19 Live Tracker
//
//  Created by Ashish Kumar on 21/06/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject{
    
    var home: Home?
    @Published var main: MainData!
    @Published var daily: [DailyData] = []
    
    func getData(indexValue: Int){
        var url = ""
        
        if indexValue == 0 {
            url = "https://corona.lmao.ninja/v2/countries/\(home?.country)?yesterday=false"
        }
        else{
            url = "https://corona.lmao.ninja/v2/all/?today"
        }
        
        let session = URLSession(configuration: .default)
        
        if let url = URL(string: url){
            let task = session.dataTask(with: url) { (data, _, error) in
                if(error != nil){
                    print(error?.localizedDescription)
                    return
                }
                else{
                    if let safeData = data{
                        do{
                            let decodedData = try JSONDecoder().decode(MainData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.main = decodedData
                            }
                            
                        }
                        catch{
                            print(error)
                        }
                    }
                    
                }
                
            }
            task.resume()
        }
        
        
        var url1 = ""
        
        if indexValue == 0 {
            url1 = "https://corona.lmao.ninja/v2/historical/\(home?.country)?lastdays=7"
        }else {
            url1 = "https://corona.lmao.ninja/v2/historical/all?lastdays=7"
        }
        
        let session1 = URLSession(configuration: .default)
        
        if let url = URL(string: url1){
            let task = session1.dataTask(with: url) { (data, _, error) in
                if(error != nil){
                    print(error?.localizedDescription)
                    return
                }
                else{
                    var count = 0
                    var cases : [String: Int] = [:]
                    if indexValue == 0{
                        if let safeData = data{
                            do {
                                let decodedData = try JSONDecoder().decode(MyCountry.self, from: safeData)
                                cases = decodedData.timeline["cases"]!
                            } catch  {
                                print(error)
                            }
                        }
                    }
                    else{
                        if let safeData = data{
                            do{
                                let decodedData = try JSONDecoder().decode(Global.self, from: safeData)
                                cases = decodedData.cases
                            }
                            catch{
                                print(error)
                            }
                        }
                    }
                 
                    for item in cases{
                        self.daily.append(DailyData(id: count, day: item.key, cases: item.value))
                        count += 1
                    }
                    
                    self.daily.sort { (t, t1) -> Bool in
                        if t.day < t1.day{
                            return true
                        }else{
                            return false
                        }
                    }
                    
                    
                    self.home?.last = self.daily.last?.cases as! Int
                    
                    
                }
                
            }
            task.resume()
          
        }
        
    }
}
