(function() {
    var options = {
        container    : '#juvia_thread',
        site_key     : 'o0ngfe6gaa3vyl2ls75fr0syzi3kfpz',
        topic_key    : location.pathname,
        topic_url    : location.href,
        topic_title  : document.title || location.href,
        include_base : !window.Juvia,
        include_css  : !window.Juvia,
        comment_order: 'latest-first'
    };

    function makeQueryString(options) {
        var key, params = [];
        for (key in options) {
            params.push(
                encodeURIComponent(key) +
                '=' +
                encodeURIComponent(options[key]));
        }
        return params.join('&');
    }

    function makeApiUrl(options) {
        // Makes sure that each call generates a unique URL, otherwise
        // the browser may not actually perform the request.
        if (!('_juviaRequestCounter' in window)) {
            window._juviaRequestCounter = 0;
        }

        var result =
            'https://comments.bobmaerten.eu/api/show_topic.js' +
            '?_c=' + window._juviaRequestCounter +
            '&' + makeQueryString(options);
        window._juviaRequestCounter++;
        return result;
    }

    var s       = document.createElement('script');
    s.async     = true;
    s.type      = 'text/javascript';
    s.className = 'juvia';
    s.src       = makeApiUrl(options);
    (document.getElementsByTagName('head')[0] ||
     document.getElementsByTagName('body')[0]).appendChild(s);
})();
