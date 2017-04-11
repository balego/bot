# Description:
#   Pulls a random programmer Ryan Gosling image
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_TUMBLR_API_KEY
#
# Commands:
#   hubot gosling - Receive a random programmer Ryan Gosling meme
#
# Author:
#   jessedearing

api_key = process.env.HUBOT_TUMBLR_API_KEY

getRandomGoslingImageUrl = (msg, rand) ->
  msg.http("http://api.tumblr.com/v2/blog/programmerryangosling.tumblr.com/posts?api_key=#{api_key}&offset=#{rand}&limit=1").get() (err, res, body) ->
    post = JSON.parse(body)
    msg.send(post.response.posts[0].photos[0].original_size.url)

module.exports = (robot) ->
  robot.respond /gosling/i, (msg) ->
    getRandomGoslingImageUrl(msg)
