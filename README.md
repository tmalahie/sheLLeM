sheLLeM is a ZSH plugin that allows to autocomplete commands you write on your terminal, like Github Copilot
does. It works by getting your most recent commands from your history as a context to predict what will be
your next command. It uses OpenAI's LLM API to make the prediction.

## Install

- Clone the repository in the right place:

```
git clone https://github.com/tmalahie/sheLLeM ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellem
```

- Edit the configuration file here: `~/.oh-my-zsh/custom/plugins/shellem/shellem.conf`. You'll need a working
  [OpenAI API key](https://platform.openai.com/docs/quickstart/account-setup).
- Enable the plugin in your `~/.zshrc` file:

```
plugins=(
    # other plugins...
    shellem
)
```

- Load the updated file: `source ~/.zshrc`
- You're done! Start typing something in the console and hit **Ctrl+Space**. You should see some suggestions
  appear. Hit Tab or Enter to accept the suggestion, or any other key to reject it.
  <img width="381" alt="asset" src="https://github.com/tmalahie/sheLLeM/assets/10288728/7b5d5677-1d86-4cc4-ba27-5899819bf65e">
