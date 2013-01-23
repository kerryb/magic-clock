Magic Clock (Ipswich hack day project)
======================================

This was my hack for the [Ipswich Hack Day](http://mrjaba.posterous.com/iphack-ipswichs-first-hack-day). It's a sinatra app that gets my location from Google Latitude, then uses geokit to check whether I'm close to certain locations. The page polls the server for hand position using ajax, and updates the angle of the hand with a CSS transition.

I'd intended to make it configurable for multiple users and places, with several people shown on the same clock, but spent most of the morning fighting with oauth and the google-api-client gem.

One day, I might get round to building it into a real clock using an Arduino.

![screenshot](http://farm9.staticflickr.com/8012/7123821225_96b48be949_o.jpg)
