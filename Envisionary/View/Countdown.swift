//
//  Countdown.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/18/23.
//

import SwiftUI



struct Clock: View {
    var counter: Double
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.custom("Avenir Next", size: 10))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - Int(counter)
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct ProgressTrack: View {
    let size: SizeType
    let color: CustomColor
    var body: some View {
        
        Circle()
            .fill(.clear)
            .frame(width: size.ToSize(), height: size.ToSize())
            .overlay(
                Circle().stroke(Color.specify(color: color), lineWidth: size.ToSize()/9)
                    .opacity(0.3)
        )
    }
}

struct ProgressBar: View {
    var counter: Double
    var countTo: Int
    let size: SizeType
    let color: CustomColor
    
    var body: some View {
        Circle()
            .fill(.clear)
            .frame(width: size.ToSize(), height: size.ToSize())
            .overlay(
                Circle().trim(from:0, to: progress())
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: size.ToSize()/9,
                            lineCap: .round,
                            lineJoin:.round
                        )
                )
                    .foregroundColor(
                        (.specify(color: color))
                )
        )
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

struct Countdown: View {

    @Binding var counter: Double
    @Binding var shouldReset: Bool
    let timeAmount: Int
    let color: CustomColor
    let size: SizeType
    let shouldCountDown: Bool
    let shouldShowClock: Bool
    var shouldAnimate: Bool = false
    @State var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
        
    var body: some View {
        VStack{
            ZStack{
                ProgressTrack(size: size, color: color)
                ProgressBar(counter: counter, countTo: timeAmount, size: size, color: color)
                
                if shouldShowClock{
                    Clock(counter: counter, countTo: timeAmount)
                }
            }
        }.onReceive(timer) { time in
            if shouldAnimate{
                withAnimation{
                    Compute()
                }
            }
            else{
                Compute()
            }

        }
        .onChange(of: shouldReset){
            _ in
            
            timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
            counter = Double(timeAmount)
        }
    }
    
    func Compute(){
        if shouldCountDown{
            
            if counter > 0 {
                self.counter -= 0.1
            }
            else{
                stopTimer()
            }
        }
        else{
            if Int(counter) < timeAmount{
                self.counter += 0.1
            }
            else{
                
            }
        }
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        Countdown(counter: .constant(0), shouldReset: .constant(false), timeAmount: 15, color: .purple, size: .small, shouldCountDown: true, shouldShowClock: false)
    }
}
