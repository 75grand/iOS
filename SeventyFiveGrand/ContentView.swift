//
//  ContentView.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var tab = "home"

    var body: some View {
        TabView(selection: $tab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag("home")
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }.tag("calendar")
            
            // Text("MacPass, PO box number and combination, reminder to check PO box")
            Group {
                // 101118980
                Text("Abc")
            }
                .tabItem {
                    Image(systemName: "person.text.rectangle.fill")
                    Text("Profile")
                }.tag("profile")
        }//.tint(.cyan)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
