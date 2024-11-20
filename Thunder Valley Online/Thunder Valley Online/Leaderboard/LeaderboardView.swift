//
//  LeaderboardView.swift
//  Thunder Valley Online
//
//  Created by Dias Atudinov on 18.11.2024.
//

import SwiftUI

struct LeaderboardView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LeaderboardViewModel
    
    var body: some View {
        ZStack {
            
            ZStack {
                
                
                VStack(spacing: 0) {
                    Text("Leaderboard")
                        
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom, 15)
                   
                    HStack {
                        Text("Name")
                        Spacer()
                        Text("Score")
                            
                    }.padding(.horizontal, 20)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 270)
                    .padding(.bottom, 10)
                    
                    VStack(spacing: 10) {
                        ForEach(viewModel.otherPlayers.indices, id: \.self) { index in
                            ZStack {
                               
                                Image(.leaderboard)
                                    
                                HStack(spacing: 0) {
                                    Text("\(index + 1) - ")
                                    Text("\(viewModel.otherPlayers[index].name)")
                                    Spacer()
                                    Text("\(viewModel.otherPlayers[index].score)")
                                }.padding(.horizontal, 20)
                            }.frame(width: 270)
                        }
                        
                        ZStack {
                           
                            Image(.leaderboard)
                                
                            HStack(spacing: 0) {
                                Text("55 - ")
                                Text("YOU")
                                Spacer()
                                Text("\(viewModel.user.score)")
                            }.padding(.horizontal, 20)
                        }.frame(width: 270)
                    }.font(.system(size: 13))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.bottom)
                    
                    

                    
                }.background(
                    
                    BackgroundMenu()
                    //.frame(width: 260, height: 236)
                )
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

#Preview {
    LeaderboardView(viewModel: LeaderboardViewModel())
}
