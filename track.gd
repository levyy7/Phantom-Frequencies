extends Node

var JSWindow = JavaScriptBridge.get_interface("window")


func track(name):
    if JSWindow != null:
        JSWindow.trackEvent(name)