var pusher = new Pusher(apiKey, {
    encrypted: true
});
var channel = pusher.subscribe(channelId);
channel.bind(eventName, eventCallback);
console.log("token : " + channelId);
console.log("event : " + eventName);