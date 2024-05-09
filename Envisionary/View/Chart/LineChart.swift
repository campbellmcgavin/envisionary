//
//  LineChart.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/1/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    
    let data: [ ProgressPoint ]
    let color: CustomColor
    let title: String
    var yAxisStride: Int = 10
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.specify(style: .h5))
                .foregroundColor(.specify(color: .grey9))
            
            Chart {
                ForEach(data) { item in
                    
                    LineMark(
                        x: .value("Weekday", item.date),
                        y: .value("Value", item.progress)
                    )
                    .foregroundStyle(Color.specify(color: color))
                    .interpolationMethod(.catmullRom)
                    .lineStyle(.init(lineWidth: 2))
                    .symbol {
                        Circle()
                            .fill(Color.specify(color: color))
                            .frame(width: 12, height: 12)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(preset: .extended, values: .stride (by: .month)) { value in
                    AxisValueLabel(format: .dateTime.month())
                }
            }
            .chartYAxis {
                AxisMarks(preset: .extended, position: .leading, values: .stride(by:10))
            }
            .chartYScale(domain: [0,100])
            .padding(8)
            .modifier(ModifierForm(color:.grey15, radius: .cornerRadiusSmall))
            //            .preferredColorScheme(.dark)
        }
        .frame(height: 360)
    }
}

#Preview {
    
    LineChart(data: [
        ProgressPoint(date: Date(), progress: 0),
        ProgressPoint(date: Date().addingTimeInterval(10000), progress: 10),
        ProgressPoint(date: Date().addingTimeInterval(20000), progress: 30),
        ProgressPoint(date: Date().addingTimeInterval(30000), progress: 35),
        ProgressPoint(date: Date().addingTimeInterval(40000), progress: 60),
        ProgressPoint(date: Date().addingTimeInterval(50000), progress: 72),
        ProgressPoint(date: Date().addingTimeInterval(60000), progress: 93),
        ProgressPoint(date: Date().addingTimeInterval(70000), progress: 100)
        ], color: .purple, title: "Example")
}
