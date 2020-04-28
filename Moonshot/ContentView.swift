//
//  ContentView.swift
//  Moonshot
//
//  Created by Cathal Farrell on 27/04/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//
//  Project 8  #100DaysOfSwiftUI
//  https://www.hackingwithswift.com/100/swiftui/39

import SwiftUI

struct ContentView: View {

    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var isShowingDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        //.aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.isShowingDate ? mission.formattedLaunchDate : mission.formattedCrew)
                    }
                }
            }.navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button("Show Date/Crew") {
                self.isShowingDate.toggle()
            })

        }
    }

    /*
     Challenge 3
     Make a bar button in ContentView that toggles between showing launch dates and showing crew names.
     */
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      Group {
         ContentView()
            .environment(\.colorScheme, .light)

         ContentView()
            .environment(\.colorScheme, .dark)
      }
   }
}
