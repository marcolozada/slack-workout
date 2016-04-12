# Slack Workout

Let Slackbot remind you to get up, walk around, stretch, do some exercises, etc.

## Installation

1. Clone the repo.

```
$ git clone git@github.com:dontmitch/slack-workout.git
```

2. Go to your Slack [home page](http://my.slack.com/home) and navigate to **Integrations**.

3. Click on the **Slackbot** option and register a new integration.

4. Grab the resulting token out of the url. e.g. `1Bs2m3kLg6LlVwsDbHBjIaSz`

5. Save the token in your environment as SLACK_URL_TOKEN_STRING.

  ```
  $ export SLACK_URL_TOKEN_STRING=your_token_here
  ```

  Alternatively, you can add that line to your `~/.bash_profile` or `~/.bashrc`.

6. Navigate to the project directory and edit the config.json file as desired. At a minimum, update the `team` (e.g. penny) and `user` (e.g. mitch).

7. While in the project directory, run the script.

  ```
  $ ruby main.rb
  ```

As long as the script is running, Slackbot will randomly send you reminders to do your chosen activities!

## Inspiration

This script was heavily inspired by [Slackbot Workout](https://github.com/brandonshin/slackbot-workout), a workout bot built for groups of people.
