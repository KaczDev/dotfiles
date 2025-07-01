module.exports = {
  defaultBrowser: "Google Chrome",
  options: {
    hideIcon: false,
    checkForUpdate: true,
  },
  handlers: [
    {
      match: ({ opener }) =>
        ["Slack", "Microsoft Outlook", "Zoom Workplace"].includes(opener.name),
      browser: {
        name: "Google Chrome",
        profile: "KaczDev",
      },
    },
    {
      match: ({ url }) => url.protocol === "slack",
      browser: "/Applications/Slack.app",
    },
  ],
};
