//
//  ContentView.swift
//  FoodDeliverTest
//
//  Created by Muhammad Umair on 03/12/2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var currentId: String = ""
    @State var currentSelection : Status = .received
    var body: some View {
        NavigationStack{
            VStack{
                Picker(selection: $currentSelection) {
                    Text("Received")
                        .tag(Status.received)
                    Text("Progress")
                        .tag(Status.progress)
                    Text("Ready")
                        .tag(Status.ready)
                } label: {
                    
                }
                .labelsHidden()
                .pickerStyle(.segmented)

                
                Button("Start Activity"){
                    addLiveActivity()
                }
                .padding(.top)
                Button("Remove Activity"){
                    removeActivity()
                }
                .padding(.top)
            }
            .navigationTitle("Live Activities")
            .padding(25)
            .onChange(of: currentSelection) { newValue in
                // Retriving Activity from phone activities list for updation
                if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>)  in activity.id == currentId
                }){
                    print("Activity found")
                    
                    // Adding 2 second delay for testing
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        var updatedState = activity.contentState
                        updatedState.status = currentSelection
                        Task{
                            await activity.update(using:updatedState)
                        }
                    }
                    
                }
            }
        }
    }
    
    func removeActivity(){
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>)  in activity.id == currentId
        }){
            print("Starting to remove")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                
                Task{
                    await activity.end(using: activity.contentState,dismissalPolicy:.immediate)
                }
                print("Activity removed")
            }
            
        }
    }
    
    func addLiveActivity(){
        
        let orderAttributes = OrderAttributes(orderNumber: 26383, orderItems: "Burgers $ Ice Cones")
        
        let initialContentState = OrderAttributes.ContentState()
        
        
        do{
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, contentState: initialContentState, pushType: nil)
            currentId = activity.id
        
            print("Activity Added Successfully. id: \(activity.id)")

            
        }catch{
            print(error.localizedDescription)
        }
        
    }
}

