import SwiftUI

struct ScrollPicker<Content: View>: UIViewControllerRepresentable, Equatable {

    // MARK: - Coordinator
    final class Coordinator: NSObject, UIScrollViewDelegate {
        
        // MARK: - Properties
        private let scrollView: UIScrollView
        var offset: Binding<CGPoint>
        var frame: Binding<CGFloat>
        var weirdOffset: CGFloat
        let maxIndex: CGFloat
        let axis: Axis
        let oneStop: Bool

        // MARK: - Init
        init(_ scrollView: UIScrollView, offset: Binding<CGPoint>, frame: Binding<CGFloat>, weirdOffset: CGFloat, maxIndex: CGFloat, axis: Axis, oneStop: Bool) {
            self.scrollView          = scrollView
            self.offset              = offset
            self.frame               = frame
            self.weirdOffset         = weirdOffset
            self.maxIndex            = maxIndex
            self.axis                = axis
            self.oneStop             = oneStop
            super.init()
            self.scrollView.delegate = self
        }
        
        // MARK: - UIScrollViewDelegate
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                if self.axis == .horizontal{
                    self.offset.wrappedValue.x = scrollView.contentOffset.x
                }
                else{
                    self.offset.wrappedValue.y = scrollView.contentOffset.y
                }
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

            DispatchQueue.main.async{
                if self.axis == .horizontal{
                    let offset = scrollView.contentOffset.x
                    let index = (offset) / (self.frame.wrappedValue + self.weirdOffset)
                    let indexRounded = (index).rounded(.toNearestOrAwayFromZero)
                    var value: CGFloat
                    
                    if(indexRounded > self.maxIndex && self.maxIndex > 0){
                        value = self.maxIndex * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                    }
                    else{
                        value = indexRounded * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                    }
                    self.offset.wrappedValue = CGPoint(x: value, y: 0)
                }
                else{
                    let offset = scrollView.contentOffset.y
                    let index = (offset) / (self.frame.wrappedValue + self.weirdOffset)
                    let indexRounded = (index).rounded(.toNearestOrAwayFromZero)
                    var value: CGFloat
                    
                    if(indexRounded > self.maxIndex && self.maxIndex > 0){
                        value = self.maxIndex * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                    }
                    else{
                        value = indexRounded * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                    }
                    if !(index > self.maxIndex + 0.49 && self.oneStop){
                        self.offset.wrappedValue = CGPoint(x: 0, y: value)
                    }

                }
                if(self.oneStop && abs(scrollView.contentOffset.y) < self.frame.wrappedValue*0.99){
                    scrollView.decelerationRate = .fast
                }
                else if(self.oneStop){
                    scrollView.decelerationRate = .normal
                }
            }
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
            if !decelerate{
                DispatchQueue.main.async{
                    if self.axis == .horizontal{
                        let offset = scrollView.contentOffset.x
                        let index = (offset) / (self.frame.wrappedValue + self.weirdOffset)
                        let indexRounded = (index).rounded(.toNearestOrAwayFromZero)
                        var value: CGFloat
                        
                        if(indexRounded > self.maxIndex && self.maxIndex > 0){
                            value = self.maxIndex * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                        }
                        else{
                            value = indexRounded * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                        }
                        self.offset.wrappedValue = CGPoint(x: value, y: 0)
                    }
                    else{
                        let offset = scrollView.contentOffset.y
                        let index = (offset) / (self.frame.wrappedValue + self.weirdOffset)
                        let indexRounded = (index).rounded(.toNearestOrAwayFromZero)
                        var value: CGFloat
                        
                        if(indexRounded > self.maxIndex && self.maxIndex > 0){
                            value = self.maxIndex * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                        }
                        else{
                            value = indexRounded * CGFloat(self.frame.wrappedValue + self.weirdOffset)
                        }
                        
                        if !(index > self.maxIndex + 0.49 && self.oneStop){
                            self.offset.wrappedValue = CGPoint(x: 0, y: value)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Type
    typealias UIViewControllerType = UIScrollViewController<Content>
    
    // MARK: - Properties
    var frame: Binding<CGFloat>
    var weirdOffset: CGFloat
    var offset: Binding<CGPoint>
    var animationDuration: Binding<TimeInterval>
    var showsScrollIndicator: Bool
    var axis: Axis
    var oneStop: Bool
    var content: () -> Content
    var onScale: ((CGFloat)->Void)?
    var disableScroll: Bool
    var forceRefresh: Bool
    var maxIndex: CGFloat
    var stopScrolling: Binding<Bool>
    private let scrollViewController: UIViewControllerType

    // MARK: - Init
    init(frame: Binding<CGFloat>, weirdOffset: CGFloat, _ offset: Binding<CGPoint>, animationDuration: Binding<TimeInterval>, maxIndex: CGFloat, showsScrollIndicator: Bool = false, axis: Axis = .horizontal, onScale: ((CGFloat)->Void)? = nil, disableScroll: Bool = false, forceRefresh: Bool = false, stopScrolling: Binding<Bool> = .constant(false), oneStop: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.frame                = frame
        self.weirdOffset          = weirdOffset
        self.offset               = offset
        self.onScale              = onScale
        self.animationDuration    = animationDuration
        self.content              = content
        self.showsScrollIndicator = showsScrollIndicator
        self.maxIndex             = maxIndex
        self.axis                 = axis
        self.disableScroll        = disableScroll
        self.forceRefresh         = forceRefresh
        self.stopScrolling        = stopScrolling
        self.scrollViewController = UIScrollViewController(rootView: self.content(), offset: self.offset, axis: self.axis, onScale: self.onScale)
        self.oneStop              = oneStop
    }
    
    // MARK: - Updates
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
        self.scrollViewController
    }

    func updateUIViewController(_ viewController: UIViewControllerType, context: UIViewControllerRepresentableContext<Self>) {

        DispatchQueue.main.async{
            viewController.scrollView.showsVerticalScrollIndicator   = self.showsScrollIndicator
            viewController.scrollView.showsHorizontalScrollIndicator = self.showsScrollIndicator
            viewController.updateContent(self.content)

            let duration: TimeInterval                = self.duration(viewController)
            let newValue: CGPoint                     = self.offset.wrappedValue
            viewController.scrollView.isScrollEnabled = !self.disableScroll
            
            if self.stopScrolling.wrappedValue {
                viewController.scrollView.setContentOffset(viewController.scrollView.contentOffset, animated:false)
                return
            }
            
            guard duration != .zero else {
                viewController.scrollView.contentOffset = newValue
                return
            }
            
            if(animationDuration.wrappedValue == 0.0){
                viewController.scrollView.contentOffset = newValue
            }
            else{
                UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .curveEaseInOut, .beginFromCurrentState], animations: {
                    viewController.scrollView.contentOffset = newValue
                }, completion: nil)
            }
        }
        


    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self.scrollViewController.scrollView, offset: self.offset, frame: self.frame, weirdOffset: self.weirdOffset, maxIndex: self.maxIndex, axis: self.axis, oneStop: self.oneStop)
    }
    
    //Calcaulte max offset
    private func newContentOffset(_ viewController: UIViewControllerType, newValue: CGPoint) -> CGPoint {
        
        let maxOffsetViewFrame: CGRect = viewController.view.frame
        let maxOffsetFrame: CGRect     = viewController.hostingController.view.frame
        let maxOffsetX: CGFloat        = maxOffsetFrame.maxX - maxOffsetViewFrame.maxX
        let maxOffsetY: CGFloat        = maxOffsetFrame.maxY - maxOffsetViewFrame.maxY
        
        return CGPoint(x: min(newValue.x, maxOffsetX), y: min(newValue.y, maxOffsetY))
    }
    
    //Calculate animation speed
    private func duration(_ viewController: UIViewControllerType) -> TimeInterval {
        
        var diff: CGFloat = 0
        
        switch axis {
            case .horizontal:
                diff = abs(viewController.scrollView.contentOffset.x - self.offset.wrappedValue.x)
            default:
                diff = abs(viewController.scrollView.contentOffset.y - self.offset.wrappedValue.y)
        }
        
        if diff == 0 {
            return .zero
        }
        
        let percentageMoved = diff / UIScreen.main.bounds.height
        if(percentageMoved > (maxIndex/2.5)/(maxIndex)){
            return 0.0
        }
        else{
            return self.animationDuration.wrappedValue * min(max(TimeInterval(percentageMoved), 0.25), 1)
        }

    }
    
    // MARK: - Equatable
    static func == (lhs: ScrollPicker, rhs: ScrollPicker) -> Bool {
        return !lhs.forceRefresh && lhs.forceRefresh == rhs.forceRefresh
    }
}

final class UIScrollViewController<Content: View> : UIViewController, ObservableObject {

    // MARK: - Properties
    var offset: Binding<CGPoint>
    var onScale: ((CGFloat)->Void)?
    let hostingController: UIHostingController<Content>
    private let axis: Axis
    var scrollView: UIScrollView = {
        
        let scrollView                                       = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.canCancelContentTouches                   = true
        scrollView.delaysContentTouches                      = true
        scrollView.scrollsToTop                              = false
        scrollView.backgroundColor                           = .clear
        scrollView.decelerationRate                          = .fast
        scrollView.bounces                                   = true
        
        
        return scrollView
    }()
    
    @objc func onGesture(gesture: UIPinchGestureRecognizer) {
        self.onScale?(gesture.scale)
    }

    // MARK: - Init
    init(rootView: Content, offset: Binding<CGPoint>, axis: Axis, onScale: ((CGFloat)->Void)?) {
        self.offset                                 = offset
        self.hostingController                      = UIHostingController<Content>(rootView: rootView)
        self.hostingController.view.backgroundColor = .clear
        self.axis                                   = axis
        self.onScale                                = onScale
        
        super.init(nibName: nil, bundle: nil)
    }
    func updateContent(_ content: () -> Content) {
        
        self.hostingController.rootView = content()
        self.scrollView.addSubview(self.hostingController.view)
        
        var contentSize: CGSize = self.hostingController.view.intrinsicContentSize
        
        switch axis {
            case .vertical:
                contentSize.width = self.scrollView.frame.width
            case .horizontal:
                contentSize.height = self.scrollView.frame.height
        }
        
        self.hostingController.view.frame.size = contentSize
        self.scrollView.contentSize            = contentSize
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        
//        self.scrollView.decelerationRate = (abs(self.offset.y.wrappedValue) < 280 ) ? .fast : .normal
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.createConstraints()
        self.view.setNeedsUpdateConstraints()
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Constraints
    fileprivate func createConstraints() {
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
