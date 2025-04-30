RC_FILES="$(dirname "$(readlink -f "$0")")"

if [ ! -f $HOME/.local/bin/zsh ]
then
    $RC_FILES/install-local-zsh.sh
fi

ln $RC_FILES/.zshenv $HOME/.zshenv
ln $RC_FILES/.zshrc $HOME/.zshrc
ln $RC_FILES/.vimrc $HOME/.vimrc


if ! command -v fzf 2>&1 >/dev/null
then
  mkdir $HOME/fzf
  cd $HOME/fzf

  BIN_DIR="$HOME/.local/bin"
  REPO_URL="https://github.com/junegunn/fzf"
  command -v curl >/dev/null 2>&1 || { echo "Error: curl is required" >&2; exit 1; }
  command -v tar >/dev/null 2>&1 || { echo "Error: tar is required" >&2; exit 1; }
  API_RESPONSE=$(curl -sL https://api.github.com/repos/junegunn/fzf/releases/latest)
  TAG=$(echo "$API_RESPONSE" | grep tag_name | cut -d'"' -f4)
  VERSION=$(echo "$TAG" | sed 's/^v//')  # Remove 'v' prefix
  OS=$(uname -s | tr '[:upper:]' '[:lower:]')
  ARCH=$(uname -m)
  case "$ARCH" in
    x86_64)  ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    armv7l)  ARCH="armv7" ;;
    arm64)
      [ "$OS" = "darwin" ] && ARCH="arm64" || ARCH="armv7"
      ;;
    *)
      echo "Unsupported architecture: $ARCH" >&2
      exit 1
      ;;
  esac
  case "$OS" in
    darwin) OS="darwin" ;;
    linux)  OS="linux" ;;
    *)
      echo "Unsupported OS: $OS" >&2
      exit 1
      ;;
  esac
  TARBALL="fzf-${VERSION}-${OS}_${ARCH}.tar.gz"
  DOWNLOAD_URL="${REPO_URL}/releases/download/${TAG}/${TARBALL}"
  curl -L --progress-bar "$DOWNLOAD_URL" -o "$TARBALL"
  mkdir -p "$BIN_DIR"
  tar -xzf "$TARBALL" -C "$BIN_DIR" fzf

  cd $HOME
  rm -rf $HOME/fzf
fi
