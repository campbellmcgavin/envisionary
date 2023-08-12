//
//  ModalFeedback.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/2/23.
//

import SwiftUI

struct ModalFeedback: View {
    
    @Binding var isPresenting: Bool
    @State var feedbackProperties: FeedbackProperties = FeedbackProperties()
    @State var shouldSendFeedback: Bool = false
    @State var shouldClose: Bool = false
    @State var shouldPresentClose: Bool = false
    @State var statusCode: Int? = nil
    
    @StateObject var alerts = AlertsService()
    var body: some View {
        Modal(modalType: .feedback, objectType: .home, isPresenting: $isPresenting, shouldConfirm: .constant(false), isPresentingImageSheet: .constant(false), allowConfirm: false, didAttemptToSave: false,  title: "Submit Feedback", image: nil, modalContent: {
            
            if !shouldPresentClose{
                VStack{
                    
                    FormStackPicker(fieldValue: $feedbackProperties.feedbackType, fieldName: "What type of feedback?", options: .constant(FeedbackType.allCases.map({$0.toString()})),iconType: .help)
                    
                    if feedbackProperties.feedbackType == FeedbackType.bug.toString(){
                        FormStackPicker(fieldValue: $feedbackProperties.bugType, fieldName: "What type of bug?", options: .constant(FeedbackPropertyBugType.allCases.map({$0.toString()})),iconType: .help)
                        
                        if feedbackProperties.bugType == FeedbackPropertyBugType.userInterface.toString(){
                            FormViewPicker(fieldValue: $feedbackProperties.mainScreen, fieldName: "What screen is having the bug?", options: GetOptions(), iconType: .help)
                        }
                    }
                        FormText(fieldValue: $feedbackProperties.description, fieldName: "Description", axis: .vertical, iconType: .description)
                    
                }
                .padding(8)
                .onAppear(){
                    feedbackProperties = FeedbackProperties()
                    alerts.alerts.removeAll()
                    shouldSendFeedback = false
                }
            }
            else{
                EmptyView()
            }
            
        }, headerContent: {EmptyView()}, bottomContent: {
            
            HStack{
                if !shouldSendFeedback{
                    Spacer()
                    TextIconButton(isPressed: $shouldSendFeedback, text: "Send Feedback", color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: false, iconType: .chat)
                        .padding()
                }
                
                if shouldPresentClose{
                    Spacer()
                    TextIconButton(isPressed: $shouldClose, text: "Close", color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: false, iconType: .cancel)
                        .padding()
                }
            }
            .padding(.bottom,50)
            
        }, betweenContent: {
            VStack(spacing:0){
                ForEach(alerts.alerts){
                    alert in
                    AlertLabel(alert: alert)
                        
                }
            }
            .environmentObject(alerts)
        })
        .onChange(of: feedbackProperties.feedbackType){
            _ in
            if feedbackProperties.feedbackType != FeedbackType.bug.toString(){
                feedbackProperties.bugType = ""
                feedbackProperties.mainScreen = ""
            }
        }
        .onChange(of: shouldSendFeedback){
            _ in
            if shouldSendFeedback{
                makePOSTCall()
            }
        }
        .onChange(of: statusCode){
            _ in
            if statusCode != nil {
                if statusCode == 200 {
                    let alert = Alert(alertType: .confirm, keyword: "Success", description: "Your feedback has been submitted", timeAmount: 10, isPersistent: true)
                    self.alerts.alerts.append(alert)
                    shouldPresentClose = true
                }
                else{
                    let alert = Alert(alertType: .confirm, keyword: "Oops", description: "There was an error submitting your feedback", timeAmount: 10, isPersistent: true)
                    self.alerts.alerts.append(alert)
                }
            }
            statusCode = nil
        }
        .onChange(of: shouldClose){
            _ in
            isPresenting = false
            shouldPresentClose = false
        }

    }
    
    func makePOSTCall() {
        guard let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScOS1zhi4kVaGS_i6OrPSsIcz61pS8MHA6kP6L6dJmqO3rXBA/formResponse") else {
            print("Could not create URL.")
            return
        }

        

        
        
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems =
        [
            URLQueryItem(name:"entry.407389359", value: feedbackProperties.feedbackType),
            URLQueryItem(name:"entry.1086743174", value: feedbackProperties.bugType),
            URLQueryItem(name:"entry.1877384795", value: feedbackProperties.mainScreen),
            URLQueryItem(name:"entry.1550717641", value: feedbackProperties.description)
        ]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = requestBodyComponents.query?.data(using: .utf8)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse {
                        print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                        print("statusCode: \(response.statusCode)")
                        print(String(data: data, encoding: .utf8) ?? "")
                self.statusCode = response.statusCode
                    }
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }

            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }

        }
        task.resume()
    }
    
    func GetOptions() -> [String: String]{
        var dictionary = [String: String]()
        FeedbackPropertyMainScreenType.allCases.forEach({ dictionary[$0.toString()] = $0.toImageString()})
        return dictionary
    }
}

struct ModalFeedback_Previews: PreviewProvider {
    static var previews: some View {
        ModalFeedback(isPresenting: .constant(true))
    }
}
