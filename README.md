
The Frame processor plugin for detecting pose using Google ML Kit library for react-native-vision-camera with high performance.

# 🚨 Required Modules

react-native-vision-camera => 3.9.0 <br />
react-native-worklets-core = 0.4.0

## 💻 Installation

```sh
yarn add react-native-vision-camera-v3-pose-detection
npm install react-native-vision-camera-v3-pose-detection
```

## 👷Features
    Easy To Use.
    Works Just Writing few lines of Code.
    Works With React Native Vision Camera.
    Works for Both Cameras.
    Works Fast.
    Works With Android 🤖 and IOS.📱
    Writen With Kotlin and Objective-C.

## 💡 Usage

```js
import { Camera } from 'react-native-vision-camera-v3-pose-detection';

const [pose,setPose] = useState(null)

console.log(pose)

<Camera
  // optional
  options={{
    mode: "stream",
    performanceMode:"max"
    }}
  style={StyleSheet.absoluteFill}
  device={device}
  callback={(data) => setPose(data)}
  {...props}
/>
```


---

## ⚙️ Options

| Name |  Type    |     Values     | Default |
| :---:   | :---: |:--------------:|:-------:|
| mode | string | stream, single | stream  |
| performanceMode | string |    min, max    |   min   |
















