//
//  LeaderboardViewModel.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

class LeaderboardViewModel: ObservableObject {
    
    @Published var user = Player(name: "YOU", score: 0) {
        didSet {
            saveUser()
        }
    }
    
    init() {
        user = loadUser() ?? Player(name: "YOU", score: 0)
    }
    
    let otherPlayers: [Player] = [
        Player(name: "Anna", score: 1500),
        Player(name: "John", score: 1400),
        Player(name: "Jane", score: 1300),
        Player(name: "Sam", score: 1250),
        Player(name: "Helena", score: 1200)
        
    ]
    
    func updateScore(score: Int) {
        if score > user.score {
            user.score = score
        }
    }
    
    private func saveUser() {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: "savedUser")
        }
    }
    
    private func loadUser() -> Player? {
        if let savedUserData = UserDefaults.standard.data(forKey: "savedUser") {
            let decoder = JSONDecoder()
            return try? decoder.decode(Player.self, from: savedUserData)
        }
        return nil
    }
}

struct Player: Hashable, Codable {
    var id = UUID()
    var name: String
    var score: Int
}
