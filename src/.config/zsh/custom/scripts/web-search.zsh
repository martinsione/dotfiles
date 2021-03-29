# web_search from terminal

function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    $ZSH_WEB_SEARCH_ENGINES
    google          "https://www.google.com/search?q="
    duckduckgo      "https://www.duckduckgo.com/?q="
    github          "https://github.com/search?q="
    stackoverflow   "https://stackoverflow.com/search?q="
    archive         "https://web.archive.org/web/*/"
    scholar         "https://scholar.google.com/scholar?q="
  )

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine '$1' not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${urls[$1]}${(j:+:)@[2,-1]}"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  open_command "$url"
}


alias gg='web_search google'
alias ddg='web_search duckduckgo'
alias gh='web_search github'
alias so='web_search stackoverflow'
alias archive='web_search archive'
alias scholar='web_search scholar'

alias dds='web_search duckduckgo \!'
alias wk='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias yt='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'

# other search engine aliases
if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="web_search $key"
  done
  unset engines key
fi
