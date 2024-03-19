package com.visioncamerav3posedetection

import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager
import com.mrousavy.camera.frameprocessor.FrameProcessorPluginRegistry


class VisionCameraV3PoseDetectionPackage : ReactPackage {

 companion object {
    init {
      FrameProcessorPluginRegistry.addFrameProcessorPlugin("detectPose") {proxy,options ->
        VisionCameraV3PoseDetectionModule(proxy,options)
      }
    }

  }

  override fun createNativeModules(reactContext: ReactApplicationContext): List<NativeModule> {
    return emptyList()
  }

  override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
    return emptyList()
  }
}

