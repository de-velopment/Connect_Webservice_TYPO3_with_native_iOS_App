# Connect Webservice TYPO3 with native iOS App
============================================

## Shows News as HTML output or directly via JSON in an iOS app.

<img src="https://github.com/de-velopment/Connect_Webservice_TYPO3_with_native_iOS_App/blob/master/TYPO3_Extbase_iOS_1.png" width="355px">

*iOS Tableview Controller*

<img src="https://github.com/de-velopment/Connect_Webservice_TYPO3_with_native_iOS_App/blob/master/TYPO3_Extbase_ios_2.png" width="355px">

*iOS Detailview Controller*


### 1.Step

Install TYPO3 Extension de_news in your TYPO3 package

### 2.Step

Create Sysfolder for News and write newsarticle (Listview)

### 3.Step

Create new page type in your setup.ts

`json = PAGE

json {

typeNum = 100

10 < styles.content.get

10 {

select.where = colpos = 0

select.andWhere = list_type = 'denews_dedisplaynews'

}

config{

disableAllHeaderCode = 1

additionalHeaders = Content-type:application/json

disablePrefixComment = 1

xhtml_cleaning = 0

no_cache = 1

debug = 0

  }

}`

### 4.Step

Insert Extension as plugin in your TYPO3 Page ->Maincolumn
set your Datastorage folder (your sysFolder for news)

### 5.Step

Go to your Newspage @ frontend, check the json output via URL:

http://(yourDomain)index.php?id=(yourPageId)&type=100&tx_denews_dedisplaynews[controller]=Article&tx_denews_dedisplaynews[action]=json

*Notice: change yourdomain & yourPageId*

### 6.Step

* Open the TYPO3 Extbase News Xcode Project
* Open the TableviewController.m File
* Insert in Line 14 your TYPO3 URL (Step 5)

### 7.Step

Build & Run the app in Xcode


