//
//  PieChart.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/1/24.
//

import SwiftUI
import Charts

struct PieChart: View{
    let title: String
    var chartMarks: [ChartMark]
    let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    @State var selectedSector: Int? = nil
    @State var selectedMark: ChartMark? = nil
    var body: some View{
        VStack(alignment:.leading){
            Text(title)
                .font(.specify(style: .h5))
                .foregroundColor(.specify(color: .grey9))
            
            VStack{
                Chart(chartMarks) { chartMark in
                    
                    let isSelected = selectedMark == chartMark
                    
                    SectorMark(
                        angle: .value(
                            Text(verbatim: chartMark.title),
                            chartMark.count
                        ),
                        innerRadius: .ratio(0.4),
                        outerRadius: .ratio(isSelected ? 1.2 : 0.9),
                        angularInset: 8
                    )
                    .foregroundStyle(Color.specify(color: chartMark.color))
                    .annotation(position: .overlay) {
                        Text("\(chartMark.count)")
                            .font(.specify(style: .h4))
                            .foregroundStyle(.white)
                            .opacity(chartMark == selectedMark ? 1.0 : 0)
                    }
                    .opacity(isSelected ? 1.0 : 0.7)
                }
                .animation(.bouncy, value: selectedMark)
                .frame(height: UIScreen.screenWidth - 200 < 500 ? UIScreen.screenWidth - 130 : 500)
                .chartAngleSelection(value: $selectedSector)
                .onChange(of: selectedSector, UpdateSelectedMark)
                .padding(.top,20)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(chartMarks){
                        chartMark in
                        HStack{
                            Circle()
                                .foregroundColor(.specify(color: chartMark.color))
                                .frame(width: 10, height:10)
                            Text(chartMark.title)
                                .font(.specify(style: .caption))
                                .foregroundColor(.specify(color: chartMark == selectedMark ? .grey10 : .grey5))
                                Spacer()
                        }
                        .frame(alignment:.leading)
                    }
                }
                .padding()
                
            }
            .modifier(ModifierForm(color:.grey15, radius: .cornerRadiusSmall))
        }

    }
    
    func UpdateSelectedMark() {
      guard let selectedSector else { return }
      let mark = self.selectedMark(for: selectedSector)
      guard mark != selectedMark else { return }
      selectedMark = mark
    }
    
    private func selectedMark(for value: Int) -> ChartMark? {
      var total = 0
      for element in chartMarks {
          total += element.count
        if value <= total {
          return element
        }
      }
        return chartMarks.last
    }
}

#Preview {
    PieChart(title: "Status", chartMarks: [
        ChartMark(title: "Not started", count: 8, color: .grey6),
        ChartMark(title: "In Progress", count: 5, color: .blue),
        ChartMark(title: "Late", count: 3, color: .red),
        ChartMark(title: "Completed", count: 10, color: .green)
        ])
}
