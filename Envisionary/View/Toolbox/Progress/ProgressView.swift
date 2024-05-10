//
//  ProgressView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/27/24.
//

import SwiftUI
import Charts

struct ProgressView: View {
    let id: UUID
    let objectType: ObjectType
    var isCompact = false
    @State var progressPoints: [ProgressPoint] = [ProgressPoint]()
    @State var highestChildren: Int = 0
    @State var affectedGoals = [Goal]()
    @State var chartMarks = [ChartMark]()
    @EnvironmentObject var vm: ViewModel
    @State var viewOptions = ["Graph","Chart"]
    @State var selectedView = "Chart"
    var body: some View {
        HStack{
            if isCompact{
                SelectableHStack(fieldValue: $selectedView, options: $viewOptions, fontSize: .subCaption, color: .grey4)
                    .frame(width:190)
                    .rotationEffect(.degrees(-90))
                    .frame(width:40)
                    .padding(.leading,8)
            }
            
            VStack{
                if !isCompact || selectedView == "Chart"{
                    PieChart(title: "Status", chartMarks: chartMarks, isCompact: isCompact)
                        .if(!isCompact){
                            view in
                            view
                                .frame(maxWidth:.infinity)
                        }
                        .frame(maxHeight:.infinity)
                        .padding(4)
                }
                if !isCompact || selectedView == "Graph"{
                    LineChart(data: progressPoints, color: .purple, title: "Completion", isCompact: isCompact)
                        .padding(4)
                    if isCompact{
                        Spacer()
                    }
                }
            }

        }

        .onAppear{
            progressPoints = vm.ListProgressPoints(parentId: id)
            highestChildren = progressPoints.max(by: {$0.amount < $1.amount })?.amount ?? 1
            affectedGoals = vm.ListAffectedGoals(id: id)
            
            let lateGoals = affectedGoals.filter({$0.endDate != nil && $0.endDate! < Date.now && $0.progress < 100})
            
            chartMarks.removeAll()
            chartMarks.append(ChartMark(title: StatusType.notStarted.toString(), count: affectedGoals.filter({!lateGoals.contains($0) && $0.progress < 1}).count, color: .grey5))
            chartMarks.append(ChartMark(title: StatusType.inProgress.toString(), count: affectedGoals.filter({!lateGoals.contains($0) && $0.progress > 0 && $0.progress < 100}).count, color: .blue))
            
            chartMarks.append(ChartMark(title: StatusType.completed.toString(), count: affectedGoals.filter({$0.progress > 99}).count, color: .green))
            chartMarks.append(ChartMark(title: "Late", count: lateGoals.count, color: .red))
        }
    }
}

#Preview {
    ProgressView(id: UUID(), objectType: .goal)
}
