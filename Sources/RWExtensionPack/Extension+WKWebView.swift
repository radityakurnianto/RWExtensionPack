//
//  WKWebViewExtension.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 5/26/20.
//
import WebKit

public extension WKWebView {
    func inject(cookies: [HTTPCookie], url: URL, completion: @escaping ((WKWebView, URLRequest)->Void)) -> Void {
        if #available(iOS 11.0, *) {
            HTTPCookieStorage.shared.cookieAcceptPolicy = .always
            
            cookies.forEach { (cookie) in
                HTTPCookieStorage.shared.setCookie(cookie)
            }
            
            let storedCookies = HTTPCookieStorage.shared.cookies ?? []
            
            let dataStore = WKWebsiteDataStore.nonPersistent()
            
            let waitGroup = DispatchGroup()
            storedCookies.forEach { (cookie) in
                waitGroup.enter()
                self.configuration.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: {
                    waitGroup.leave()
                })
            }
            
            waitGroup.notify(queue: DispatchQueue.main) {
                self.configuration.websiteDataStore = dataStore
                completion(self, URLRequest(url: url))
            }
        }
    }
    
    func syncCookies(url : URL, completion: @escaping ((WKWebView, URLRequest)->Void)) -> Void {
        if #available(iOS 11.0, *) {
            HTTPCookieStorage.shared.cookieAcceptPolicy = .always
            
            let storedCookies = HTTPCookieStorage.shared.cookies ?? []
            
            let dataStore = WKWebsiteDataStore.nonPersistent()
            
            let waitGroup = DispatchGroup()
            storedCookies.forEach { (cookie) in
                waitGroup.enter()
                self.configuration.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: {
                    waitGroup.leave()
                })
            }
            
            waitGroup.notify(queue: DispatchQueue.main) {
                self.configuration.websiteDataStore = dataStore
                completion(self, URLRequest(url: url))
            }
        }
    }
    
    func delete(cookies: [HTTPCookie], url: URL, completion: @escaping ((WKWebView, URLRequest)->Void)) -> Void {
        if #available(iOS 11.0, *) {
            let storedCookies = HTTPCookieStorage.shared.cookies ?? []
            let dataStore = WKWebsiteDataStore.nonPersistent()
            
            let waitGroup = DispatchGroup()
            storedCookies.forEach { (cookie) in
                waitGroup.enter()
                self.configuration.websiteDataStore.httpCookieStore.delete(cookie) {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    waitGroup.leave()
                }
            }
            
            waitGroup.notify(queue: DispatchQueue.main) {
                self.configuration.websiteDataStore = dataStore
                completion(self, URLRequest(url: url))
            }
        }
    }
}
