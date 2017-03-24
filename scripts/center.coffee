module.exports = (robot) ->
    robot.respond /find website (*.)/i, (res) ->
        # Website name
        websiteName = res.match[1]

        robot
            .http(process.env.CENTER_API_ROOT + "/en/api/websites/websites/")
            .header("Authorization", "Token: " + process.env.CENTER_TOKEN)
            .get()(err, res, body) ->
                if err
                    res.send "Encountered an error :( #{err}"
                    return

                res.send "I found this websites:"
                for website in res.results
                    res.send website.name + " - " + process.env.CENTER_API_ROOT + website.url

