//
//  TutorialPhases.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialPhases: View {
    @Binding var selectedContent: ContentViewType?
    let distance: CGFloat = 100
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(ContentViewType.allCases, id:\.self){
                    contentView in
                    SetupButton(contentView: contentView)
                }
                ForEach(ContentViewType.allCases, id:\.self){
                    contentView in
                    SetupLabel(contentView: contentView)
                }
            }
            .frame(maxWidth:.infinity)
        }
        .frame(height:360)
    }
    
    @ViewBuilder
    func SetupButton(contentView: ContentViewType) -> some View{
        let wiggle = GetIsWiggling(contentView: contentView)
        let offset = GetOffset(contentView: contentView)
        IconLabel(size: .largeish, iconType: contentView.toIcon(), iconColor: .grey10,circleColor: .purple)
            .opacity(wiggle ? 1.0 : 0.4)
            .scaleEffect(contentView == selectedContent ? 1.2 : 1.0)
            .wiggling(shouldWiggle: wiggle, intensity: 5.0)
            .wiggling(shouldWiggle: contentView == selectedContent, intensity: 6)
            .offset(x:offset.x,y:offset.y)
    }
    
    @ViewBuilder
    func SetupLabel(contentView: ContentViewType) -> some View{
        let wiggle = GetIsWiggling(contentView: contentView)
        let offset = GetOffset(contentView: contentView)
        
        if wiggle{
            
            Text(contentView.toString())
                .font(.specify(style: .caption))
                .foregroundColor(.specify(color: .grey8))
                .padding(4)
                .background(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)).foregroundColor(.specify(color: .grey2)))
                .wiggling(shouldWiggle: wiggle, intensity: 2.0)
                .offset(x: offset.x, y:offset.y + 55)
        }
    }
    
    func GetOffset(contentView: ContentViewType) -> Position {
        switch contentView {
        case .envision:
            return Position(x: 0, y: -distance)
        case .plan:
            return Position(x: distance * 0.95, y: -distance * 0.31)
        case .execute:
            return Position(x: distance * 0.6, y: distance * 0.8)
        case .journal:
            return Position(x: -distance * 0.6, y: distance * 0.8)
        case .evaluate:
            return Position(x: -distance * 0.95, y: -distance * 0.31)
        }
    }
    
    func GetIsWiggling(contentView: ContentViewType) -> Bool{
        if let selectedContent {
            if contentView == selectedContent {
                return true
            }
            return false
        }
        
        return true
    }
}

struct TutorialPhases_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPhases(selectedContent: .constant(nil))
    }
}
