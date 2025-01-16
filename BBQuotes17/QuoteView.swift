//
//  QuoteView.swift
//  BBQuotes17
//
//  Created by Wai Zin Linn on 1/12/25.
//

import SwiftUI

struct QuoteView: View {
    
    let viewModel = ViewModel()
    let show: String
    
    var body: some View {
        GeometryReader { geo in //it will help us decide image sizes -> it will force to be at top left
            ZStack{
                // Background Image
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack{
                    
                    Spacer(minLength: 60)
                    
                    // Actual Quote itself by character
                    Text("\"\(viewModel.quote.quote)\"") //first .quote is quote type and second .quote is property
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.horizontal)
                        .minimumScaleFactor(0.5)
                    
                    // Character Image + Name Stack
                    ZStack(alignment: .bottom){
                        
                        // Character Image
                        AsyncImage(url: viewModel.character.images[0]){ image in
                            image
                                .resizable()
                                .scaledToFill()
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width/1.1, height: geo.size.height/1.8) // Character Image is making Z Stack too tall, prohbiting from seeing character name
                        
                        // Character Name
                        Text(viewModel.quote.character)
                            .foregroundStyle(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                    }
                    .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                    .clipShape(.rect(cornerRadius: 50))
                    
                    Spacer()
                    
                    Button{
                        Task{ //asynchronous work that can be run in synchronous environement like swift UI view
                            await viewModel.getData(for: show)
                        }
                    }label: { // why we do label is because we want the whole area to be considered as button
                        // to be part of button
                        Text("Get Random Quote")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.breakingBadGreen)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(color: .breakingBadYellow, radius: 5)
                    }
                    
                    Spacer(minLength: 95) // space need to take at least this much space, the reason we edit is to have some space up for navigation bar
                        
                }.frame(width: geo.size.width, height: geo.size.height) // to restrict vstack width to be just screen size width because image stretched it out
            }
            .frame(width: geo.size.width, height: geo.size.height) //workaround to center geometry reader
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
