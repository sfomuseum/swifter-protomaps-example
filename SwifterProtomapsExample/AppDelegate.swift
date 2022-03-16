//
//  AppDelegate.swift
//  SwifterProtomapsExample
//
//  Created by asc on 3/15/22.
//

import UIKit
import Swifter
import SwifterProtomaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard let www_url = URL(string: Bundle.main.resourcePath! + "/www.bundle/") else {
            return false
        }
        
        do {
            
            let root_url = www_url.appendingPathComponent("pmtiles")
                        
            let port: in_port_t  = 9001
            let server = HttpServer()
                            
                var opts = ServeProtomapsOptions(root: root_url)
                opts.AllowOrigins = "*"
                opts.AllowHeaders = "*"
                
                server["/pmtiles/:path"] = ServeProtomapsTiles(opts)
                
                server["/"] = { request in
                    return HttpResponse.ok(.text("HELLO WORLD"))
                }
            
                try server.start(port)
                print("Listening for requests on :\(port)")
                
        } catch {
            print("Failed to start PM tiles server, \(error)")
            return false
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

