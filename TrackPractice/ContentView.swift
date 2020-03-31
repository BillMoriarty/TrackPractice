//
//  ContentView.swift
//  TrackPractice
//
//  Created by Bill Moriarty on 3/10/20.
//  Copyright © 2020 Bill Moriarty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddActivitySheet = false
    @State private var showingEditActivitySheet = false
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

                                VStack{
                                Text(activ.title)
                                Text(activ.description)
                                    Text(String(activ.numberCompleted))
                                    .padding()
                                    
                                    Button(action:  {
                                        if let index = self.activitiesToTrack.currentActivies.firstIndex(where: { $0.id == activ.id }) {
                                            self.activitiesToTrack.currentActivies[index].numberCompleted+=1
                                        }//end if
                                    }){
                                        Text("tap me")
                                    }//end button text
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue, lineWidth: 2))
                                }//vstack styling
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue, lineWidth: 2))
                                
                                Spacer()
                                self.createEditActivityView(activ: activ)
                                Spacer()
                                
                                }//end Vstack
                        )//end naivgationLink
                            {
                            Text("\(activ.title)")
                            }
                        .listRowBackground(Color.green)
                    }//end List
                }//end vstack
                .navigationBarItems(trailing:
                    createAddActivityView()//end sheet connected to button
                )
                .navigationBarTitle("Activity Tracker")
            }//end nav view
            
            } //end Vstack
        }//end var body: some View {


    
    func addActivity(title: String, description: String)  {
        let newActivity = Activity(title: title, description: description)
        self.activitiesToTrack.currentActivies.append(newActivity)
       
        resetStringVariables()

    }//end addActivity
    
    func editActivity(newTitle: String, newDescription: String, activityToEdit: Activity) {
        if let index = self.activitiesToTrack.currentActivies.firstIndex(where: { $0.id == activityToEdit.id }) {
            self.activitiesToTrack.currentActivies[index].editYourActivity(newTitle: newTitle, newDescription: newDescription)
        }
        resetStringVariables()
    }
    
    fileprivate func resetStringVariables() {
        //reset the local strings to empty
        self.tempTitle = ""
        self.tempDescription = ""
    }
    
    fileprivate func createAddActivityView() -> some View {
        return //add activity button
            Button(action: {
                self.showingAddActivitySheet = true
            }) {
                Text("Add Activity")
            }.sheet(isPresented: $showingAddActivitySheet) {
                NavigationView {
                    Form {
                        TextField("Type a title", text: self.$tempTitle)
                        TextField("Type a description", text: self.$tempDescription)
                        Button("add activity") {
                            self.addActivity(title: self.tempTitle,description: self.tempDescription)
                            self.showingAddActivitySheet.toggle()
                        }//end button
                        Button("cancel"){
                            self.showingAddActivitySheet.toggle()
                        }//end button
                    }//end form
                }//end NavigationView
        }
    }
    
    fileprivate func createEditActivityView(activ: Activity) -> some View {
        return //edit activity button
            Button(action: {
                self.showingEditActivitySheet = true
            })
            {
                Text("Edit Activity")
            }.sheet(isPresented: self.$showingEditActivitySheet) {
                NavigationView {
                    Form {
                        TextField(activ.title, text: self.$tempTitle)
                        TextField(activ.description, text: self.$tempDescription)
                        Button("Save Edit") {
                            self.editActivity(newTitle: self.tempTitle,
                                              newDescription: self.tempDescription,
                                              activityToEdit:activ)
                            self.showingEditActivitySheet.toggle()
                        }//end button
                        Button("cancel"){
                            self.showingEditActivitySheet.toggle()
                        }//end button
                    }//end form
                }//end NavigationView
        }
    }
        
} //end struct ContentView: View
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
