//
//  GanttDiagram.swift
//  Visionary
//
//  Created by Campbell McGavin on 5/10/22.
//

import SwiftUI

struct GanttMainDateColumns: View {
    @Binding var shouldShowPadding: Bool
    var dateValues: [DateValue]
    var columnWidth: CGFloat
    var timeframeType: TimeframeType
    
    @EnvironmentObject var vm: ViewModel
    @State var offset = CGPoint.zero
    var body: some View {

            ScrollViewDirectionReader(axis: .horizontal, sensitivity: 6,  startingPoint: CGPoint(x: -200, y: 0), isPositive: $shouldShowPadding, offsetBind: $offset, shouldAnimate: false)
            .position(x:0,y:0)
        

            LazyHStack(alignment: .top, spacing:0){
                ForEach(dateValues){dateValue in
                    GanttMainDateColumn(dateValue: dateValue, frameWidth: columnWidth, timeframe: timeframeType)
                        .id(dateValue.id)
                        .frame(maxHeight:.infinity)
                }
            }
            .background(
                    
                VStack{
                    RoundedRectangle(cornerRadius:  (SizeType.medium.ToSize() + 10)/2)
                        .fill(Color.specify(color: .grey15))
                        .frame(maxWidth: .infinity)
                        .frame(height: SizeType.medium.ToSize() + 10)
                        .frame(alignment:.top)
                        .background(
                            Color.specify(color: .grey1)
                                .frame(height:300)
                                .frame(maxWidth: .infinity)
                                .offset(y:-160)
                        )
                    Spacer()
                }

            )
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .padding(.trailing,200)
            .padding(.leading,30)
            .frame(maxHeight:.infinity)
            .offset(y: GetOffset())
    }
    
    func GetOffset() -> CGFloat {
        print(offset.y)
        if offset.y > -105 {
            return offset.y + 110
        }
        else{
            return 0
        }
    }
}

struct GanttMainDateColumns_Previews: PreviewProvider {
    static var previews: some View {
        GanttMainDateColumns(shouldShowPadding: .constant(false), dateValues: [DateValue](), columnWidth: 100, timeframeType: .day)//, goalId: UUID())
    }
}
