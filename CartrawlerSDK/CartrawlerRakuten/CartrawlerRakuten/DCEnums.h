//
//  DCEnums.h
//  DCStorm
//
//  Created by Chris Birch on 04/07/2012.
//  Copyright (c) 2012 Ocasta Studios. All rights reserved.
//

#ifndef DCStorm_DCEnums_h
#define DCStorm_DCEnums_h


/**
 * Values that describe the types of data connection that can be used when sending tracking data. 
 */
typedef enum
{
    /**
     * Specifies that tracking data will only be sent when connected via WIFI
     */
    DataConnectTypeWiFi=0,
    /**
     * Specifies that tracking data will be sent even if using cellular data connection. 
     */
    DataConnectTypeCellular=1
    
} DataConnectType;

/**
 * Values that describe the reason why 
 */
typedef enum
{
    /**
     * Specifies that tracking is not paused.
     */
    PauseReasonNotPaused,
    /**
     * Specifies that the reason that tracking is paused is due to request from server.
     */
    PauseReasonServer,
    
    /**
     * Specifies that the reason that tracking is paused is due to user code calling pauseTracking.
     */
    PauseReasonUser
} PauseReason;

/**
 * Values that describe the outcome of a logging operation.
 */
typedef enum 
{
    /**
     * Specifies that logging succeded
     */
    LogResultSuccess=0,
    /**
     * Specifies that logging failed. The error paramter will point to an NSError that describes why
     * logging failed.
     */
    LogResultFailure,
    /**
     * Specifies that logging was not attempted as logging is disabled.
     */
    LogResultLoggingDisabled,
    /**
     * Specifies that logging was not attempted as TrackingType parameter is set to only log the first event of the session
     */
    LogResultTrackingTypeFirstOnly,
    
    /**
     * Specifies that logging was not attempted because startTracking has not been called.
     */
    LogResultTrackingNotStarted
    
}LogResult;


typedef enum 
{
    /**
     * Track all appEvents
     */
    TrackingTypeAllEvents=0,
    /**
     * Track only first event of session
     */
    TrackingTypeFirstEvent
} TrackingType;


/**
 * Values that control the amount of accuracy used when submitting coordinate values
 */
typedef enum 
{
    LocationAccuracy1Meter = 5,
    LocationAccuracy10Meters = 4,
    LocationAccuracy100Meters = 3,
    LocationAccuracy1Kilometer = 2,
    LocationAccuracy10Kilometers = 1,
    LocationAccuracy100Kilometers = 0
    
} LocationAccuracy;
#endif
