#!/usr/bin/env bash

fonts=(
  FiraCode 
  JetBrainsMono 
  SourceCodePro
)

install_nerd_fonts() {
  for font in "${fonts[@]}"; do
    local font_path="$HOME/.local/share/fonts/${font}"
    if [[ ! -d "${font_path}" ]]; then
       curl -L --create-dirs "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${font}.zip" -o "${font_path}.zip"
       unzip "${font_path}.zip" -d "${font_path}"
       rm -rf "${font_path}.zip" 
    else
      echo "${font} is already on your system"
    fi
  done
}

install_nerd_fonts
