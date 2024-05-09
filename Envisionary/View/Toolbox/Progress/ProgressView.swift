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
    @State var progressPoints: [ProgressPoint] = [ProgressPoint]()
    @State var highestChildren: Int = 0
    @State var affectedGoals = [Goal]()
    @State var chartMarks = [ChartMark]()
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            PieChart(title: "Status", chartMarks: chartMarks)
                .frame(maxWidth:.infinity)
                .frame(maxHeight:.infinity)
                .padding(4)
            LineChart(data: progressPoints, color: .purple, title: "Completion")
                .padding(4)

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
