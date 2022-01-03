. "$BASH_IT/themes/powerline-multiline/powerline-multiline.base.bash"


function __powerline_whisk_products_prompt {
  if [ -n "${WHISK_PRODUCTS}" ]; then
    echo "${WHISK_PRODUCTS_CHAR}${WHISK_PRODUCTS}|${WHISK_PRODUCTS_PROMPT_COLOR}"
  fi
}

function __powerline_whisk_mode_prompt {
  if [ -n "${WHISK_MODE}" ]; then
    echo "${WHISK_MODE_CHAR}${WHISK_MODE}|${WHISK_MODE_PROMPT_COLOR}"
  fi
}

function __powerline_whisk_site_prompt {
  if [ -n "${WHISK_SITE}" ]; then
    echo "${WHISK_SITE_CHAR}${WHISK_SITE}|${WHISK_SITE_PROMPT_COLOR}"
  fi
}

function __powerline_whisk_version_prompt {
  if [ -n "${WHISK_ACTUAL_VERSION}" ]; then
    echo "${WHISK_VERSION_CHAR}${WHISK_ACTUAL_VERSION}|${WHISK_VERSION_PROMPT_COLOR}"
  fi
}
