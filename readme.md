# Music Player

An example of a music player with the minimize functionality like the Spotify player built in SwiftUI.

## Summary

The inspiration for this example comes from the Spotify music player. I challenged myself to build a music player that could be swiped down to be minimized in SwiftUI completely.

One of the main features I used was GeometryReader which returns the size and coordinates of the views it encapsulates. This allows me to calculate when to transition and fade in the mini player as the user swipes down.

I used a ViewModel to load the song data and created a decodeJSON function that uses Generics to allow me to load any data type I need. In this case a custom model called Song.

The example does play songs while showing the functionality of minimizing the player.

Enjoy!

