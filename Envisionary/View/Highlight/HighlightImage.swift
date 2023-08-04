//
//  HighlightImage.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/26/23.
//

import SwiftUI

struct HighlightImage: View {
    @Binding var selectedImage: UIImage?
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    @State var shouldClearImage = false
    var body: some View {
        
        if let selectedImage {
            ZStack{
                Rectangle()
                    .foregroundColor(.specify(color: .grey0))
                    .opacity(0.90)
                    .ignoresSafeArea()
                
                
                GeometryReader { proxy in
                    Image(uiImage: selectedImage)
                        .resizable()
//                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                }
                
                HStack{
                    Spacer()
                    VStack{
                        IconButton(isPressed: $shouldClearImage, size: .medium, iconType: .cancel, iconColor: .grey0, circleColor: .grey10)
                            .shadow(color:.specify(color: .grey0), radius: 10)
                            .padding()
                            .padding(.top,50)
                        Spacer()
                    }
                    
                }
                .onChange(of: shouldClearImage){
                    _ in
                    withAnimation{
                        self.selectedImage = nil
                    }
                }
                .ignoresSafeArea()
            }

        }
    }
}

struct HighlightImage_Previews: PreviewProvider {
    static var previews: some View {
        HighlightImage(selectedImage: .constant(nil))
    }
}
