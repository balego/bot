# Description:
#   A series of response commands that is connected with
#   our command center, allows to easily find information
#
# Configuration:
#   CENTER_API_ROOT
#   CENTER_TOKEN
#
# Commands:
#   hubot website find <name> - Find a website with the name or URL
#   hubot domain find <name> - Find a domain with the name or URL
#
# Author :
#   ikcam

center_api = (robot, msg, path, type) ->
    center_url = process.env.CENTER_API_ROOT
    center_token = process.env.CENTER_TOKEN

    robot
        .http("#{center_url}/en/api/#{path}")
        .header("Authorization", "Token #{center_token}")
        .header("Accept", "application/json")
        .get() (err, res, body) ->
            if err
                msg.send "Encountered an error :( #{err}"
                return

            try
                data = JSON.parse body
            catch error
                msg.send "Encountered an error :( #{error}"
                return

            if data.count > 0
                response = "I found this #{type}:\n"
                for website in data.results
                    response += "#{website.name} - #{center_url}#{website.url}\n"

                msg.send response
            else
                msg.send "I coudn't find anything :("


module.exports = (robot) ->
    robot.respond /domain find (.*)/i, (msg) ->
        name = msg.match[1]
        path = "websites/domains/?name=#{name}"

        response = center_api(robot, msg, path, 'domains')

    robot.respond /website find (.*)/i, (msg) ->
        name = msg.match[1]
        path = "websites/websites/?name=#{name}"

        response = center_api(robot, msg, path, 'websites')
