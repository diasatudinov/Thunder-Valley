//
//  AchievementsView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

struct AchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AchievementsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                
                ZStack {
                    
                    if isLandscape {
                        // Горизонтальная ориентация
                        VStack(spacing: 0) {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Energy Master")
                                        .font(.system(size: 32))
                                    Text("collect 50 spheres in one game")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                Image(viewModel.achievementOne ? .achiveCheck : .achiveCross)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                            }.padding(.horizontal, 30)
                                .foregroundColor(.white)
                                .padding(.top, 30)
                                
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.menuLine)
                                .padding(.vertical, 10)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Overload")
                                        .font(.system(size: 32))
                                    Text("activate overload mode 3 times in one session")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                Image(viewModel.achievementTwo ? .achiveCheck : .achiveCross)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                            }.padding(.horizontal, 30)
                                .foregroundColor(.white)
                             
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.menuLine)
                                .padding(.vertical, 10)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Thunder Survivor")
                                        .font(.system(size: 32))
                                    Text("last more than 2 minutes")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                Image(viewModel.achievementThree ? .achiveCheck : .achiveCross)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                            }.padding(.horizontal, 30)
                                .foregroundColor(.white)
                                .padding(.bottom, 30)
                            //
                            
                            
                            
                        }.frame(width: 484).background(
                            
                            BackgroundMenu()
                        )
                    } else {
                        VStack(spacing: 0) {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Energy Master")
                                        .font(.system(size: 32))
                                    Text("collect 50 spheres in one game")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                Image(viewModel.achievementOne ? .achiveCheck : .achiveCross)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                            }.padding(.horizontal, 30)
                                .foregroundColor(.white)
                                .padding(.top, 30)
                            
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.menuLine)
                                .padding(.vertical, 10)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Overload")
                                        .font(.system(size: 32))
                                    Text("activate overload mode 3 times in one session")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                Image(viewModel.achievementTwo ? .achiveCheck : .achiveCross)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                            }.padding(.horizontal, 30)
                                .foregroundColor(.white)
                            // .frame(width: 423)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.menuLine)
                                .padding(.vertical, 10)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Thunder Survivor")
                                        .font(.system(size: 29))
                                    Text("last more than 2 minutes")
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                
                                Image(viewModel.achievementThree ? .achiveCheck : .achiveCross)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                            }.padding(.horizontal, 30)
                                .foregroundColor(.white)
                                .padding(.bottom, 30)
                            // .frame(width: 423)
                            
                            
                            
                        }.background(
                            
                            BackgroundMenu()
                        )
                    }
                    
                }.textCase(.uppercase)
                
                VStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.backBtn)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        
                        
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                
            }.background(
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
            )
        }
    }
}

#Preview {
    AchievementsView(viewModel: AchievementsViewModel())
}
