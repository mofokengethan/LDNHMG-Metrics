
import FirebaseAnalytics


public class FB_Analytics {
    
    public init (){}
    
    func logEvent(name: String, parameters: [String: Any]) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    func printHello() {
        print("Hello Ethan Mofokeng")
    }
}
