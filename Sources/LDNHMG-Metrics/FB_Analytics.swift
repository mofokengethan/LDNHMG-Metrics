//
//  FB_Analytics.swift
//  LDNHMG-Metrics
//
//  Created by e on 12/1/25.
//

import FirebaseAnalytics

/**
 * - Analytics.setAnalyticsCollectionEnabled(true): To re-enable collection, such as after an end-user provides consent
 * - <key>FIREBASE_ANALYTICS_COLLECTION_ENABLED</key><false/>: If you wish to temporarily disable Analytics collection, such as to get end-user consent before collecting data
 */
public class FB_Analytics: FB_Analytics_Impl {
    
    public init (){}
    
    /** # Send feedback Log events
     *  [Send feedback Log events](https://firebase.google.com/docs/analytics/events?platform=ios)
     *  - Parameters name: Values can be up to 36 characters long.
     *  - Parameters parameters: Parameters to be added to the dictionary of parameters added to every event. They will be added to the dictionary of default event parameters, replacing any existing parameter with the same name.
     */
    public func logEvent(name: String, parameters: [String: Any]) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    /** # Set default event parameters
     *  [Set default event parameters](https://firebase.google.com/docs/analytics/events?platform=ios#set_default_event_parameters_3)
     *  - Parameters parameters: Parameters to be added to the dictionary of parameters added to every event. They will be added to the dictionary of default event parameters, replacing any existing parameter with the same name.
     */
    public func setDefaultEventParameters(parameters: [String : Any]) {
        Analytics.setDefaultEventParameters(parameters)
    }
    
    /** # Measure Screen View
     *  [Measure Screen View](https://firebase.google.com/docs/analytics/screenviews#swift)
     *  - Parameters screenName: Values can be up to 36 characters long.
     *  - Parameters screenClass: When screen_class is not set, Analytics sets a default value based on the UIViewController or Activity that is in focus when the call is made.
     *  - Parameters screen_view_details: Any extra values needed for the description of the view
     */
    public func recordScreenView(screenName: String, screenClass: String, extraParameters: [String: Any]) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: screenName,
            AnalyticsParameterScreenClass: screenClass,
            "screen_view_details": extraParameters as Any
        ])
    }
    
    /** # Set user properties
     *  [Set user properties](https://firebase.google.com/docs/analytics/user-properties?platform=ios)
     *  - Parameter name: Values can be up to 36 characters long.
     *  - Parameter forName: Should contain 1 to 24 alphanumeric characters or underscores and must start with an alphabetic character.
     */
    public func setUserProperty(name: String, forName: String) {
        Analytics.setUserProperty(name, forName: forName)
    }
    
    /** # Set a user ID
     *  [Set a user ID](https://firebase.google.com/docs/analytics/userid)
     *  [Google Analytics Terms of Service](https://www.google.com/analytics/terms/)
     *  - Parameter userId: Google Analytics has a setUserID call, which allows you to store a user ID for the individual using your app.
     */
    public func setUserId(userId: String) {
        Analytics.setUserID(userId)
    }
    
    /** # Logging an item list
     *  [Select a product from a list](https://firebase.google.com/docs/analytics/measure-ecommerce#select_product)
     * - Parameters id: The ID of the list in which the item was presented to the user (String).
     * - Parameters name: The name of the list in which the item was presented to the user (String).
     * - Parameters list: The list of items involved in the transaction expressed as [[String: Any]].
     */
    public func logProductList(id: String, name: String, list: [[String: Any]]) {
        Analytics.logEvent(
            AnalyticsEventViewItemList,
            parameters: [
                AnalyticsParameterItemListID: id,
                AnalyticsParameterItemListName: name,
                AnalyticsParameterItems: list
            ]
        )
    }
    
    /** # Logging single product item
     *  [Analytics Product Item](https://firebase.google.com/docs/analytics/measure-ecommerce#implementation)
     *  Select Item event. This event signifies that an item was selected by a user from a list.
     *  Use the appropriate parameters to contextualize the event. Use this event to discover the most popular items selected.
     *  - Parameters listId: The ID of the list in which the item was presented to the user (String).
     *  - Parameters listName: The name of the list in which the item was presented to the user (String).
     *  - Parameters items: The list of items involved in the transaction expressed as [[String: Any]].
     */
    public func logProductItem(item: ProductItem, listID: String, listName: String) {
        let items = item.toFirebaseObject()

        let parameters: [String: Any] = [
            AnalyticsParameterItemListID: listID,
            AnalyticsParameterItemListName: listName,
            AnalyticsParameterItems: [items]
        ]

        /** Logging single product item */
        Analytics.logEvent(AnalyticsEventSelectItem, parameters: parameters)
    }
    
    /** # Product Item
     *  [Analytics Product Item](https://firebase.google.com/docs/analytics/measure-ecommerce#implementation)
     *  An array of items can include up to 27 custom parameters, in addition to the prescribed parameters. A single ecommerce event can include up to 200 items.
     *  If you try to send more than 200 items, any items beyond this limit will be dropped and not included in the event data.
     *  - Parameters id: Item ID (context-specific) (String).
     *  - Parameters name: Item Name (context-specific) (String).
     *  - Parameters category: Item category (context-specific) (String).
     *  - Parameters variant: Item variant (String).
     *  - Parameters brand: Item brand (String).
     *  - Parameters price: Purchase price (Double).
     *  - Parameters index: The index of the item in a list (Int).
     */
    public struct ProductItem {
        public let id: String
        public let name: String
        public let category: String?
        public let variant: String?
        public let brand: String?
        public let price: Double?
        public let index: Int?
        
        public init(
            id: String,
            name: String,
            category: String? = nil,
            variant: String? = nil,
            brand: String? = nil,
            price: Double? = nil,
            index: Int? = nil
        ) {
            self.id = id
            self.name = name
            self.category = category
            self.variant = variant
            self.brand = brand
            self.price = price
            self.index = index
        }
        
        /** Product Item struct to object conversion [String: Any] for Product List map */
        public func toFirebaseObject() -> [String: Any] {
           var dict: [String: Any] = [
               AnalyticsParameterItemID: id,
               AnalyticsParameterItemName: name
           ]
           
           if let category { dict[AnalyticsParameterItemCategory] = category }
           if let variant { dict[AnalyticsParameterItemVariant] = variant }
           if let brand { dict[AnalyticsParameterItemBrand] = brand }
           if let price { dict[AnalyticsParameterPrice] = price }
           if let index { dict[AnalyticsParameterIndex] = index }
           
           return dict
       }
        
        /** Add item index */
        public func withIndex(_ index: Int) -> ProductItem {
            return ProductItem(id: id, name: name, category: category, variant: variant, brand: brand, price: price, index: index)
        }
    }
    
    public func printHello() {
        print("Hello Ethan Mofokeng")
    }
}
