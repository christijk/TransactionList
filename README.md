# WorldOfPAYBACK
iOS app to display a list of transactions, and a corresponding detail screen for each.

# Requirements

- iOS 15.0+
- Xcode 14+
- Swift 5+

## Overview

* Two schemas: WorldOfPAYBACK Debug, WorldOfPAYBACK Release are defined which will use Debug and Release configs respectively. 
* Strings file is added to support Localization

'WorldOfPAYBACK' App has 4 tabs.
* Transactions: 
	- This tab will list transactions (from json file PBTransactions.json) sorted by `bookingDate` from newest (top) to oldest (bottom)
	- Fiilter option allows user to filter transactions based on the categories
	- Sum of the listed transctions is displayed at the end of list
	- Randomly API call fails, which will be informed to customer as an alert with a 'Retry' option 
	- You can navigate to the details by tapping on a transaction.
* Feed, Shop, Settings tabs are for future development


## How To

### Run The App

- Download the project or clone the git repository to your machine
- Open 'WorldOfPAYBACK.xcodeproj' using Xcode 14.0 or later
- Select the 'Project navigator' and select project file
- Open Signing&Capabilities tab and select your team / personal team
- Update bundle id if required and make it compatible with team
- Select the device / simulator you wish to run
- Product -> Run or `CMD+R`

### Run The Tests

- To run the tests Product -> Test or `CMD+U`

# Screenshots

### Transactions Listing Screeen

![simulator_screenshot_3D58B128-185E-4955-B656-52B5CE81392D](https://user-images.githubusercontent.com/41156474/215592554-53525162-a0d3-429e-a903-1da95e5edea3.png)

### Transaction Details Screeen

![simulator_screenshot_15078132-C231-463C-BAAE-A23DA6841CEA](https://user-images.githubusercontent.com/41156474/215592612-9d52443d-9d18-4d68-82b7-577723d85a7c.png)

