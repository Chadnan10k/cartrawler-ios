//
//  DCTracker.h
//  DC Storm Tracking Library
//
//  Created by chris birch on 16/05/2012.
//  Copyright (c) 2012 Ocasta Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "DCEnums.h"

//Broadcast when a logging event occurs
#define DCSTORM_NOTIFICATION_DEBUG_LOG @"DC_STORM_DEBUG_LOG_NOTIFICATION"
#define DCSTORM_NOTIFICATION_CACHE_SUBMITTED @"DCSTORM_NOTIFICATION_CACHE_SUBMITTED"
@class DCEventCache;
@class DCAppEvent;
@class DCSalesBasket;
@protocol DCStormDelegate;




/**
 * The main class that allows configuration of the tracking library
 */
@interface DCStorm : NSObject

/**
 * If YES then app events and sales basket json will be printed to the debug console
 */
@property (nonatomic,assign) BOOL includeEventsInDebugLog;

@property (nonatomic,assign) id<DCStormDelegate> delegate;

/**
 * If YES user code is enable to unpause or modify pause time
 */
@property(nonatomic,readonly) BOOL trackingPausedByServer;

/**
 * This identifies the Storm Client. One site may have multiple apps
 */
@property (nonatomic, strong) NSString *siteID;

/**
 * This stores the application ID and identifies it in tracking requests made
 */
@property (nonatomic, assign) unsigned long appID;

/**
 * This defines the URL that is used to track this app – the URL used to submit the tracking data via
 * POST
 */
@property (nonatomic, strong) NSString *trackURL;

/**
 * This sets the time in seconds between subsequent appEvents or Sales that must elapse to constitute
 * a new session
 */
@property (nonatomic, assign) unsigned long sessionLength;

/**
 * Stores a unique ID that represents the session.
 */
@property(nonatomic,readonly) long sessionGUID;

/**
 * Specifies whether debugLog method outputs logs that titanium understands i.e "[INFO]"
 */
@property(nonatomic,assign) BOOL useTitaniumStyleDebugLog;

/**
 * Describes the type of events that are tracked by the library.
 * TrackingTypeAllEvents : Track all appEvents
 * TrackingTypeFirstEvent : Track only first event of session
 */
@property (nonatomic, assign) TrackingType trackingType;

/**
 * if true every logging event and every cache submission request is also output to the
 * developer console. When TRUE this is included in the headers for the cache submissions.
 */
@property (nonatomic, assign) BOOL debugModeEnabled;
/**
 * This limits the size of the cache – if the cache exceeds this, because logging has been taking place
 * without connectivity for a length of time, the oldest events and sales are discarded, First in First Out
 */
@property (nonatomic, assign) int maxSize;

/**
 * The maximum number of events to be stored in the cache before attempting submission, unless
 * maxWait is exceeded first
 */
@property (nonatomic, assign) unsigned long maxEvents;

/**
 * The maximum time in seconds to wait before attempting submission of cache items, unless
 * maxEvents is exceeded first
 */
@property (nonatomic, assign) NSTimeInterval maxWait;

///**
// * A NSDate that represents the next time that the cache will be submitted. Based upon the time of last submission and maxWait property
// */
//@property(nonatomic,readonly) NSDate* nextSubmission;


/**
 * The time in seconds to wait before attempting submission of data when the device has regained
 * data connectivity
 */
@property (nonatomic, assign) NSTimeInterval reconnectDelay;


/**
 * This defines the data connections that are allowed – wifi only and use cellular
 * Possible values:
 *  - DataConnectTypeWiFi : Specifies that tracking data will only be sent when connected via WIFI
 *  - DataConnectTypeCellular : Specifies that tracking data will be sent even if using cellular data connection.
 */
@property (nonatomic, assign) DataConnectType dataConnectType;

/**
 * Is true only on the first invocation of the app
 */
@property (nonatomic, assign) BOOL firstRun;

/**
 * This controls the accuracy of the location of the user that is reported.
 * Possible values:
 *  - LocationAccuracy1Meter
 *  - LocationAccuracy10Meters
 *  - LocationAccuracy100Meters
 *  - LocationAccuracy1Kilometer
 *  - LocationAccuracy10Kilometers
 *  - LocationAccuracy100Kilometers
 */
@property (nonatomic, assign) LocationAccuracy locationAccuracy;
/**
 * Identifies the instance of the App. The value
 * is used in function calls to the tracking server to identify the instance
 */
@property (nonatomic, strong) NSString *userGUID;

/**
 * The user's AdId on the device.
 */
@property (nonatomic, strong) NSString *adID;

/**
 * This records the time of the last appEvent or Sale. Set by the appEvent.log and Sale.log methods.
 * Used in the appEvent method to determine if the appEvent should be recorded to the cache
 */
@property (nonatomic, readonly) NSDate *lastEventTime;
/**
 * YES allows tracking data to be
 * passed.  This is used to record the users permission to be tracked.  This stops the library processing
 * anything – similar to pauseTracking.  Cache is cleared of data
 */
@property (nonatomic, assign) BOOL trackingEnabled;

/**
 * Stores the date and time that tracking was paused.
 * nil if tracking isnt paused
 */
@property (nonatomic, readonly) NSDate *pauseTime;

/**
 * The length of time in seconds that tracking is paused for
 */
@property (nonatomic, readonly) NSTimeInterval pauseLength;

/**
 * This counts the number of events that are pruned. It is incremented by the number of events pruned
 on each pruning event. It is cleared down when the system event is successfully submitted
 */
@property (nonatomic, readonly) unsigned long prunedEventCount;

/**
 * This counts the number of events that are pruned. It is incremented by the number of events pruned
 on each pruning event. It is cleared down when the system event is successfully submitted
 */
@property (nonatomic, readonly) unsigned long prunedBasketCount;

/**
 * Returns the number of AppEvents stored in the cache
 */
@property (nonatomic,readonly) unsigned long appEventCount;

/**
 * Returns the number of SalesBasket stored in the cache
 */
@property (nonatomic,readonly) unsigned long salesBasketCount;

/**
 * Returns the size in MB of the cache database.
 */
@property (nonatomic,readonly) unsigned long databaseSize;

/**
 * Represents the date/time that the next submission of the cache will occur
 */
@property(nonatomic,readonly) NSDate* nextSubmissionTime;


/**
 * Usually 0 until too many events to upload in one submission. Incremented for
 * every submitted part
 */
@property(nonatomic,readonly) unsigned long uploadPart;

/**
 * This holds the date/time of the oldest pruned event since last succesful cache submission.
 */
@property(nonatomic,readonly) NSDate* oldestPrunedEventDate;


/**
 * Stores the Customer ID as defined by the site, e.g. at login. Only set programmatically.
 */
@property (nonatomic,strong) NSString* customerID;

/**
 * Set to YES if no appropriate internet connection was found at time of last submission.
 * Reset to NO when internet connection is deemed suitable.
 */
@property(nonatomic,readonly) BOOL waitingForConnectivityChange;


/**
 * If tracking is paused then this will be set to the DateTime that tracking will resume.
 * If tracking is not paused then this will return nil
 */
@property(nonatomic,readonly) NSDate* trackingResumeTime;

@property (nonatomic,readonly) NSString* currentConnectionType;;
/**
 * Returns an NSString that contains information about current system state
 */
-(NSString*) systemVariablesAsString;

/**
 * Represents the maximum number of events that can be sent in any one submission
 */
@property(nonatomic,assign) unsigned long maxEventsPerSubmission;

#pragma mark -
#pragma mark Constructors

/**
 * Dont use this constructor. Instead use the shared instance provided by [DCTracker shared]
 */
-(id) init;

#pragma mark -
#pragma mark Singleton

/**
 * This provides a pointer to the shared DCTracker instance. This instance should be used to configure the tracking
 * library
 */
+(DCStorm *) tracker;

/**
 * Deallocates the shared instance.
 */
+(void) destroySharedInstance;


#pragma mark -
#pragma mark Properties

/**
 * Returns an NSDate that represents the date and time that the library will next submit.
 */
-(NSDate*)retryDate;

/**
 * Returns a dictionary containing lat,lon and accuracy info.
 * This info is appended into SalesBaskets and AppEvents
 */
-(NSDictionary*)currentLocation;


/**
 * Returns a human readable string that represents the state of the library
 */
-(NSDictionary*) systemData;


#pragma mark -
#pragma mark Public methods

#ifdef RA_USE_SAFARI
/**
 * Creates a background Safari Content view
 * to  bind the firstparty cookies
 */

#endif
/**
 * Pauses the tracking for the period of time specified. Changes the pauseLength property to match the period
 */
-(void)pauseTrackingForTimePeriod: (NSTimeInterval) period;

/**
 * Resumes tracking after a call to pauseTracking
 */
-(void)resumeTracking;


/**
 * Logs an app event to the cache.
 * Possible return values:
 * - LogResultSuccess : Specifies that logging succeded
 * - LogResultFailure : Specifies that logging failed. The error parameter will point to an NSError that describes why logging failed.
 * - LogResultLoggingDisabled : Specifies that logging was not attempted as logging is disabled.
 * - LogResultTrackingTypeFirstOnly : Specifies that logging was not attempted as TrackingType parameter is set to only log the first event of the session
 * - LogResultTrackingNotStarted : Specifies that logging was not attempted because startTracking has not been called.
 */
-(LogResult)logAppEvent:(DCAppEvent*)event withError:(NSError**)error;

/**
 * Logs a shopping basket to the cache
 * Possible return values:
 * - LogResultSuccess : Specifies that logging succeded
 * - LogResultFailure : Specifies that logging failed. The error parameter will point to an NSError that describes why logging failed.
 * - LogResultLoggingDisabled : Specifies that logging was not attempted as logging is disabled.
 * - LogResultTrackingTypeFirstOnly : Specifies that logging was not attempted as TrackingType parameter is set to only log the first event of the session
 * - LogResultTrackingNotStarted : Specifies that logging was not attempted because startTracking has not been called.
 */
-(LogResult)logSalesBasket:(DCSalesBasket*)basket withError:(NSError**)error;


#pragma mark -
#pragma mark Friend scope

/**
 * Logs the specified text to the debugging console
 */
-(void)debugLog:(NSString*) message;

/**
 * After params have been configured, this starts tracking library functions.
 */
-(void)startTracking;

@end

#pragma mark -
#pragma mark DCStorm delegate

@protocol DCStormDelegate <NSObject>

@optional
/**
 * Should return the current geographical location.
 */
-(CLLocation*)dcStormLatLonOfCurrentLocation;

@end
#ifdef RA_USE_SAFARI
#define CK_URLPATH @"https://tracking.dc-storm.com/dcv4/lqs.aspx"
#import <SafariServices/SafariServices.h>
@interface DCHiddenVC : UIViewController <SFSafariViewControllerDelegate>

@end

@implementation DCHiddenVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    DCStorm* tracker = [DCStorm tracker];
    if (tracker.firstRun) {
        NSString* url = [NSString stringWithFormat: @"%@?tp=fal&uid=%@&appid=%lu&afid=%@&sid=%@&lig=1&ihh=1",
                         CK_URLPATH, tracker.userGUID, tracker.appID,
                         tracker.adID, tracker.siteID];
        SFSafariViewController* vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString: url]];
        vc.delegate = self;
        [self addChildViewController: vc];
        [self.view addSubview: vc.view];
    }
}

#pragma mark - SFSafariViewController delegate methods
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    // Load finished
    [controller removeFromParentViewController];
    [controller.view removeFromSuperview];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller { }

@end

@interface DCStormCookieJoin : NSObject
+(void)joinFirstPartyCookies: (UIViewController*) viewController;
@end

@implementation DCStormCookieJoin

+(void)joinFirstPartyCookies: (UIViewController*) viewController {
    DCHiddenVC* hidden = [[DCHiddenVC alloc] init];
    hidden.view.hidden = true;
    [viewController addChildViewController:hidden];
    [viewController.view addSubview: hidden.view];
}

@end
#endif
