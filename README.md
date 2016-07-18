# MVVMReactiveLoginSample

This is a simple example of a mvvm login controller with ReactiveKit.

##Setup

1. Run `pod install`
2. Replace `private let url = "your.url.here"` in `LoginApi.swift` with your server url. For testing you can create your own fake login server as described bellow
3. Run sample

## Fake Login Server

Inside FakeLoginServer folder there's a javascript file with a fake login server that returns a successful response when `user = testuser` and `password = 1234` and an error message otherwise. 

You can deploy this file easily with Webtask:

- Install WebTask CLI 
```shel  
$ npm i -g wt-cli 
$ wt init 
```
- Navigate to FakeLoginServer folder and run 
```shel
wt create FakeLoginServer.js
```

Now just copy the url returned from the cli and paste it in `LoginApi.swift`
