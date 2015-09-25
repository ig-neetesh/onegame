var pusher = new Pusher(apiKey, {
    encrypted: true
});
var channel = pusher.subscribe(channelId);
channel.bind('driving', function (data) {
    console.log(data);

});