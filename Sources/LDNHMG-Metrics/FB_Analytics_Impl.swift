//
//  FB_Analytics_Impl.swift
//  LDNHMG-Metrics
//
//  Created by e on 12/1/25.
//

public protocol FB_Analytics_Impl {
    func logEvent(name: String, parameters: [String: Any])
    func setDefaultEventParameters(parameters: [String : Any])
    func recordScreenView(screenName: String, screenClass: String, extraParameters: [String: Any])
    func setUserProperty(name: String, forName: String)
    func setUserId(userId: String)
    func logProductList(id: String, name: String, list: [[String: Any]])
    func logProductItem(item: FB_Analytics.ProductItem, listID: String, listName: String)
}
