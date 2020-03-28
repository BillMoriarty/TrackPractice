//
//  ContentView.swift
//  TrackPractice
//
//  Created by Bill Moriarty on 3/10/20.
//  Copyright © 2020 Bill Moriarty. All rights reserved.
//

import SwiftUI

//define a struct that holds a single activity
    //conforms to Identifiable
struct Activity: Identifiable {
    let id = UUID()
    
    var title: String
    var description: String
    var numberCompleted: Int = 0
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

//define a class that can holds an array of activities.
    //The class will need to conform to ObservableObject
    // use @Published for its property.
class Activities: ObservableObject {
    @Published var currentActivies: [Activity]
    
    init() {
        self.currentActivies = [Activity]()
        let newActivity = Activity(title: "default", description: "here ya go")
        currentActivies.append(newActivity)
    }
}

//a form to add new activities –
    // a title
    // a description should be enough
    /// -> having trouble with this part.. .maybe later - Present your adding form using sheet()

//a list of all activities they want to track
    //NavigationLink destination ->
        //tapping one of the activities should show a detail screen with
            // the description,
            // how many times they have completed it,
            // a button incrementing their completion count.

// they get to decide which activities they add, and track it however they want

//Your main listing and form should both be able to read the shared activities object.

//For an even bigger challenge, use Codable and UserDefaults to load and save all your data.


struct ContentView: View {
    @State private var showingSheet = false
    @State private var inputField = String()
    @State private var tempTitle = String()
    @State private var tempDescription = String()
    
    @ObservedObject var activitiesToTrack: Activities = Activities()
        
    var body: some View {
        VStack {
            NavigationView {
                VStack{
                    List(activitiesToTrack.currentActivies) { activ in
                        NavigationLink(destination:
                            VStack{
                                Text(activ.title)
                                Text(activ.description)
                                Text(String(activ.numberCompleted))
                                Button(action: {
                                    print("tapping")
                                    print(activ.id)
                                    
                                    if let index = self.activitiesToTrack.currentActivies.firstIndex(where: { $0.id == activ.id }) {
                                        self.activitiesToTrack.currentActivies[index].numberCompleted+=1
                                        }
                                    }) {Text("I did it again")}
                                }){
                            Text("\(activ.title)")
                            }
                    }//end foreach
                }//end vstack
                .navigationBarTitle("Track Some Topics")
                
            }//end nav view

            Button(action: {
                self.showingSheet = true
            }) {
                Text("Add Activity")
            }.sheet(isPresented: $showingSheet) {
                NavigationView {
                Form {
                    TextField("Type a title", text: self.$tempTitle)
                    TextField("Type a description", text: self.$tempDescription)
                    Button("add activity") {
                        self.addActivity(title: self.tempTitle,description: self.tempDescription)
                        self.showingSheet.toggle()
                        }//end button
                    }//end form
                    }//end NavigationView
                }//end sheet
            } //end Vstack
        }//end var body: some View {
    

    func addActivity(title: String, description: String)  {
        let newActivity = Activity(title: title, description: description)
        self.activitiesToTrack.currentActivies.append(newActivity)
        print("=============")
        print(self.activitiesToTrack.currentActivies.endIndex)
    }
    
    
} //end struct ContentView: View

    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
