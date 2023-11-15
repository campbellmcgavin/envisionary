import SwiftUI

let buttonWidth: CGFloat = 60

enum CellButtonType: Identifiable, CaseIterable {
    case add
    case edit
    case details
    case indent
    case outdent
    case delete
    
    var id: String {
        return "\(self)"
    }
    
    func toString() -> String{
        switch self {
        case .indent:
            return "Indent"
        case .add:
            return "Add"
        case .outdent:
            return "Outdent"
        case .delete:
            return "Delete"
        case .edit:
            return "Edit"
        case .details:
            return "Details"
        }
    }
    
    func toColor() -> CustomColor{
        switch self {
        case .indent:
            return .grey5
        case .outdent:
            return .grey5
        case .delete:
            return .red
        case .add:
            return .purple
        case .edit:
            return .yellow
        case .details:
            return .grey5
        }
    }
    
    func toIcon() -> IconType{
        switch self {
        case .indent:
            return .arrow_right
        case .outdent:
            return .arrow_left
        case .delete:
            return .delete
        case .add:
            return .add
        case .edit:
            return .edit
        case .details:
            return .right
        }
    }
}

struct CellButtonView: View {
    let button: CellButtonType
    let cellHeight: CGFloat
    
    var body: some View {
        VStack {
            Text(button.toString())
        }.padding(5)
            .foregroundColor(.specify(color: .grey10))
            .font(.specify(style: .body4))
        .frame(width: buttonWidth, height: cellHeight)
        .background(Color.specify(color: button.toColor()))
    }
}

//struct ExampleContentView: View {
//    var body: some View {
//        NavigationView {
//        ScrollView {
//            LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders], content: {
//
//                Section.init(header:
//                                HStack {
//                                    Text("Section 1")
//                                    Spacer()
//                                }.padding()
//                                .background(Color.blue))
//                {
//                    ForEach(1...10, id: \.self) { count in
//                        ContentCell(data: "cell \(count)")
//                            .addButtonActions(leadingButtons: [.indent,.add],
//                                              trailingButton:  [.outdent, .delete], outerPadding: 0, isSelected: .constant(false), onClick: { button in
//                                                print("clicked: \(button)")
//                                              })
//                    }
//                }
//            })
//        }.navigationTitle("Demo")
//        }
//    }
//}

struct ContentCell: View {
    let data: String
    var body: some View {
        VStack {
            HStack {
                Text(data)
                Spacer()
            }.padding()
            Divider()
                .padding(.leading)
        }
    }
}


extension View {
    func addButtonActions(leadingButtons: [CellButtonType], trailingButton: [CellButtonType], outerPadding: CGFloat, id: UUID?, selectedId: Binding<UUID>, onClick: @escaping (CellButtonType) -> Void) -> some View {
        self.modifier(SwipeContainerCell(id: id, selectedId: selectedId, leadingButtons: leadingButtons, trailingButton: trailingButton, outerPadding: outerPadding, onClick: onClick))
    }
}


struct SwipeContainerCell: ViewModifier  {
    enum VisibleButton {
        case none
        case left
        case right
    }
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    let id: UUID?
    var selectedId: Binding<UUID>
    let leadingButtons: [CellButtonType]
    let trailingButton: [CellButtonType]
    let maxLeadingOffset: CGFloat
    let minTrailingOffset: CGFloat
    let outerPadding: CGFloat
    let onClick: (CellButtonType) -> Void
    
    init(id: UUID?, selectedId: Binding<UUID>, leadingButtons: [CellButtonType], trailingButton: [CellButtonType], outerPadding: CGFloat, onClick: @escaping (CellButtonType) -> Void) {
        self.leadingButtons = leadingButtons
        self.trailingButton = trailingButton
        maxLeadingOffset = CGFloat(leadingButtons.count) * buttonWidth
        minTrailingOffset = CGFloat(trailingButton.count) * buttonWidth * -1
        self.outerPadding = outerPadding
        self.onClick = onClick
        self.id = id
        self.selectedId = selectedId
    }
    
    func reset() {
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .contentShape(Rectangle()) ///otherwise swipe won't work in vacant area
        .offset(x: offset)
        .onChange(of: selectedId.wrappedValue){
            _ in
            if selectedId.wrappedValue != id{
                withAnimation{
                    reset()
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 15, coordinateSpace: .local)
        .onChanged({ (value) in
            let totalSlide = value.translation.width + oldOffset
            if  (0...Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset)...0 ~= Int(totalSlide)) { //left to right slide
                withAnimation{
                    offset = totalSlide
                }
            }
            ///can update this logic to set single button action with filled single button background if scrolled more then buttons width
        })
            
        .onEnded({ value in
            withAnimation {
              if visibleButton == .left && value.translation.width < -20 { ///user dismisses left buttons
                reset()
             } else if  visibleButton == .right && value.translation.width > 20 { ///user dismisses right buttons
                reset()
             } else if offset > 25 || offset < -25 { ///scroller more then 50% show button
                if offset > 0 {
                    visibleButton = .left
                    offset = maxLeadingOffset
                } else {
                    visibleButton = .right
                    offset = minTrailingOffset
                }
                oldOffset = offset
                ///Bonus Handling -> set action if user swipe more then x px
            } else {
                reset()
            }
         }
        }))
            GeometryReader { proxy in
                HStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(leadingButtons) { buttonsData in
                        Button(action: {
                            withAnimation {
                                reset()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) { ///call once hide animation done
                                onClick(buttonsData)
                            }
                        }, label: {
                            CellButtonView.init(button: buttonsData, cellHeight: proxy.size.height)
                        })
                    }
                }.offset(x: (-1 * maxLeadingOffset) + offset - outerPadding)
                Spacer()
                HStack(spacing: 0) {
                    ForEach(trailingButton) { buttonsData in
                        Button(action: {
                            withAnimation {
                                reset()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) { ///call once hide animation done
                                onClick(buttonsData)
                            }
                        }, label: {
                            CellButtonView.init(button: buttonsData, cellHeight: proxy.size.height)
                        })
                    }
                }.offset(x: (-1 * minTrailingOffset) + offset + outerPadding)
            }
        }
        }
    }
}
