## ---- eval = FALSE-------------------------------------------------------
#  realtime(function() {
#    # token registration
#    token <- rtweet::create_token(
#      app = Sys.getenv("TWITTER_APP_NAME"),
#      consumer_key = Sys.getenv("TWITTER_CONSUMER_KEY"),
#      consumer_secret = Sys.getenv("TWITTER_SECRET_KEY"))
#    # tweet
#    tweet <- rtweet::search_tweets("#auspol", n = 1, token = token)$text[1]
#    # extract sentiment
#    return(mean(sentimentr::sentiment(tweet)$sentiment))
#  }, title = "#auspol mood", ylim = c(-1, 1))

