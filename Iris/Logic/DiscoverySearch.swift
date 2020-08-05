//
//  DiscoverySearch.swift
//  Iris
//
//  Created by Shalin on 7/20/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import SwiftUI
import MessageUI
import Mixpanel

struct DiscoverySearch: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var observed: Observer
    @ObservedObject var observedTopChoices: TopChoicesObserver
    @State private var searchText = ""
//    @State var topChoicesPresented: Bool = false

    
    /// The delegate required by `MFMessageComposeViewController`
    private let messageComposeDelegate = MessageDelegate()

    
    var body: some View {
        VStack {
            // Search bar
            Search(isBack: true, placeholder: "Try a cuisine, ingredient, or dish", searchText: $searchText, buttonCommit:{ self.presentationMode.wrappedValue.dismiss() }).padding(.top, 40).background(Color.retinaOverlayLight)
            
            HStack {
                if (self.searchText.isEmpty) {
                    Text("Suggestions for you").retinaTypography(.p5_main).padding(.leading, 24).padding(.top, 12).foregroundColor(.retinaWinterGrey)
                    Spacer()
                }
            }
            
            ScrollView(.vertical) {
                if (self.searchText.isEmpty) {
                    ForEach(self.observed.discoveryItems.filter {
                        $0.ideas == true
                    }, id: \.self) { item in
                        NavigationLink(
                        destination: LazyView(TopChoicesView(observed: self.observedTopChoices, selectedItem: item))) {
                            SearchCell(title: item.title, subtitle: item.category)
                            .listRowInsets(EdgeInsets())
                        }
                    }
                } else {
                    if self.observed.discoveryItems.filter { $0.title.lowercased().contains(self.searchText.lowercased()) }.count == 0 {
                        VStack {
                            Text("No search results found, sorry.").retinaTypography(.p5_main).padding(.top, 36).foregroundColor(.retinaWinterGrey)
                            retinaButton(text: "Text Iris to request", style: .outlineOnly, color: .retinaPink, action: {
                                self.presentMessageCompose()
//                                Mixpanel.mainInstance().track(event: "Text Iris to Request")

                            }).frame(width: (UIScreen.screenWidth)/2, height: 36, alignment: .trailing).padding(24)
                        }
                    } else {
                        ForEach(self.observed.discoveryItems.filter {
                            self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                        }, id: \.self) { item in
                            NavigationLink(
                            destination: LazyView(TopChoicesView(observed: self.observedTopChoices, selectedItem: item))) {
                                SearchCell(title: item.title, subtitle: item.category)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                }
            }.padding([.bottom], UIApplication.bottomInset).background(Color.retinaOverflow).edgesIgnoringSafeArea(.bottom)
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().backgroundColor = Color.retinaOverflow.uiColor()
                UITableView.appearance().backgroundColor = Color.retinaOverflow.uiColor()
                UITableViewCell.appearance().selectionStyle = .none
            }
            .resignKeyboardOnDragGesture()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .background(Color.retinaOverflow)
    }
}

struct DiscoverySearch_Previews: PreviewProvider {
    @ObservedObject static var observed = Observer()
    @ObservedObject static var observedTopChoices = TopChoicesObserver()

    static var previews: some View {
        DiscoverySearch(observed: observed, observedTopChoices: observedTopChoices)
    }
}



// MARK: The message part
extension DiscoverySearch {

    /// Delegate for view controller as `MFMessageComposeViewControllerDelegate`
    private class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Customize here
            controller.dismiss(animated: true)
        }

    }

    /// Present an message compose view controller modally in UIKit environment
    private func presentMessageCompose() {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.keyWindow?.rootViewController

        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate
        composeVC.body = "Hey Iris team, I tried searching \"" + self.searchText + "\" and nothing showed up. Would love it if you could add this to Iris."
        composeVC.recipients = ["9498362723", "9499396619", "8182033202"]

        vc?.present(composeVC, animated: true)
    }
}
