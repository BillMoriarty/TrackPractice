//
//  ContentView.swift
//  TrackPractice
//
//  Created by Bill Moriarty on 3/10/20.
//  Copyright © 2020 Bill Moriarty. All rights reserved.
//

import SwiftUI

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
                                    if let index = self.activitiesToTrack.currentActivies.firstIndex(where: { $0.id == activ.id }) {
                                        self.activitiesToTrack.currentActivies[index].numberCompleted+=1
                                        }
                                    }) {Text("I did it again")}
                                }){
                            Text("\(activ.title)")
                            }
                    }//end List
                }//end vstack
                .navigationBarTitle("Practice Tracker")
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
                        Button("cancel"){
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
        
        //reset the local strings to empty 
        self.tempTitle = ""
        self.tempDescription = ""

    }//end addActivity
        
} //end struct ContentView: View
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
