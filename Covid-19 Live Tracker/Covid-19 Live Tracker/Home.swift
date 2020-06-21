//
//  Home.swift
//  Covid-19 Live Tracker
//
//  Created by Ashish Kumar on 12/06/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    var utility = Utility()
    
    //    @EnvironmentObject var networkManager : NetworkManager
    @State var index = 0
    @State var main : MainData!
    @State var daily: [DailyData] = []
    @State var last : Int = 0
    @State var country: String = "usa"
    @State var alert: Bool = false
    
    var body: some View {
        VStack{
            if self.main != nil && !self.daily.isEmpty{
                VStack{
                    VStack(spacing: 18){
                        //Statistics and Country Switch Button
                        HStack{
                            Text("Statistics")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                self.Dialog()
                            }) {
                                Text(self.country.uppercased())
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.top, ((UIApplication.shared.windows.first?.safeAreaInsets.top)!) + 15)
                        
                        // Country and Global Tab
                        HStack{
                            Button(action: {
                                self.index = 0
                                self.main = nil
                                self.daily.removeAll()
                                self.getData()
                                
                            }) {
                                Text("My country")
                                    .foregroundColor(self.index == 0 ? .black : .white)
                                    .padding(.vertical, 12)
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                                
                            }
                            .background(self.index == 0 ? Color.white : Color.clear)
                            .clipShape(Capsule())
                            
                            Button(action: {
                                self.index = 1
                                self.main = nil
                                self.daily.removeAll()
                                self.getData()
                            }) {
                                Text("Global")
                                    .foregroundColor(self.index == 1 ? .black : .white)
                                    .padding(.vertical, 12)
                                    .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                                
                            }
                            .background(self.index == 1 ? Color.white : Color.clear)
                            .clipShape(Capsule())
                            
                        }
                        .background(Color.black.opacity(0.25))
                        .clipShape(Capsule())
                        .padding(.top, 10)
                        
                        //Affected and deaths
                        HStack(spacing: 15){
                            VStack(spacing: 12){
                                Text("Affected")
                                    .fontWeight(.bold)
                                
                                Text("\(self.main.cases)")
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                            .background(Color("affected"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12){
                                Text("Deaths")
                                    .fontWeight(.bold)
                                
                                Text("\(self.main.deaths)")
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 30)
                            .background(Color("death"))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        
                        
                        //Recovered, active and Serios tabs
                        HStack(spacing: 15){
                            VStack(spacing: 12){
                                Text("Recovered")
                                    .fontWeight(.bold)
                                
                                Text("\(self.main.recovered)")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width / 3) - 30)
                            .background(Color("recovered"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12){
                                Text("Active")
                                    .fontWeight(.bold)
                                
                                Text("\(self.main.active)")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width / 3) - 30)
                            .background(Color("active"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12){
                                Text("Critical")
                                    .fontWeight(.bold)
                                
                                Text("\(self.main.critical)")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width / 3) - 30)
                            .background(Color("serious"))
                            .cornerRadius(12)
                        }
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 45)
                    .background(Color("bg"))
                    
                    
                    //Bottom View Trend
                    VStack(spacing: 15){
                        
                        HStack{
                            Text("Last 7 Days")
                                .font(.title)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        
                        HStack{
                            ForEach(self.daily) { i in
                                
                                VStack(spacing: 10){
                                    Text("\(i.cases / 1000)K")
                                        .lineLimit(1)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    GeometryReader{ g in
                                        VStack{
                                            
                                            Spacer(minLength: 0)
                                            Rectangle()
                                                .fill(Color("death"))
                                                .frame(width: 15, height: self.utility.getHeight(value: i.cases, height: g.frame(in : .global).height, lastValue: self.last ))
                                        }
                                        
                                    }
                                    
                                    Text("\(i.day)")
                                        .lineLimit(1)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, -30)
                    .offset(y :  -30)
                }
            }
            else{
                Indicator()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("Invalid Country Name"), dismissButton: .destructive(Text("OK")))
        })
            .onAppear {
                self.getData()
        }
    }
    
}

//MARK: - Function to API Calls and Create Alert Box

extension Home {
    func getData(){
        var url = ""
        
        if self.index == 0 {
            url = "https://corona.lmao.ninja/v2/countries/\(self.country)?yesterday=false"
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
        
        if self.index == 0 {
            url1 = "https://corona.lmao.ninja/v2/historical/\(self.country)?lastdays=7"
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
                    if self.index == 0{
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
                    
                    
                    self.last = self.daily.last?.cases as! Int
                    
                    
                }
                
            }
            task.resume()
            
        }
        
    }
    
    
    //Alert Box to give Country Name
    func Dialog(){
        
        let alert = UIAlertController(title: "Country", message: "Type a Country", preferredStyle: .alert)
        alert.addTextField { (_) in
            
        }
        
        let action = UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            for country in countryList{
                if country.lowercased() == alert.textFields![0].text!.lowercased(){
                    self.country = alert.textFields![0].text!.lowercased()
                    self.main = nil
                    self.daily.removeAll()
                    self.getData()
                    return
                }
            }
            self.alert.toggle()
        })
        
        let action2 = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
        })
        
        alert.addAction(action)
        alert.addAction(action2)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
