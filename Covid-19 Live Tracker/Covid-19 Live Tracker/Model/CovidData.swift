//
//  CovidData.swift
//  Covid-19 Live Tracker
//
//  Created by Ashish Kumar on 13/06/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct DailyData : Identifiable {
    var id: Int
    var day: String
    var cases: Int
}

struct MainData: Decodable{
    var deaths: Int
    var recovered: Int
    var active: Int
    var critical: Int
    var cases: Int
}

struct MyCountry : Decodable{
    var timeline : [String: [String: Int]]
}

struct Global: Decodable {
    var cases: [String: Int]
}

