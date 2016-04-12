# Description:
#   Give kudos to someone
#
# Dependencies:
#   "underscore": "^1.7.0"
#
# Configuration:
#   None
#
# Commands:
#   kudos to <user> - gives the specified user a kudo
#   hubot leaderboard - displays the current kudos leaderboard
#
# Notes:
#   MODIFIED FOR SENDWITHUS
#
# Author:
#   daegren
#   brandonb927

Keeper = require('./keeper')

module.exports = (robot) ->
  keeper = new Keeper(robot)

  robot.hear /kudos to @?(.*)/i, (msg) ->
    name = msg.match[1].trim()

    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      if user.name is msg.envelope.user.name
        msg.send "Hey #{user.name}, you can't give yourself kudos! Not cool… :sadpanda:"
      else
        keeper.add user.name
        msg.send "#{user.name} is awesome!"
    else if users.length is 0
      msg.send "I don't know who #{name} is :("

  robot.hear /kudos clear/i, (msg) ->
    msg.send keeper.clear()

  robot.hear /kudos leaderboard/i, (msg) ->
    msg.send keeper.leaderboard()

  robot.hear /show brain/i, (msg) ->
    console.log robot.brain

  robot.hear /show scores/i, (msg) ->
    robot.logger.info keeper.getScores()
