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

![sim1](https://user-images.githubusercontent.com/41156474/215595172-e21c26c0-c2f0-498c-9f03-6a6010086fa2.jpg)


### Transaction Details Screeen

![Sim 2](https://user-images.githubusercontent.com/41156474/215595198-694699d6-549b-4389-91ec-269dd2505478.jpg)


