
import FirebaseAnalytics


public class FB_Analytics {
    
    public init (){}
    
    public func logEvent(name: String, parameters: [String: Any]) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    public func printHello() {
        print("Hello Ethan Mofokeng")
    }
}
