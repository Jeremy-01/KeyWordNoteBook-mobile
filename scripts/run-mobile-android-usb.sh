#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mobile_dir="$repo_root/mobile"
prepare_only=false

find_adb() {
  if command -v adb >/dev/null 2>&1; then
    command -v adb
    return
  fi

  if [[ -n "${ANDROID_SDK_ROOT:-}" && -x "$ANDROID_SDK_ROOT/platform-tools/adb" ]]; then
    echo "$ANDROID_SDK_ROOT/platform-tools/adb"
    return
  fi

  if [[ -x "$HOME/Library/Android/sdk/platform-tools/adb" ]]; then
    echo "$HOME/Library/Android/sdk/platform-tools/adb"
    return
  fi

  echo "adb not found. Install Android platform-tools or set ANDROID_SDK_ROOT." >&2
  exit 1
}

detect_device() {
  local devices=()

  while IFS= read -r device; do
    devices+=("$device")
  done < <("$adb_bin" devices | awk 'NR > 1 && $2 == "device" { print $1 }')

  if [[ "${#devices[@]}" -eq 0 ]]; then
    echo "No Android device is connected." >&2
    exit 1
  fi

  if [[ "${#devices[@]}" -gt 1 ]]; then
    echo "Multiple Android devices are connected. Pass -d <deviceId> or set ANDROID_SERIAL." >&2
    exit 1
  fi

  echo "${devices[0]}"
}

adb_bin="$(find_adb)"
flutter_args=()
device_id="${ANDROID_SERIAL:-}"

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --prepare-only)
      prepare_only=true
      shift
      ;;
    -d)
      if [[ "$#" -lt 2 ]]; then
        echo "Missing device ID after -d." >&2
        exit 1
      fi
      device_id="$2"
      flutter_args+=("$1" "$2")
      shift 2
      ;;
    *)
      flutter_args+=("$1")
      shift
      ;;
  esac
done

if [[ -z "$device_id" ]]; then
  device_id="$(detect_device)"
  if [[ "$prepare_only" == false ]]; then
    if [[ "${#flutter_args[@]}" -eq 0 ]]; then
      flutter_args=(-d "$device_id")
    else
      flutter_args=(-d "$device_id" "${flutter_args[@]}")
    fi
  fi
fi

echo "[mobile] adb reverse tcp:8000 tcp:8000 -> $device_id"
"$adb_bin" -s "$device_id" reverse tcp:8000 tcp:8000

if [[ "$prepare_only" == true ]]; then
  exit 0
fi


cd "$mobile_dir"
if [[ "${#flutter_args[@]}" -eq 0 ]]; then
  echo "[mobile] flutter run"
  exec flutter run
fi

echo "[mobile] flutter run ${flutter_args[*]}"
exec flutter run "${flutter_args[@]}"