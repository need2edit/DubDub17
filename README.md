# DubDub17
A sample project based on the WWDC App for learning `Coordinator` and `Model View ViewModel (MVVM)` design patterns in iOS and Swift 3.

# Solving a Problem
'Massive View Controllers' are a thing. An elegant and testable way to avoid this is using the coordinator pattern.

# Core Concepts

- A coordinator is way to lift a number of tasks up and outside of a view controller. 
- View controllers should know nothing about their parent or sibling view controllers.
- Each view controller manages the views inside in a trivial manner.
- When a view controller has distinct states, it switches on them using an enum.
- A view controller (when appropriate) provides a delegate so a coordinator can react to the steps in a given workflow, while still keeping the view controller in the dark. 

# Designing the App
This app is based on the awesome WWDC app that Apple updates each year.

- Services like Videos, Schedule, News, and Venue are all represented in the app as coordinators.
- If there are smaller workflows (e.g. providing feedback, picking a photo) their may be child coordiantors.
- Each coordinator has a single `start()` method.

# Learning Apple Frameworks
This is a great example for working with a complex data set, calendars, video, and location services all in one place.

# Todo List
This is a work in progress. Trying to make it happen by the end of WWDC week!

[ ] Videos Tab
[ ] Schedule Tab
[ ] News Tab
[ ] Venue Tab
