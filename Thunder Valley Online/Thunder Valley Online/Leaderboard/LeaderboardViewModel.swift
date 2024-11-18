//
//  LeaderboardViewModel.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import Foundation

class LeaderboardViewModel: ObservableObject {
    let otherPlayers: [Player] = [
        Player(name: "Anna", score: 1500),
        Player(name: "John", score: 1400),
        Player(name: "Jane", score: 1300),
        Player(name: "Sam", score: 1250),
        Player(name: "Helena", score: 1200)

    ]
}

struct Player: Hashable {
    let id = UUID()
    var name: String
    var score: Int
}
