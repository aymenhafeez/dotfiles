return {
  { prefix = "s",    desc = "Section",           body = { "# $1", "", "$0" } },
  { prefix = "ss",   desc = "Sub Section",       body = { "## $1", "", "$0" } },
  { prefix = "sss",  desc = "SubSub Section",    body = { "### $1", "", "$0" } },
  { prefix = "par",  desc = "Paragraph",         body = { "#### $1", "", "$0" } },
  { prefix = "spar", desc = "Sub Paragraph",     body = { "##### $1", "", "$0" } },
  { prefix = "link", desc = "Link to something", body = "[$1]($2)$0" },
  { prefix = "img",  desc = "Image",             body = "![$1]($2)$0" },
  { prefix = "bf",   desc = "bold text",         body = "**$1**$0" },
  { prefix = "it",   desc = "italic text",       body = "*$1*$0" },
  { prefix = "im",   desc = "inline mathzone",   body = "$$1$$0" },
}
