//
//  AppDelegate.swift
//  deepspeech_ios_test
//
//  Created by Reuben Morais on 15.06.20.
//  Copyright © 2020 Mozilla. All rights reserved.
//

import UIKit
import deepspeech_ios

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let ptr = DeepSpeech.open(path: Bundle.main.path(forResource: "output_graph", ofType: "tflite")!, scorerPath: Bundle.main.path(forResource: "librispeech_en_utf8_nonpruned_o6", ofType: "scorer"))
        
        let files = [
            "5639-40744-0008",
            "1089-134686-0019",
            "2094-142345-0053",
            "8463-294825-0010",
            "121-123852-0001",
            "7021-79740-0008",
            "6930-76324-0010",
            "5105-28240-0001",
            "1089-134691-0012",
            "5142-33396-0027",
            "260-123288-0004",
            "6930-75918-0008",
            "8463-294828-0005",
            "61-70970-0002"
        ]

        let serialQueue = DispatchQueue(label: "serialQueue")
        let group = DispatchGroup()
        group.enter()
        serialQueue.async {
            DeepSpeech.test(modelState: ptr, audioPath: Bundle.main.path(forResource: "1284-134647-0003", ofType: "wav")!) {
                group.leave()
            }
        }
        for path in files {
            group.wait()
            group.enter()
            DeepSpeech.test(modelState: ptr, audioPath: Bundle.main.path(forResource: path, ofType: "wav")!) {
                group.leave()
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
