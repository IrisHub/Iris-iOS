//
//  SceneDelegate.swift
//  Iris
//
//  Created by Shalin on 7/16/20.
//  Copyright © 2020 Shalin. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @State var data = [
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Chicken", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Beef", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Carrots", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Broccoli", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Pasta", imageUrl: "food", category: "Ingredient"),
        DiscoveryItem(title: "Salmon", imageUrl: "food", category: "Ingredient")
    ]



    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

//        var state: UIStateModel = UIStateModel()
//
//        // Create the SwiftUI view that provides the window contents.
//        let contentView = SettingsView(titles: ["Diet", "Food I don’t eat", "Time I have to cook Lunch", "Time I have to cook Dinner", "My cooking level", "Spice Tolerance", "See meals that are", "Top Cuisines"], settings: ["Vegan", "Eggs", "30min", "1 hour", "Intermediate", "Low", "Healthy", "American"])

        let contentView = //RecipeView()
//        ContentView(data: data, spacing: -10)
        SecondView()



        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

