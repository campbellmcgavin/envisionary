//
//  TutorialPhases.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialPhases: View {
    @Binding var canProceed: Bool
    @Binding var selectedContent: ContentViewType
    var isOverview = false
    let distance: CGFloat = 100
    @State var shouldWiggle = false
    
    var body: some View {
        let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
        
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
        .onAppear{
            canProceed = true
        }
        .onReceive(timer){
            _ in
            shouldWiggle = true
        }
    }
    
    @ViewBuilder
    func SetupButton(contentView: ContentViewType) -> some View{
        let wiggle = GetIsWiggling(contentView: contentView)
        let offset = GetOffset(contentView: contentView)
        IconLabel(size: .largeish, iconType: contentView.toIcon(), iconColor: .grey10, circleColor: .purple)
            .opacity(GetOpacity(contentView: contentView))
            .scaleEffect(!isOverview && contentView == selectedContent ? 1.2 : 1.0)
            .wiggling(shouldWiggle: wiggle && shouldWiggle, intensity: 5.0)
            .wiggling(shouldWiggle: contentView == selectedContent && shouldWiggle && !isOverview, intensity: 6)
            .offset(x:offset.x,y:offset.y)
    }
    
    func GetOpacity(contentView: ContentViewType) -> CGFloat{
        if isOverview{
            return 1.0
        }
        
        if contentView == selectedContent{
            return 1.0
        }
        
        return 0.4
    }
    
    @ViewBuilder
    func SetupLabel(contentView: ContentViewType) -> some View{
        let wiggle = GetIsWiggling(contentView: contentView)
        let offset = GetOffset(contentView: contentView)
        
        if wiggle{
            
            Text(contentView.toString())
                .font(.specify(style: .caption))
                .foregroundColor(.specify(color: .grey9))
                .padding(4)
                .background(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)).foregroundColor(.specify(color: .grey3)))
                .wiggling(shouldWiggle: wiggle && shouldWiggle, intensity: 2.0)
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
        
        if isOverview{
            return true
        }
        else if contentView == selectedContent {
            return true
        }
        return false
    }
}

struct TutorialPhases_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPhases(canProceed: .constant(true), selectedContent: .constant(.envision))
    }
}
