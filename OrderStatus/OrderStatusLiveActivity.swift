//
//  OrderStatusLiveActivity.swift
//  OrderStatus
//
//  Created by Muhammad Umair on 03/12/2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct OrderStatusLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderAttributes.self) { context in
            // Lock screen/banner UI goes here
            ZStack{
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.green.gradient)
                
                // Live activity UI
                VStack{
                    HStack{
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text("In Store Pickup")
                            .foregroundColor(.white.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Image("burger")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .background{
                                    Circle()
                                        .fill(Color("Green").gradient)
                                        .padding(-2)
                                }
                                .background{
                                    Circle()
                                        .stroke(.white, lineWidth: 1.5)
                                        .padding(-2)
                                }
                            
                            Image("cone")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .background{
                                    Circle()
                                        .fill(Color.green)
                                        .padding(-2)
                                }
                                .background{
                                    Circle()
                                        .stroke(.white, lineWidth: 1.5)
                                        .padding(-2)
                                }
                        }
                        
                        
                    }
                    
                    HStack(alignment: .bottom, spacing: 0){
                        VStack (alignment: .leading, spacing: 4){
                            Text(message(status: context.state.status))
                                .font(.title3)
                                .foregroundColor(.white)
                            Text(subMessage(status: context.state.status))
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: 13)
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            ForEach(Status.allCases, id: \.self){type in
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundColor(context.state.status == type ? Color.green : .white.opacity(0.7))
                                    .frame(width: context.state.status == type ? 45 : 32, height: context.state.status == type ? 45 : 32)
                                    .background{
                                        Circle()
                                            .fill(context.state.status == type ? .white : .gray.opacity(0.5))
                                    }
                                    .background(alignment: .bottom){
                                        BottomArrow(status: context.state.status, type: type)
                                    }
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .overlay(alignment: .bottom){
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height: 2)
                                .offset(y: 12)
                                .padding(.horizontal, 27.5)
                        }
                        .padding(.leading, 15)
                        .padding(.trailing, -10)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
                }
                .padding(15)
            }
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
    
    @ViewBuilder
    func BottomArrow(status: Status, type: Status) -> some View{
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment: .bottom){
                Circle()
                    .fill(.white)
                    .frame(width: 5, height: 5)
                    .offset(y: 13)
            }
    }
    
    func message(status: Status) -> String{
        switch status{
        case .received:
            return "Order Received"
        case .progress:
            return "Order in progress"
        case .ready:
            return "Order ready"
        }
    }
    
    func subMessage(status: Status) -> String{
        switch status{
        case .received:
            return "We just received your order"
        case .progress:
            return "We are hand crafting your order"
        case .ready:
            return "We crafted your order"
        }
    }
}
