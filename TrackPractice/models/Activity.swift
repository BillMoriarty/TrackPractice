//
//  Activity.swift
//  TrackPractice
//
//  Created by Bill Moriarty on 3/31/20.
//  Copyright © 2020 Bill Moriarty. All rights reserved.
//

import Foundation

//define a struct that holds a single activity & conforms to Identifiable
struct Activity: Identifiable, Codable{
    let id = UUID()
    
    var title: String
    var description: String
    var numberCompleted: Int = 0
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
}
