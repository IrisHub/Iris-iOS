//
//  SecondView.swift
//  Iris
//
//  Created by Shalin on 7/25/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct SecondView: View {
    @State var value: CGFloat = 0
    @Binding var thirdPresented: Bool
    @State var errorAlert = false
    @State var emptyAlert = false
    @State var input: String = ""
    @Binding var preferences: [String]

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("What's your invite code?").retinaTypography(.h4_secondary).foregroundColor(.retinaSnowWhite).padding([.leading, .bottom], 24)
                RetinaTextField("123456", input: $input, onCommit: {print("party")})
                if (self.errorAlert || self.emptyAlert) {
                    Text(self.emptyAlert ? "Enter something and try again." : "Invalid code entered, please try again.").retinaTypography(.p6_main).foregroundColor(.retinaDanger).padding([.leading, .top], 24)
                }
            }.padding(.top, UIScreen.screenHeight/5)
            Spacer()
            Group {
                ZStack {
                    Rectangle()
                    .foregroundColor(Color.retinaOverlayDark)
                    .frame(width: UIScreen.screenWidth, height: 100)
                    
                    HStack {
                        retinaButton(text: "Submit", style: .outlineOnly, color: .retinaPink, action: { self.verifyCode() }).frame(width: UIScreen.screenWidth-48, height: 36, alignment: .trailing)
                    }
                }
            }
            .offset(y: -self.value)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                    (notif) in
                    if let rect = notif.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                        let keyboardHeight = rect.height
                        self.value = keyboardHeight
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                    (notif) in
                    self.value = 0
                }
            }

        }
        .background(Color.retinaBase)
        .edgesIgnoringSafeArea(.all)
    }
    
    func verifyCode() {
        UIApplication.shared.endEditing(true)
        
        if self.input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.emptyAlert = true
            return
        }
        
        struct Code: Codable {
            var access_code: String
        }

        do {
            let code = Code(access_code: self.input)
            let jsonData = try JSONEncoder().encode(code)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            
            let parameters = convertToDictionary(text: jsonString)
            let headers : HTTPHeaders = ["Content-Type": "application/json"]
            AF.request("https://e2nmwaykqf.execute-api.us-west-1.amazonaws.com/alpha/onboardingget", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    do {
                        let json = try JSON(data: response.data ?? Data())
                        print(json)
                        if let userID = json["user_id"].string {
                            UserDefaults.standard.set(userID, forKey: "userID")
                            self.preferences = json["text"].arrayValue.map {$0.stringValue}
                            withAnimation {
                                self.thirdPresented = true
                            }
                        }
                    } catch { self.errorAlert = true }
            }
        } catch { self.errorAlert = true }

    }
 }

struct SecondView_Previews: PreviewProvider {
    @State static var thirdPresented: Bool = false
    @State static var preferences: [String] = [String]()

    static var previews: some View {
        SecondView(thirdPresented: $thirdPresented, preferences: $preferences)
    }
}
