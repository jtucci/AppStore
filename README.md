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
