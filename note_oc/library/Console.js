console = {
log: function (string) {
    window.webkit.messageHandlers.OOCC.postMessage({className: 'Console', functionName: 'log', data: string});
}
}