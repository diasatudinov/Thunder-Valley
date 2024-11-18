//
//  AchievementsViewModel.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

class AchievementsViewModel: ObservableObject {
    @AppStorage("AchievementOne") var achievementOne: Bool = false
    @AppStorage("AchievementTwo") var achievementTwo: Bool = true
    @AppStorage("AchievementThree") var achievementThree: Bool = true

}
