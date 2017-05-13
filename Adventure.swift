//
//  Adventure.swift
//  InteractiveStory
//
//  Created by David Anglin on 4/30/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation

struct Adventure {
    
    struct TitleConstants {
        static let stopInvestigate = "Stop and Investigate"
        static let homeToEarth = "Continue Home to Earth"
        static let exploreRover = "Explore the Rover"
        static let openCrate = "Open the Crate"
        static let homeTitle = "Continue Home to Earth"
        static let exploreCoordinates = "Explore the Coordinates"
        static let backToMars = "Head back to Mars"
        static let returnToEarth = "Return to Earth"
        static let faintLight = "Continue towards faint light"
        static let refillAndExplore = "Refill the ship and explore the rover"
        static let useKey = "Use the key"
    }
    
    static func story(withName name: String) -> Page {
        let returnTrip = Page(story: .returnTrip(name: name))
        let touchdown = returnTrip.addChoiceWith(title: TitleConstants.stopInvestigate, story: .touchDown)
        let homeward = returnTrip.addChoiceWith(title: TitleConstants.exploreRover, story: .homeward)
        let rover = touchdown.addChoiceWith(title: TitleConstants.exploreRover, story: .rover(name: name))
        let crate = touchdown.addChoiceWith(title: TitleConstants.openCrate, story: .crate)
        
        homeward.addChoiceWith(title: TitleConstants.backToMars, page: touchdown)
        let home = homeward.addChoiceWith(title: TitleConstants.homeToEarth, story: .home)
        
        let cave = rover.addChoiceWith(title: TitleConstants.exploreCoordinates, story: .cave)
        rover.addChoiceWith(title: TitleConstants.returnToEarth, page: home)
        
        cave.addChoiceWith(title: TitleConstants.faintLight, story: .droid(name: name))
        cave.addChoiceWith(title: TitleConstants.refillAndExplore, page: rover)
        
        crate.addChoiceWith(title: TitleConstants.exploreRover, page: rover)
        crate.addChoiceWith(title: TitleConstants.useKey, story: .monster)
        
        return returnTrip
    }
}
