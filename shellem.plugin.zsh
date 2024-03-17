plugin_dir=$(dirname "${(%):-%N}")
source $plugin_dir/shellem.conf

_autocomplete_wrapper() {
  local cursor_position=$CURSOR
  
  local current_command=$BUFFER
  
  local suggestion
  
  last_commands=$(history -5 | cut -c 8- | awk '{printf "%s\\n", $0}')
  current_dir=$(pwd)

  payload=$(jq -n --arg last_commands "$last_commands" --arg current_command "$current_command" --arg current_dir "$current_dir" '{model: "gpt-3.5-turbo", messages: [{role: "user", content: "You'"'"'re an expert in bash scripting and you'"'"'re writing zsh commands in the console. You'"'"'re in directory \($current_dir) and the last commands you typed are:\\n\($last_commands)\\nYour next command could be:\\n\($current_command)"}], stop: ["\\n"]}')
  suggestion=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d $payload | jq -r '.choices[0].message.content')

  # Check if suggestion is empty or "null"
  if [[ -z $suggestion || $suggestion == "null" ]]; then
    return
  fi
  
  print -nP "%F{$SUGGESTION_COLOR}$suggestion%f"
  
  read -k 1 -s
  if [[ $REPLY == $'\t' || $REPLY == $'\r' ]]; then
    BUFFER="$BUFFER$suggestion"
    CURSOR=$((cursor_position + ${#suggestion}))
  fi
  
  zle redisplay
}

zle -N _autocomplete_wrapper

bindkey '^ ' _autocomplete_wrapper