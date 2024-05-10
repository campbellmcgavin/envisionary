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
    var isCompact: Bool = false
    
    let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    @State var selectedSector: Int? = nil
    @State var selectedMark: ChartMark? = nil
    var body: some View{
        VStack(alignment:.leading){
            

            
            if isCompact{
                HStack{
                    
                    BuildView()
                }
                .modifier(ModifierForm(color:.grey15, radius: .cornerRadiusSmall))
            }
            else{
                
                Text(title)
                    .font(.specify(style: .h5))
                    .foregroundColor(.specify(color: .grey9))
                
                VStack{
                    BuildView()
                }
                .modifier(ModifierForm(color:.grey15, radius: .cornerRadiusSmall))
            }

        }

    }
    
    @ViewBuilder
    func BuildView() -> some View{

        if isCompact{
            BuildLabels()
            Spacer()
            BuildChart()
                .frame(maxWidth:200)
                .offset(y:-10)

        }
        else{
            BuildChart()
            BuildLabels()
        }

    }
    
    @ViewBuilder
    func BuildLabels() -> some View{
        
        if isCompact{
            VStack{
                ForEach(chartMarks){
                    chartMark in
                    HStack(){
                        Circle()
                            .foregroundColor(.specify(color: chartMark.color))
                            .frame(width: 10, height:10)
                        Text(chartMark.title)
                            .font(.specify(style: .caption))
                            .foregroundColor(.specify(color: chartMark == selectedMark ? .grey10 : .grey5))
                        Spacer()
                    }
                    .frame(width:100)
                    .frame(alignment:.leading)
                }
            }
            .padding()
        }
        else{
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
    }
    
    @ViewBuilder
    func BuildChart() -> some View{
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
        .frame(height: isCompact ? 175 : (UIScreen.screenWidth - 200 < 500 ? UIScreen.screenWidth - 130 : 500))
        .chartAngleSelection(value: $selectedSector)
        .onChange(of: selectedSector, UpdateSelectedMark)
        .padding(.top,20)
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
