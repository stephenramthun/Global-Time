# Global Time

Global Time is a simple world clock application for macOS, letting the user know what time it is in any city in the world at a glance.

![](https://github.com/stephenramthun/Global-Time/blob/master/global-time.gif)

I made this so I would be able to know what time it is back home whenever I'm travelling and working on my computer, without having to take out my phone or constantly querying Google for the current time. Here the current time of any city in the world can be displayed in the macOS system status bar for easy access.

If you want to compile and use this for yourself, you have to get developer keys for the following APIs:
- [Google Places API](https://developers.google.com/places/web-service/)
- [Google Maps Geocoding API](https://developers.google.com/maps/documentation/geocoding/intro)
- [Google Maps Time Zone API](https://developers.google.com/maps/documentation/timezone/intro)

Put these keys in a plist-file somewhere outside the project folder and modify SARAPIKeyManager.m to point to your key-plist file path.
