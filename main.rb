require 'httparty'
require 'json'

# Environment variable must be set with your token.
URL_TOKEN_STRING =  ENV['SLACK_URL_TOKEN_STRING']

class RNG
  def initialize()
    @_rng = Random.new(Random.new_seed % (2**16))
  end

  def between(low, high)
    @_rng.rand(low..high)
  end
end

class Bot
  def initialize(settings)
    @user = settings["user"]
    @min_interval = settings["interval"]["min"]
    @max_interval = settings["interval"]["max"]
    @exercises = settings["exercises"]

    @post_url = "https://#{settings["team"]}.slack.com/services/hooks/slackbot?token=#{URL_TOKEN_STRING}"
    @rng = RNG.new
  end

  def random_exercise
    index = @rng.between(0, @exercises.length - 1)
    @exercises[index]
  end

  def random_time_interval
    @rng.between(@min_interval * 60, @max_interval * 60)
  end

  def sleep_to_next_exercise
    sleep(random_time_interval)
  end

  def random_reps(exercise)
    reps = exercise["repetitions"]
    @rng.between(reps["min"], reps["max"] + 1)
  end

  def announce_exercise(exercise, reps)
    winner_announcement = "#{reps} #{exercise["units"]} #{exercise["name"]} RIGHT NOW!"

    HTTParty.post(@post_url, query: { channel: "@" + @user }, body: winner_announcement)
    puts winner_announcement
  end
end

# Run the bot.
bot = Bot.new(JSON.load(File.new("config.json")))

while true
  bot.sleep_to_next_exercise

  next_exercise = bot.random_exercise
  next_reps = bot.random_reps(next_exercise)

  bot.announce_exercise(next_exercise, next_reps)
end
