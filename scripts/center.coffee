# Description:
#   A series of response commands that is connected with
#   our command center, allows to easily find information
#

module.exports = (robot) ->
    robot.respond /website find (.*)/i, (msg) ->
        website_name = msg.match[1]
        center_url = process.env.CENTER_API_ROOT
        center_token = process.env.CENTER_TOKEN

        robot.http("#{center_url}/en/api/websites/websites/?name=#{website_name}")
            .header("Authorization", "Token #{center_token}")
            .header("Accept", "application/json")
            .get() (err, res, body) ->
                if err
                    msg.send "Encountered an error :( #{err}"
                    return

                try
                    data = JSON.parse body
                catch error
                    msg.send 
                    return "Encountered an error :( #{error}"

                if data.results.length > 0
                    response = "I found this websites:\n"
                    for website in data.results
                        response += "#{website.name} - #{center_url}#{website.url}\n"
                else
                    response = "I coudn't find any website with the name or url: #{website_name}"

                msg.send response

