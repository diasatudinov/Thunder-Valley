import SwiftUI


class Links {
    
    static let shared = Links()
    
    static let thunderData = "https://thunderonline.xyz/about"
    // "?page=test"
    static let ruleURL = "https://thunderonline.xyz/rules.html"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
