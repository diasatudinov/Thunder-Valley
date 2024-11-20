import SwiftUI


struct RulesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ZStack {
            WVWrap(urlString: MontrealLinks.howToPlayURL)
            HStack {
                VStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.backBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            
        }
    }
}

#Preview {
    RulesView()
}

