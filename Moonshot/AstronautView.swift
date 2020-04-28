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
                }
            }
            .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)

        }
    }
}

struct AstronautView_Previews: PreviewProvider {

    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
