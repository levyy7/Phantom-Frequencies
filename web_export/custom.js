function trackEvent(str) {
    // Send a tracking event to simpleanalytics with the URL as metadata
    var url = window.location.href;
    var data = { event: str, metadata: url };

    if (window.sa_event) {
        sa_event(str, data);
    }
}