# Description
#   A hubot script that does the things
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   animalland

module.exports = (robot) ->
  KEY_SCORE = 'animal'
  
  getScores = () ->
  return robot.brain.get(KEY_SCORE) or {}
    
  changeScore = (name, diff) ->
  source = getScores()
  score = source[name] or 0
  new_score = score + diff
  source[name] = new_score
    
  robot.brain.set KEY_SCORE, source
  return new_score
      
  robot.hear /!vote-list/i, (msg) ->
  source = getScores()
  console.log source
  for name, score of source
  msg.send "#{name}: #{score}"
        
  robot.hear /!vote-clear/i, (msg) ->
  robot.brain.set KEY_SCORE, null
          
  robot.hear /([A-z]+)\+\+$/i, (msg) ->
  name = msg.match[1]
  new_score = changeScore(name, 1)
  msg.send "#{name}: #{new_score}"
            
  robot.hear /([A-z]+)--$/i, (msg) ->
  name = msg.match[1]
  new_score = changeScore(name, -1)
  msg.send "#{name}: #{new_score}"
