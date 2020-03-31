//
//  Activities.swift
//  TrackPractice
//
//  Created by Bill Moriarty on 3/31/20.
//  Copyright © 2020 Bill Moriarty. All rights reserved.
//

import Foundation

class Activities: ObservableObject {
    @Published var currentActivies: [Activity] = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(self.currentActivies) {
                UserDefaults.standard.set(data, forKey: "theirStoredActivities")
            }
        }
    }
    
    init() {
        let data = UserDefaults.standard.data(forKey: "theirStoredActivies")
        let decoder = JSONDecoder()
        
        currentActivies = (try? decoder.decode([Activity].self, from: data ?? Data())) ?? []
    }
}
