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

    private var server: HttpServer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard let www_url = URL(string: Bundle.main.resourcePath! + "/www.bundle/") else {
            return false
        }
        
        do {
            
            let root_url = www_url.appendingPathComponent("pmtiles")
                        
            let port: in_port_t = 9001
            let server = HttpServer()
                            
                var opts = ServeProtomapsOptions(root: root_url)
                opts.AllowOrigins = "*"
                opts.AllowHeaders = "*"
                
                server["/pmtiles/:path"] = ServeProtomapsTiles(opts)
                
                server["/"] = { request in
                    return HttpResponse.ok(.text("Hello world.))
                }
            
                try server.start(port)
                print("Listening for requests on :\(port)")
            
                // See this? It's important. Without this then `server` will
                // go out of scope at the end of this method causing the server
                // to stop handling requests. Let's just say it took me a long
                // time (and a lot of cycles reading and re-reading the Apple
                // AppTransportSecurity docs) to figure this out...
            
                self.server = server
                
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

