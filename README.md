# AQIDemo

I have used MVVM architecture for this project.
To connect to the socket i have used Socket-IO   https://github.com/socketio/socket.io-client-swift

Initially i was facing issue in connecting to the socket. Then i tried a Chrome browser extension for Socket connection to verify the response. It was working as expected in the browser extension.
Then i have gone through the SocketIO-iOS library, and they have an option to allow unsecured socket connection. While configuring the Socket manager, we will have to enable the option. So i proceeded with that.


I have also used UNSplash Public API's for downloading city images and display it accordingly. The URL's are stored in UserDefaults, and retrieved back. Then the URL's are used with Swift Kingfisher library to cache the image and display it on the cells.

For charts, i have used "Charts" library  https://github.com/danielgindi/Charts

ScreenShots and demo video i have attached in a public google drive folder. Here's the link.


https://drive.google.com/drive/folders/1NUxsl8Tvir6JdznJ6CgZXL8OP9OlfliO?usp=sharing


Thanks.
