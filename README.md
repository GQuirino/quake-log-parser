# quake-log-parser

Using Ruby + Rspec <br />
Proposed solution for https://gist.github.com/talyssonoc/a51b5a6c42c8c60c0f8c0f28b34f8dbc

## How to use

- Install dependencies<br/>
`bundle install` <br/>

- Run in your terminal<br/>
`bundle exec rake parse_game_report` <br/>

- Fill the path to the log for parsing, or just press Enter<br/>
`"Path to game.log to parse (logs/game.log):"`<br/>
`logs/game.log` is the default path <br/>

- Will generate and save the reports:

```cmd
report kills_by_means_report-20200324010513.json created!
in: reports_parsed/kills_by_means_report-20200324010513.json
```
