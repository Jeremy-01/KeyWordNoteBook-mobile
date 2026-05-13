#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
package_name="com.example.keybook"
app_component="$package_name/.MainActivity"

action=""
device_id="${ANDROID_SERIAL:-}"
email=""
password=""
out_dir=""

usage() {
  cat <<'EOF'
Usage:
  scripts/run-mobile-android-uiautomator.sh <action> [options]

Actions:
  login-open-settings   Force-stop and reopen app, log in, then open settings.
  settings-logout       Assume app is already on settings page, scroll to logout and confirm.

Options:
  -d <deviceId>         Target Android device ID. Defaults to ANDROID_SERIAL or auto-detect.
  --email <email>       Login email for login-open-settings.
  --password <pwd>      Login password for login-open-settings.
  --out-dir <dir>       Directory for result screenshot/XML. Defaults to TMPDIR.
  -h, --help            Show this help.

Examples:
  scripts/run-mobile-android-uiautomator.sh settings-logout -d EILN9T6DZ9QWEY9P
  scripts/run-mobile-android-uiautomator.sh login-open-settings --email user@example.com --password secret
EOF
}

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

find_sdk_root() {
  if [[ -n "${ANDROID_SDK_ROOT:-}" && -d "$ANDROID_SDK_ROOT" ]]; then
    echo "$ANDROID_SDK_ROOT"
    return
  fi

  if [[ -d "$HOME/Library/Android/sdk" ]]; then
    echo "$HOME/Library/Android/sdk"
    return
  fi

  echo "Android SDK not found. Set ANDROID_SDK_ROOT." >&2
  exit 1
}

find_platform_dir() {
  local candidate
  local selected=""

  for candidate in "$sdk_root"/platforms/android-*; do
    [[ -f "$candidate/android.jar" && -f "$candidate/uiautomator.jar" ]] || continue
    selected="$candidate"
  done

  if [[ -z "$selected" ]]; then
    echo "Could not find a platform with android.jar and uiautomator.jar under $sdk_root/platforms." >&2
    exit 1
  fi

  echo "$selected"
}

find_d8() {
  local candidate
  local selected=""

  for candidate in "$sdk_root"/build-tools/*/d8; do
    [[ -x "$candidate" ]] || continue
    selected="$candidate"
  done

  if [[ -z "$selected" ]]; then
    echo "Could not find d8 under $sdk_root/build-tools." >&2
    exit 1
  fi

  echo "$selected"
}

find_junit_jar() {
  local candidates=(
    "$HOME/.m2/repository/junit/junit/4.12/junit-4.12.jar"
    "/Applications/IntelliJ IDEA CE.app/Contents/plugins/junit/lib/junit.jar"
    "/Applications/Android Studio.app/Contents/plugins/junit/lib/junit.jar"
  )
  local candidate

  for candidate in "${candidates[@]}"; do
    if [[ -f "$candidate" ]]; then
      echo "$candidate"
      return
    fi
  done

  echo "Could not find junit.jar. Install junit locally or update find_junit_jar()." >&2
  exit 1
}

detect_device() {
  local devices=()
  local device

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

escape_java_string() {
  local value="$1"
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  value=${value//$'\n'/\\n}
  printf '%s' "$value"
}

write_sources() {
  local src_dir="$1"
  local escaped_email="$2"
  local escaped_password="$3"

  mkdir -p "$src_dir/android/test"

  cat > "$src_dir/android/test/RepetitiveTest.java" <<'EOF'
package android.test;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface RepetitiveTest {
  int numIterations();
}
EOF

  cat > "$src_dir/LoginOpenSettingsTest.java" <<EOF
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiSelector;
import com.android.uiautomator.testrunner.UiAutomatorTestCase;

public class LoginOpenSettingsTest extends UiAutomatorTestCase {
  private static final String EMAIL = "$escaped_email";
  private static final String PASSWORD = "$escaped_password";

  public void testLoginAndOpenSettings() throws Exception {
    UiDevice device = getUiDevice();

    UiObject loginButton = new UiObject(new UiSelector().description("进入密码库"));
    if (!loginButton.waitForExists(5000)) {
      throw new AssertionError("Login button did not appear");
    }

    UiObject emailField = new UiObject(
        new UiSelector().className("android.widget.EditText").instance(0));

    if (!emailField.waitForExists(3000)) {
      throw new AssertionError("Email field did not appear");
    }

    emailField.setText(EMAIL);

    device.swipe(610, 1450, 610, 950, 20);
    sleep(500);

    UiObject passwordField = new UiObject(
        new UiSelector().className("android.widget.EditText").instance(1));
    if (!passwordField.waitForExists(3000)) {
      throw new AssertionError("Password field did not appear after swipe");
    }

    passwordField.setText(PASSWORD);

    device.pressBack();
    sleep(500);

    if (!loginButton.exists()) {
      device.swipe(610, 1800, 610, 900, 20);
      sleep(500);
    }

    if (!loginButton.waitForExists(3000)) {
      throw new AssertionError("Login button did not become visible after swipe");
    }

    if (!loginButton.click()) {
      throw new AssertionError("Failed to click login button");
    }

    UiObject emptyState = new UiObject(new UiSelector().descriptionContains("暂无密码条目"));
    if (!emptyState.waitForExists(10000)) {
      throw new AssertionError("Home screen did not appear after login");
    }

    if (!device.click(1142, 229)) {
      throw new AssertionError("Failed to tap settings button");
    }

    UiObject autoLockItem = new UiObject(new UiSelector().descriptionContains("自动锁定"));
    if (!autoLockItem.waitForExists(5000)) {
      throw new AssertionError("Settings screen did not appear after tapping settings button");
    }
  }
}
EOF

  cat > "$src_dir/SettingsLogoutTest.java" <<'EOF'
import android.graphics.Rect;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiSelector;
import com.android.uiautomator.testrunner.UiAutomatorTestCase;

public class SettingsLogoutTest extends UiAutomatorTestCase {
  public void testSettingsLogout() throws Exception {
    UiDevice device = getUiDevice();
    UiObject confirmButton = findConfirmLogoutButton(device, false);

    if (confirmButton != null) {
      clickObject(confirmButton, "确认退出");
      assertLoggedOut();
      return;
    }

    UiObject autoLockItem = new UiObject(new UiSelector().descriptionContains("自动锁定"));
    if (!autoLockItem.waitForExists(3000)) {
      throw new AssertionError("Settings screen did not appear before logout");
    }

    UiObject logoutButton = findLogoutButton(device);
    tapCenter(device, logoutButton, "退出登录");

    confirmButton = findConfirmLogoutButton(device, true);
    if (confirmButton == null) {
      throw new AssertionError("Logout confirmation did not appear");
    }

    clickObject(confirmButton, "确认退出");

    assertLoggedOut();
  }

  private void assertLoggedOut() throws Exception {
    UiObject loginTitle = new UiObject(new UiSelector().descriptionContains("登录到你的保险库"));
    if (!loginTitle.waitForExists(10000)) {
      throw new AssertionError("Login screen did not appear after logout");
    }
  }

  private UiObject findLogoutButton(UiDevice device) throws Exception {
    for (int attempt = 0; attempt < 6; attempt++) {
      UiObject byDescription = new UiObject(new UiSelector().description("退出登录"));
      UiObject byText = new UiObject(new UiSelector().text("退出登录"));

      if (byDescription.exists()) {
        return byDescription;
      }

      if (byText.exists()) {
        return byText;
      }

      device.swipe(610, 2300, 610, 900, 20);
      sleep(400);
    }

    throw new AssertionError("Could not find logout button on settings screen");
  }

  private UiObject findConfirmLogoutButton(UiDevice device, boolean allowScroll) throws Exception {
    for (int attempt = 0; attempt < (allowScroll ? 6 : 1); attempt++) {
      UiObject byDescription = new UiObject(new UiSelector().description("退出"));
      UiObject byText = new UiObject(new UiSelector().text("退出"));

      if (byDescription.exists()) {
        return byDescription;
      }

      if (byText.exists()) {
        return byText;
      }

      if (!allowScroll) {
        break;
      }

      device.swipe(610, 2300, 610, 1500, 20);
      sleep(400);
    }

    return null;
  }

  private void tapCenter(UiDevice device, UiObject object, String label) throws Exception {
    Rect bounds = object.getBounds();
    if (bounds.isEmpty()) {
      throw new AssertionError(label + " bounds are empty");
    }

    if (!device.click(bounds.centerX(), bounds.centerY())) {
      throw new AssertionError("Failed to tap " + label);
    }

    sleep(600);
  }

  private void clickObject(UiObject object, String label) throws Exception {
    if (!object.isClickable()) {
      throw new AssertionError(label + " is not clickable");
    }

    if (!object.click()) {
      throw new AssertionError("Failed to click " + label);
    }

    sleep(600);
  }
}
EOF
}

build_jar() {
  local build_root="$1"
  local escaped_email="$2"
  local escaped_password="$3"
  local src_dir="$build_root/src"
  local classes_dir="$build_root/classes"
  local dex_dir="$build_root/dex"
  local compiled_jar="$build_root/compiled-classes.jar"
  local jar_path="$build_root/mobile-uiautomator.jar"

  rm -rf "$build_root"
  mkdir -p "$classes_dir" "$dex_dir"

  write_sources "$src_dir" "$escaped_email" "$escaped_password"

  javac -source 8 -target 8 \
    -cp "$android_jar:$uiautomator_jar:$junit_jar" \
    -d "$classes_dir" \
    "$src_dir/android/test/RepetitiveTest.java" \
    "$src_dir/LoginOpenSettingsTest.java" \
    "$src_dir/SettingsLogoutTest.java"

  jar cf "$compiled_jar" -C "$classes_dir" .

  "$d8_bin" \
    --lib "$android_jar" \
    --classpath "$uiautomator_jar" \
    --classpath "$junit_jar" \
    --output "$dex_dir" \
    "$compiled_jar"

  jar cf "$jar_path" -C "$dex_dir" classes.dex
  echo "$jar_path"
}

capture_state() {
  mkdir -p "$out_dir"

  "$adb_bin" -s "$device_id" exec-out screencap -p > "$out_dir/result.png"

  local remote_xml="/sdcard/$(basename "$out_dir")-result.xml"
  "$adb_bin" -s "$device_id" shell uiautomator dump "$remote_xml" >/dev/null
  "$adb_bin" -s "$device_id" pull "$remote_xml" "$out_dir/result.xml" >/dev/null

  echo "$out_dir/result.png"
  echo "$out_dir/result.xml"
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    login-open-settings|settings-logout)
      if [[ -n "$action" ]]; then
        echo "Only one action can be run at a time." >&2
        exit 1
      fi
      action="$1"
      shift
      ;;
    -d)
      if [[ "$#" -lt 2 ]]; then
        echo "Missing device ID after -d." >&2
        exit 1
      fi
      device_id="$2"
      shift 2
      ;;
    --email)
      if [[ "$#" -lt 2 ]]; then
        echo "Missing email after --email." >&2
        exit 1
      fi
      email="$2"
      shift 2
      ;;
    --password)
      if [[ "$#" -lt 2 ]]; then
        echo "Missing password after --password." >&2
        exit 1
      fi
      password="$2"
      shift 2
      ;;
    --out-dir)
      if [[ "$#" -lt 2 ]]; then
        echo "Missing directory after --out-dir." >&2
        exit 1
      fi
      out_dir="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$action" ]]; then
  echo "Missing action." >&2
  usage >&2
  exit 1
fi

if [[ "$action" == "login-open-settings" ]]; then
  if [[ -z "$email" || -z "$password" ]]; then
    echo "login-open-settings requires --email and --password." >&2
    exit 1
  fi
fi

adb_bin="$(find_adb)"
sdk_root="$(find_sdk_root)"
platform_dir="$(find_platform_dir)"
d8_bin="$(find_d8)"
junit_jar="$(find_junit_jar)"
android_jar="$platform_dir/android.jar"
uiautomator_jar="$platform_dir/uiautomator.jar"

if [[ -z "$device_id" ]]; then
  device_id="$(detect_device)"
fi

if [[ -z "$out_dir" ]]; then
  out_dir="${TMPDIR:-$repo_root/.tmp}/mobile-uiautomator-$action"
fi

build_root="${TMPDIR:-$repo_root/.tmp}/mobile-uiautomator-build"
jar_path="$(build_jar "$build_root" "$(escape_java_string "$email")" "$(escape_java_string "$password")")"

echo "[uiautomator] device: $device_id"
echo "[uiautomator] action: $action"

case "$action" in
  login-open-settings)
    "$adb_bin" -s "$device_id" shell am force-stop "$package_name"
    "$adb_bin" -s "$device_id" shell am start -n "$app_component" >/dev/null
    test_class="LoginOpenSettingsTest"
    ;;
  settings-logout)
    test_class="SettingsLogoutTest"
    ;;
esac

remote_jar="/data/local/tmp/mobile-uiautomator.jar"
"$adb_bin" -s "$device_id" push "$jar_path" "$remote_jar" >/dev/null
"$adb_bin" -s "$device_id" shell uiautomator runtest "$remote_jar" -c "$test_class"

echo "[uiautomator] captured artifacts:"
capture_state