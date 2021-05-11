# MomenWeatherAPP
## Overview
1. This app is consuming [open weather map json api](https://api.openweathermap.org/data/) version 2.5 using the 5 days 3 hours forcasting endpoint.
2. It shows the forcast of the a given city at some time (Cologne DE, Nov 6 - Nov 11) cached offline, configurable by a `UISwitch`
3. Flipping the switch to live mode detects the current location and requests data for it, showing live weather forcast grouped by date.
4. The app periodically refreshes the data whenever the Core Location detects location change.
5. There is a refresh button in the middle of the lower tab for the user to refresh the view manually, I personally didnt like using `UIRefreshControl` on a multi-direction scroll view.
6. The app also monitors current internet connection, and reacts with showing an error alert in case it didn't work.
7. The app reacts on system's UI style mode (dark and light).

## How to run
1. open `MomenWeather.xcworkspace`
2. you will find two projects, one is the App target, the other is an SDK encapsulating the app data and logic.
3. Run `MomenWeatherApp` target in the simulator
4. you can configure the `MomenWeatherApp` scheme to simulate a specific location in the simulator, or test it on the simulator itself
5. Important: in case of simulator sometimes some error message pops up in case location simulation isn't available.
6. Optimally run this on an actual device with location simulation on.
7. To run unit tests proceed to `MomenWeatherSDK` project and run `MomenWeatherSDKTests` target.

## Architecture
The application's architecture is based on [MVVM-C](https://tech.trivago.com/2016/08/26/mvvm-c-a-simple-way-to-navigate/)(For the Coordinator Pattern, please read [here](https://khanlou.com/2015/10/coordinators-redux/)), which enables us to decouple presentation logic from the view for better separation of concerns and much improved testability. Along with it, we use Apple's Combine framework for data binding, observing and most of asynchronous tasks in general.
The folder structure of the project should reflect the architecture > `ViewModels` are in the folder `ViewModels` etc.

## Testing
### Mocks
For the creation of Mock objects during testing, I prefer `subclassing` instead of using `protocols` whenever possible. This has several advantages over Mocking via protocols:
- Less source files to modify when adding a new feature
- Source files are automatically in sync (with protocols, there are no warnings if there are leftover functions in the Mock)
- Easier navigation through code

In this project I used mostly `protocols` for showcasing separation of concerns and SOLID principles in action

### Testing strategy
#### Testing combine streams
It's not required to write tests here but we can achieve testing of models as:
1. create a mock json file for mocked fake api respons `response.json`.
2. implement a mock `DataProviding` service, that reads that file from the `Bundle` and returns the result in publisher, in case there are urls, we could also pass an `APIConfigurable` mock that also implements `buildURL()` method to return the right url.
3. create an expectation to asnyc. wait for the publisher's stream to be completed.
4. call `loadWeather()` method and sink the resulted publisher.
5. fulfil the expectation on `.finished` event
6. check value of the resulted stream values in the `receivedValue` handler.
Another way to test combine streams is to expect a stream of sequence of values append the values one by one to a variable and after an expectation finishes compare the resulted arrays if they match.

#### UI flow Testing
Implementing a mock coordinator that have a counter for how many times a `coordinate(to:)` with a specific step happens, we then could at the end compare the number of occurances of specific view against an expected assumption, didn't implement it due to time constraints.

### Dependency Injection
I prefer dependency injection in this priority order:
1. Initializer Injection
2. Property Injection
3. Method Injection
no `Swinject` or third party libs used.

## UI
In this project, I didn't use storyboards because especially when working in teams, we think they raise more problems than they solve. UI is done in code and I try to make as much reusable components as possible, so that we only have to write the code for a specific element once. Using Interface Builder for little things like table view cells (XIB files) can be done, but I prefer to use code for more control and debugging.

I also have a project convention for the structure of views or view controllers in the project. For initial tasks, we always implement a private `setup()` functions that is either called from within an initializer or from `viewDidLoad()`. Depending on the type of work you need to do, you can define additonal functions like `setupChildViewControllers()` (remembering: our code should explain itself). For setting up observing related stuff, we define functions `setupConstraints()` and `setupBinding()`. 

The app consists of one `UINavigationController` that presents one view controller that has one Collection View with cells containing a horizontal collectionview to implement the side-scrollable content.

### UIFactory
I didn't implement this idea fully, but the idea is to use factory pattern providing a `Theme` information to build customizable ui components that can be easily configured, and injuected to our view controllers; since it could be time-consuming, i transformed it into static methods.

## Services
`MomenWeatherSDK` contains a set or reusable and pluggable services, that uses protocol-oriented programming, we could mention some of them here:
### DataProvider
provides data fetched from different data sources, implements `DataProviding` protocol
### APIConfiguration
provides an injectable configuration to setup endpoints and build urls from app variables
### LocationProviding
Encapsulates user location fetching and monitoring (currently not used, but for future)
### ReachabilityProviding
Handles and monitors connectivity issues

## Generic types
### CoordinateType
a `propertyWrapper` type that used in carrying out `Codable` of a coordinate representation in the api, have a CoreLocation 2D coordinate transformed from a `Dictionary`

### WeatherIconType
a `propertyWrapper` type that used in carrying out `Codable` of an icon representation in the api, have a ur that is transformed from a `String` that representing an icon name, generating a valid image url for that icon.

## ViewControllers
### WeatherListViewController
Controlls the views and layouting as well as publishing and binding of viewModel's published properties and ui elements.
It has a delegate method to inform the `Coordinator` of any change the user requests, for more loose coupling, and higher cohesion.

## Coordinators
### MainCoordinator
Coordinates the app flow, and the start of the app, creates view controller, injects, monitors and presents ui elements and handling state changes an reacts to user input, also presents errors in case something happened.

## Models
### WeatherItem
Represents a single entry of weather result, including temperatures, icon and other information
### WeatherForcaseResult
Represents a response coming from the forecast api, having all data needed including a list of `WeatherItem` s
### Weather
Represents the core data of a single day/hour reading of the result, included within a `WeatherItem`
### City
Represents data for a city including country code, sunrise, sunset as well as population.

## ViewModels
### We only have one viewmodel `WeatherListViewModel` represents a state of `WeatherListViewController` called by viewController which in turn forwards the call to the coordinator in order to refresh it's data, using a delegate pattern `WeatherListViewControllerDelegate`.

## Dependency Management
I haven't used any third party libraries since it's one of the requirements.

## Programming Language
The project currently uses Swift 5 as a programming language, using xcode 12.


## Feedback

Feel free to reach me anytime using shataly@gmail.com for any information or questions, thank you.
