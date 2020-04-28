//
//  AstronautView.swift
//  Moonshot
//
//  Created by Cathal Farrell on 27/04/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct AstronautView: View {

    let astronaut: Astronaut

    let astronautMissions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1) //Gives priority to expand the text rather than clip with ... elipsis

                    ForEach(self.astronautMissions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.primary, lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(Color.secondary)
                            }

                            Spacer()

                        }
                        .padding(.horizontal)

                    }
                }
            }
            .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)

        }
    }

    /*
    Modify AstronautView to show all the missions this astronaut flew on.
    */
    init(astronaut: Astronaut) {
        self.astronaut = astronaut

        let missions: [Mission] = Bundle.main.decode("missions.json")

        //Search all missions for this astronaut, ensure uppercase comparison
        //Only surname found on mission crew role

        var matches = [Mission]()

        for mission in missions {
            for member in mission.crew {
                if self.astronaut.name.uppercased().contains(member.name.uppercased()){
                    matches.append(mission)
                }
            }
        }

        self.astronautMissions = matches
        print("Missions that \(self.astronaut.name) flew in: \(self.astronautMissions.count)")
        for mission in self.astronautMissions {
            print("MISSION: \(mission.displayName)")
        }
    }

}

struct AstronautView_Previews: PreviewProvider {

    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
