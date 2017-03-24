module.exports = (robot) ->
    robot.respond /website find (.*)/i, (res) ->
        # Vars
        website_name = res.match[1]
        center_url = process.env.CENTER_API_ROOT
        center_token = process.env.CENTER_TOKEN

        robot.http("#{center_url}/en/api/websites/websites/?name=#{website_name}")
            .header("Authorization", "Token #{center_token}")
            .get() (err, resp, body) ->
                if err
                    res.reply "Encountered an error :( #{err}"
                    return

                data = JSON.parse body

                res.reply "I found this websites:"
                for website in data.results
                    res.reply "#{website.name} - #{center_url}#{website.url}"

