A PWA built with Ruby on Rails designed to help me track daily habits. While I built this for my personal usage, it now lives on a VPS with active users. Here are some of the ideas behind it:

## Ideas behind the app

- Keep capture simple: a habit has either been done or not.
- Logging should be easy, one tap.
- Visualize progress at a glance with heatmap calendars.
- Use color as an indication of activity. The more you do, the more colorful the app.
- Don't rely on streaks only: they are motivating, but can discourage when broken.

## Tech stack

- Created with Ruby on Rails 8, no third-party gems.
- Views are mostly server-rendered (including calendars), with some AJAX and optimistic UI JavaScript for a better experience.
- The app stores data using SQLite and is deployed via Kamal.

## Features I'd like to add

- Create interesting achievements (ideas welcome!), each with a CSS design.
- Support for different color schemes the user can choose from.
- Support for time zones, adjusting logging based on the user's local time.
- Ability to correct past days (with enough friction to avoid temptation).
- Ability to export your data.
- Improve built-in timer.
