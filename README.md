# AppStore Clone
Created a clone of Apple's 'App Store' application to practice and learn more about Programmatic UI & using dispatch groups for syncing multiple network calls. 

### Demo 
![](demoFiles/Today.gif)
![](demoFiles/Apps.gif)
![](demoFiles/AppSearch.gif)
### Key Implementation Details  
**User Interface**
  - UICollectionView
  - UICollectionViewFlowLayout Snapping Behavior
  - MultiDimensional CollectionView
  
**API Data Fetching**
  - Fetch JSON data from iTunes Search API
  - Performs multiple fetches with DispatchGroup 

### Installation 

Install Cocoa Pods if not already installed.

`sudo gem install cocoapods`


Install necessary pods by running command in project folder. 

`pod install`


Open AppStore.xcworkspace in XCode and run

Project is currently updated for Swift 5. 
