//
//  SplashScreen.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/19/23.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isPresenting: Bool
    
    
    var body: some View {
        ZStack(alignment:.top){
            
            if isPresenting{
                
                ZStack(alignment:.center){
                    "logo".ToImage(imageSize: SizeType.extralarge.ToSize())
                    VStack{
                        Spacer()
                        Text("Envisionary").textCase(.uppercase)
                            .font(.specify(style: .logo))
                            .tracking(5)
                            .padding(.bottom,90)
                    }
                                   
                    }
                .foregroundColor(.specify(color: .grey10))
                .frame(alignment:.center)
                .frame(height:UIScreen.screenHeight)
                .frame(maxWidth: .infinity)
                .background(Color.specify(color: .purple))
                .cornerRadius(SizeType.cornerRadiusLarge.ToSize(), corners: [.bottomLeft,.bottomRight])
                .transition(.move(edge:.top))
            }

            
            }
        .ignoresSafeArea()
        .animation(.easeInOut(duration:1.0))
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(isPresenting: .constant(true))
    }
}
