

import Foundation
import UIKit
import SystemConfiguration
import NVActivityIndicatorView

//MARK:
//MARK: Enums

public enum GENDER:String{
    case male = "male"
    case female = "female"
    case place = "place"
}

public enum GenderInt:Int{
    case male
    case female
    case place
}



//MARK:
//MARK: Application related variables

let APP_CONTEXT = UIApplication.shared.delegate as! AppDelegate
//public let APP_NAME: String = Bundle.main.infoDictionary!["CFBundleName"] as! String
public let APP_NAME = "App"
public let APP_VERSION: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let APP_Bundle_Identifier =  Bundle.main.bundleIdentifier
let getStoryboard2 = UIStoryboard(name: "MyStoryboardName", bundle: nil)


let helper = HelperFunction()


//Mark: - image name

public let APP_BGIMAGE: String = "img_AppBackgroung"
public let USER_PLACEHOLDER: String = "img_UserPlaceHolder_Home"
let MIN_DISTANCE:Float = 10.0
let MAX_DISTANCE:Float = 500.0

let MIN_AGE:CGFloat = 13
let MAX_AGE:CGFloat = 99
let ALERT_CORNER_RADIUS:CGFloat = 8.0


public func DegreesToRadians(degrees: Float) -> Float {
    return Float(Double(degrees) * Double.pi / 180)
}

//MARK:- Storyboard name
public let storyboardMain :String = "Main"
public let storyboardLogin :String = "Login"


//MARK: View ID
public let viewLoginVC = "idLoginViewController"
public let viewHomeVC = "idHomeViewController"
public let viewSignupVC = "idSignupViewController"
public let viewImageDisplayerVC = "idImageDisplayerViewController"

//interview
public let viewLoginAppVC = "idLoginAppVC"
public let viewHomeAppVC = "idHomeAppVC"

//MARK:  Get VC for navigation

public func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: "\(storyboardName)\(isIpad() ? "_iPad" : "")", bundle: nil)
}

public func loadVC(_ strStoryboardId: String, _ strVCId: String) -> UIViewController {
    
    let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
    return vc
}

//MARK: - Check Device is iPad or not

public func isIpad( ) ->Bool{
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        return false
    case .pad:
        return true
    case .unspecified:
        return false
        
    default :
        return false
    }
}


//MARK: - iOS version checking Functions

func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == ComparisonResult.orderedSame
}

func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == ComparisonResult.orderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) != ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) != ComparisonResult.orderedDescending
}


//MARK: - Get full screen size

public func fixedScreenSize() -> CGSize {
    let screenSize = UIScreen.main.bounds.size
    
    if NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 && UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
        return CGSize(width: screenSize.width, height: screenSize.height)
    }
    
    return screenSize
}

public func SCREENWIDTH() -> CGFloat
{
    return fixedScreenSize().width
}

public func SCREENHEIGHT() -> CGFloat
{
    return fixedScreenSize().height
}

//MARK: - Network indicator

public func ShowNetworkIndicator(xx :Bool)
{
    UIApplication.shared.isNetworkActivityIndicatorVisible = xx
}


//MARK: - Count enum
func enumCount<T: Hashable>(_: T.Type) -> Int {
    var i = 1
    while (withUnsafePointer(to: &i, {
        return $0.withMemoryRebound(to: T.self, capacity: 1, { return $0.pointee })
    }).hashValue != 0) {
        i += 1
    }
    return i
}


func arrayEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

func enumValues<T>(from array: AnyIterator<T>) -> [T.RawValue] where T: RawRepresentable {
    return array.map { $0.rawValue }
}


//MARK: - Get image from image name

public func Set_Local_Image(_ imageName :String) -> UIImage
{
    return UIImage(named:imageName)!
}




//MARK: - Font

public func THEME_FONT_REGULAR(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue", size: size)!
}

public func THEME_FONT_MEDIUM(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Medium", size: size)!
}

public func THEME_FONT_MEDIUM_ITALIC(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-MediumItalic", size: size)!
}

public func THEME_FONT_LIGHT(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Light", size: size)!
}

public func THEME_FONT_LIGHT_ITALIC(size: CGFloat) -> UIFont {
    return UIFont(name: "Helvetica-LightItalic", size: size)!
}

public func THEME_FONT_BOLD(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Bold", size: size)!
}

public func THEME_FONT_BOLD_ITALIC(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-BoldItalic", size: size)!
}

//MARK: - SHOW ALERT

func customeSimpleAlertView(title:String, message:String , textAlign : NSTextAlignment = .center)  {
    runOnMainThread {
        let _ = NIPLAlertController.alert(title: title, message: message)
    }
}


func showAlertWithTitleWithMessage(message:String)  {
    runOnMainThread {
        let _ = NIPLAlertController.alert(title: ALERT_NAME, message: message)
    }
}

func showNoInternetMAlert()  {
    runOnMainThread {
        let _ = NIPLAlertController.alert(title: ALERT_NAME, message: "No intermet connection available. Please try again!")
    }
}



//MARK: - Color functions

public func COLOR_CUSTOM(_ Red: Float, _ Green: Float , _ Blue: Float, _ Alpha: Float) -> UIColor {
    return  UIColor (red:  CGFloat(Red)/255.0, green: CGFloat(Green)/255.0, blue: CGFloat(Blue)/255.0, alpha: CGFloat(Alpha))
}

public func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

public func randomColor(_ alpha : CGFloat = 1.0) -> UIColor {
    let r: UInt32 = arc4random_uniform(255)
    let g: UInt32 = arc4random_uniform(255)
    let b: UInt32 = arc4random_uniform(255)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
}

public let APP_GREEN_BORDER_COLOR :UIColor = COLOR_CUSTOM(0,98,24,1)
public let APP_TEXTCOLOR: UIColor = UIColor.white
public let CLEAR_COLOR :UIColor = UIColor.clear


public let APP_THEME_COLOR :UIColor = COLOR_CUSTOM(117, 30,208,1)//(59, 89, 151,1)
public let APP_THEME_COLOR2 :UIColor = COLOR_CUSTOM(117, 30,208,1)//(1, 120, 250,1)//(62, 105, 184,1)

public let APP_WHITE_COLOR :UIColor = COLOR_CUSTOM(255,255,255,1)
public let APP_RED_COLOR :UIColor = COLOR_CUSTOM(211, 44, 44,1)
public let APP_BLACK_COLOR :UIColor = COLOR_CUSTOM(52, 42, 61,1)
public let APP_GREY_COLOR :UIColor = COLOR_CUSTOM(130,130,130,1)

public let APP_HEADINGFONT_COLOR = COLOR_CUSTOM(51, 51, 51, 1)
public let APP_FONT_COLOR = COLOR_CUSTOM(128, 128, 128, 1)
public let APP_BUTTON_COLOR = COLOR_CUSTOM(1, 120, 250,1)//COLOR_CUSTOM(59, 89, 151, 1)
public let APP_BG_COLOR = COLOR_CUSTOM(248, 248, 248, 1)
public let APP_BOX_COLOR :UIColor = COLOR_CUSTOM(255,255,255,1)
public let APP_ICON_COLOR :UIColor = COLOR_CUSTOM(129,130,131,1)
public let APP_BLUEBG_COLOR:UIColor = COLOR_CUSTOM(241,245,253,1)
public let APP_FONTBLUE_COLOR:UIColor = COLOR_CUSTOM(1,122,255,0.5)
public let APP_BORDER_COLOR:UIColor = COLOR_CUSTOM(242,242,242,1)
public let APP_BACKGROUNDNEW_COLOR:UIColor = COLOR_CUSTOM(239,239,244,1)

public let APP_GRAYTEXT_COLOR:UIColor = COLOR_CUSTOM(193,193,193,1)
public let APP_BOX_INSIDE:UIColor = COLOR_CUSTOM(250,250,250,1)
public let APP_BOTTOMVIEW_COLOR:UIColor = COLOR_CUSTOM(244,244,249,1)
public let APP_FONTHOME_COLOR:UIColor = COLOR_CUSTOM(51,51,51,0.8)
//MARK: - APP COMMON IMAGES
let NO_IMAGE = "default-placeholder"
let IMAGE_PLACEHOLDER = "default-placeholder"
let IMAGE_USER_PLACEHOLDER = "default-placeholder"


//MARK:- Log trace

public func DLog<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}

//MARK:- Check string is available or not

public func isLike(source: String , compare: String) ->Bool{
    var exists = true
    ((source).lowercased().range(of : compare as String) != nil) ? (exists = true) :  (exists = false)
    return exists
}




//MARK: - Get current time stamp

public var CurrentTimeStamp: String {
    return "\(Date().timeIntervalSince1970 * 1000)"
}

public var CurrentTimeStampInSecond: Int {
    return Int(Date().timeIntervalSince1970)
}



//MARK: - Image rotate by degree

public func imageRotatedByDegrees(degrees: CGFloat, Image: UIImage) -> UIImage {
    let size = Image.size
    
    UIGraphicsBeginImageContext(size)
    
    let bitmap: CGContext = UIGraphicsGetCurrentContext()!
    //Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap.translateBy(x: size.width / 2, y: size.height / 2)
    //Rotate the image context
    bitmap.rotate(by: (degrees * CGFloat(Double.pi / 180)))
    //Now, draw the rotated/scaled image into the context
    bitmap.scaleBy(x: 1.0, y: -1.0)
    
    let origin = CGPoint(x: -size.width / 2, y: -size.width / 2)
    
    bitmap.draw(Image.cgImage!, in: CGRect(origin: origin, size: size))
    
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}

//MARK:
//MARK: AWS Default
struct AWSConstants {
    public enum ExceptionString: String {
        /// Thrown during sign-up when email is already taken.
        case aliasExistsException = "AliasExistsException"
        /// Thrown when a user is not authorized to access the requested resource.
        case notAuthorizedException = "NotAuthorizedException"
        /// Thrown when the requested resource (for example, a dataset or record) does not exist.
        case resourceNotFoundException = "ResourceNotFoundException"
        /// Thrown when a user tries to use a login which is already linked to another account.
        case resourceConflictException = "ResourceConflictException"
        /// Thrown for missing or bad input parameter(s).
        case invalidParameterException = "InvalidParameterException"
        /// Thrown during sign-up when username is taken.
        case usernameExistsException = "UsernameExistsException"
        /// Thrown when user has not confirmed his email address.
        case userNotConfirmedException = "UserNotConfirmedException"
        /// Thrown when specified user does not exist.
        case userNotFoundException = "UserNotFoundException"
    }
    
}



struct Constants {
    
    enum CurrentDevice : Int {
        case Phone // iPhone and iPod touch style UI
        case Pad // iPad style UI
    }
    
    struct MixpanelConstants {
        static let activeScreen = "Active Screen";
    }
    
    struct CrashlyticsConstants {
        static let userType = "User Type";
    }
    
}

//MARK: - Loader
public func createSmallLoaderInView() -> NVActivityIndicatorView {
    let loaderSize : CGFloat = 30.0
    let frame = CGRect(x: 0, y: 0, width: loaderSize, height: loaderSize)
    let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                        type: .ballRotateChase)
    activityIndicatorView.color = APP_BLACK_COLOR
    return activityIndicatorView
}



//MARK: - Mile to Km
//Convert Mile to kilometer

public func mileToKilometer(myDistance : Int) -> Float {
    
    return Float(myDistance) * 1.60934
    
}

//MARK: - Kilometer to Mile
//Convert Kilometer to Mile

public func KilometerToMile(myDistance : Double) -> Double {
    
    return (myDistance) * 0.621371192
    
}

//MARK: - NULL to NIL
//Convert Null Value to nil

public func NULL_TO_NIL(value : AnyObject?) -> AnyObject? {
    
    if value is NSNull {
        return "" as AnyObject
    } else {
        return value
    }
}



//MARK: - Rounded two digit
//Rounded two digit value

extension Double{
    // let x = Double(0.123456789).roundToPlaces(4)  // x becomes 0.1235 under Swift 2
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//MARK: - Random string Generator
//Generate random string with specified length

func randomString(length: Int, justLowerCase: Bool = false) -> String {
    
    var text = ""
    for _ in 1...length {
        var decValue = 0  // ascii decimal value of a character
        var charType = 3  // default is lowercase
        if justLowerCase == false {
            // randomize the character type
            charType =  Int(arc4random_uniform(4))
        }
        switch charType {
        case 1:  // digit: random Int between 48 and 57
            decValue = Int(arc4random_uniform(10)) + 48
        case 2:  // uppercase letter
            decValue = Int(arc4random_uniform(26)) + 65
        case 3:  // lowercase letter
            decValue = Int(arc4random_uniform(26)) + 97
        default:  // space character
            decValue = 32
        }
        // get ASCII character from random decimal value
        let char = "\(UnicodeScalar(decValue)!)"
        text = text + char
        // remove double spaces
        text = text.replacingOccurrences(of: "  ", with: "")
        text = text.replacingOccurrences(of: " ", with: "")
        
    }
    text = text.appending("_")
    text = text.appending(CurrentTimeStamp)
    text = text.replacingOccurrences(of: ".", with: "")
    
    return text
}

//MARK: - Time Ago Function
//Generate time ago string from Spedified date

func timeAgoSinceDateForChat(timestamp : Int, numericDates:Bool = false) -> String
{
    let calendar = NSCalendar.current
    let date = Date(timeIntervalSince1970: Double(timestamp))
    
    if calendar.isDateInYesterday(date){
        return "Yesterday"
    }
    else if calendar.isDateInToday(date) {
        return "Today"
    }
    else {
        return DateFormater.getDateStringFromTimeStamp(timeStamp: timestamp, DATE_FOR_CHAT)!
    }
}

///MARK: - Check Internet connection

func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
        
    }) else {
        
        return false
    }
    
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
    
}

//MARK: - GET UDID
func getUDID() -> String {
    
    var UDID = ""
    if iskeyAlreadyExist(UD_KEY_UDID){
        UDID = getStringValueFromUserDefaults_ForKey(UD_KEY_UDID)
    }else{
        let theUUID : CFUUID = CFUUIDCreate(nil);
        let string : CFString = CFUUIDCreateString(nil, theUUID);
        UDID =  string as String
        setStringValueToUserDefaults(UDID, UD_KEY_UDID)
    }
    return UDID
}


//MARK: - FONT FUNCTION
public func printFonts(){
    
    // Get all fonts families
    for family in UIFont.familyNames {
        print("\(family)")
        
        // Show all fonts for any given family
        for name in UIFont.fontNames(forFamilyName: family) {
            print("   \(name)")
        }
    }
}


//MARK: - Constant
let totalAboutMeCount = 300

//MARK:
//MARK: KEY_VALUES
let KEY_LOGIN_USER:String = "LoginUser"



//MARK: - Notification Center Key
extension Notification.Name {
    static let NOTI_PUSH = Notification.Name("pushNotification")
    static let NOTI_LOGIN = Notification.Name("LogInNotification")
}

//MARK: - USER_DEFAULTS
let UD_ID_USER_LOGIN:String = "IS user Login"
let UD_LAST_MODIFIED_DATE:String = "lastMOdifiedDate"
let UD_KEY_UDID:String = "UDID String"
let UD_ACCESS_TOKEN:String = "UDID ACCESS TOKEN"
let UD_HISTORY_SEARCH = "UD HISTORY SEARCH"
let UD_HISTORY_LOCATION = "UD HISTORY LOCATION"




