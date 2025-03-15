# Slack Shortcuts for Alfred

This helper lets you create Alfred shortcuts for Slack channels and DMs, so that you can type `eng` into Alfred and open the Slack app to the `#eng` channel, or type `lucy` into Alfred and open the Slack app to your messages with Lucy.

## Usage

1. Make a text file in this directory called `shortcut_definitions.txt` and open it.
2. Open the Slack web app at <http://app.slack.com> and click the option to open the web app rather than launch the macOS app.
3. For each channel or DM that you want to make a shortcut for:

    1. Click the name in the Slack web app sidebar and then copy the URL (`⌘L` `⌘C`).
    2. Add a line in `shortcut_definitions.txt` with the shortcut name followed by a space followed by the URL.

    At the end of this, you should have a like:

		```
		general https://app.slack.com/client/T0123ABC/C0123ABC
		eng https://app.slack.com/client/T0123ABC/C0456DEF
		bob https://app.slack.com/client/T0123ABC/D0123ABC
		lucy https://app.slack.com/client/T0123ABC/D0456DEF
		```

4. Run `./make_shortcuts.sh`, which will make shortcuts in `$HOME/shortcuts`
5. Open `$HOME/shortcuts` in Finder
6. In Alfred Preferences (open Alfred then press `⌘,`), open Features > Default Results
    1. In the Extras section, click `Advanced` and drag in one of the files from `$HOME/shortcuts` to add the "internet location" files to Alfred's search index.
    2. In the Search Scope section, click `+` and select `$HOME/shortcuts` to add it to the list of directories

Now you should be able to type one of the keywords you specified to open it in the Slack app!
