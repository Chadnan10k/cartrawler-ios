# Cartrawler iOS


CartrawlerAPI.Framework - This framework talks to the OTA server and provides data.

CartrawlerSDK.Framework - This framework contains a kit for preset UI and custom UI components

CartrawlerRental.Framework - This framework contains the car rental views

CartrawlerInPath.Framework - This framework is a sub module of the CartrawlerRental framework, allows for a cross sell widget

CartrawlerRakuten.Framework - This framework is for DC-Storm tracking

CTPayment.Framework - A PCI compliant library for Cartrawler Standalone payments

# Integration guide 🤠

- First you need to obtain an Client or Requestor ID

- After that let's use Cocoapods to integrate the Cartrawler Frameworks into your app.

```
source 'https://github.com/cartrawler/cartrawlerpods'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

platform :ios, '8.0'

target ‘MyTarget’ do
	pod 'CartrawlerSDK'
	pod 'CartrawlerAPI'
	pod 'CartrawlerRental'
	pod 'CartrawlerInPath'
  pod 'CartrawlerRakuten'
  pod 'CTPayment'
end
```

You need to add the following to a run script phase
```
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/CartrawlerSDK.framework/strip-frameworks.sh"
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/CartrawlerAPI.framework/strip-frameworks.sh"
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/CartrawlerRental.framework/strip-frameworks.sh"
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/CartrawlerInPath.framework/strip-frameworks.sh"
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/CartrawlerRakuten.framework/strip-frameworks.sh"
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/CTPayment.framework/strip-frameworks.sh"
```
Set 'Enable Bitcode' to NO in your project settings

## Setting up the SDK

First we need to create the SDK object

```
First, we must init the CartrawlerSDK
_sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"123456" languageCode:"EN" sandboxMode:YES];

//Start the DC-Storm tracking library
[self.sdk addAnalyticsProvider:[CartrawlerRakuten new]];

We are good to go! 🚗💨
```

## Setting your app up for Standalone

```
- (void)someMethod
{
    CartrawlerRental *cartrawlerRental = [[CartrawlerRental alloc] initWithCartrawlerSDK:cartrawlerSDK];
    cartrawlerRental.delegate = self;

    //present the standalone views
    [cartrawlerRental presentCarRentalInViewController:someViewController withClientID:@"######"];

}

//MARK: CartrawlerRental Delegate
- (void)didBookVehicle:(CTBooking *)booking
{
    //triggered once a standalone booking has completed
}

```

## Setting your app for the cross sell widget

- Prerequisite: CartrawlerRental library must be initialized

```
_cartrawlerInPath = [CartrawlerInPath initWithCartrawlerRental:cartrawlerRental];
cartrawlerInPath.delegate = self;

//Bind the cross sell widget to a parent UIView
[cartrawlerInPath addInPathCarouselToContainer:someUIView];
```
- You must create CTPassenger objects from your flight, there must be ONE passenger object with isPrimaryDriver set to true

```
CTPassenger *passenger1 = [CTPassenger passengerWithFirstName:@"Lee"
                                                     lastName:@"Maguire"
                                                 addressLine1:@"123 Cartrawler St"
                                                 addressLine2:nil
                                                         city:@"Dundrum"
                                                     postcode:@"Dublin 8"
                                                  countryCode:@"IE"
                                                          age:@21
                                                        email:@"lmaguire@cartrawler.com"
                                                        phone:@"+353 862222222"
                                              isPrimaryDriver:YES];
```
- Perform a search for the cross sell widget

```
[cartrawlerInPath performSearchWithIATACode:@"ALC"
                                 pickupDate:[NSDate date]
                                 returnDate:[NSDate date]
                               flightNumber:@"XY123456"
                                   currency:@"EUR"
                                  passegers:@[passenger1]
                                   clientID:@"######"
                       parentViewController:someViewController];

```

- Now, let's make this cross sell widget interactive
  By implementing the CartrawlerInPath delegate you can subscribe to the following methods:

```
/**
Called when the user taps on the cross sell card
*/
- (void)didTapCrossSellCard;

/**
Called when the vehicles have been fetched and the best daily rate has been calculated

@param price the best daily rate
@param currency the currency
*/
- (void)didReceiveBestDailyRate:(NSNumber *)price currency:(NSString *)currency;

/**
Called when the call to fetch vehicles fails and the best daily rate cannot be calculated
*/
- (void)didFailToReceiveBestDailyRate;
```

### So I have made a payment with the cross sell widget on my server, what's left?

- There is one method left to implement

```
- (void)didReceiveBookingConfirmationID:(NSString *)confirmationID;
```
Call this method when you receive a Cartrawler confirmationID from your payment server.

## Setting up custom attributes values

- Prerequisite: setting this after initializing CartrawlerSDK

[CTSDKSettings instance].customAttributes = [[NSMutableDictionary alloc] init];
[[CTSDKSettings instance].customAttributes setObject:@"er89952d1334" forKey:CTMyAccountID];
[[CTSDKSettings instance].customAttributes setObject:@"T26RJX" forKey:CTOrderId];
[[CTSDKSettings instance].customAttributes setObject:@"89952133413890617305233409049160176604" forKey:CTVisitorId];

- where CTMyAccountID, CTOrderId and CTVisitorId are constants values .
