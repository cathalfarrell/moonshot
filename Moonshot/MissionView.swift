//
//  MissionView.swift
//  Moonshot
//
//  Created by Cathal Farrell on 27/04/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct MissionView: View {

    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [CrewMember]

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)

                    Text(self.mission.description)
                        .padding()

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(Color.secondary)
                                }

                                Spacer()

                            }
                            .padding(.horizontal)
                        }
                        //This make sure the whole nav link doesnt get shaded tint blue - inc images
                        .buttonStyle(PlainButtonStyle())

                    }

                    Spacer(minLength: 25)

                }
            }

        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)

    }

    // MARK: On initialisation we merge the astronaut and mission data and figure out the astronauts: [CrewMember] here

    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()


        for member in mission.crew {
            if let match = astronauts.first(where: {
                $0.id == member.name
            }) {
                let crewMember = CrewMember(role: member.role, astronaut: match)
                matches.append(crewMember)
            } else {
                fatalError("Missing: \(member)")
            }
        }

        self.astronauts = matches
    }


}

struct MissionView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
