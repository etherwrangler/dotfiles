{{- $root := .root -}}
{{- $group := .group -}}
{{- $linuxPackages := $root.packages.linux -}}
{{- $distroID := trimPrefix "linux-" $root.osid -}}
{{- $versionID := get $root.chezmoi.osRelease "versionID" | default "" -}}
{{- $majorVersion := first (splitList "." $versionID) | default "" -}}
{{- $distroPackages := get $linuxPackages $distroID | default (dict) -}}
{{- $packageManager := "" -}}
{{- $systemPackageGroups := dict -}}
{{- if hasKey $distroPackages "apt" -}}
{{-   $packageManager = "apt" -}}
{{-   $systemPackageGroups = get $distroPackages "apt" -}}
{{- else if hasKey $distroPackages "dnf" -}}
{{-   $packageManager = "dnf" -}}
{{-   $systemPackageGroups = get $distroPackages "dnf" -}}
{{- else if hasKey $distroPackages "pacman" -}}
{{-   $packageManager = "pacman" -}}
{{-   $systemPackageGroups = get $distroPackages "pacman" -}}
{{- end -}}
{{- $systemPackages := get $systemPackageGroups $group | default (list) -}}
{{- $versions := get $systemPackageGroups "versions" | default (dict) -}}
{{- $versionPackageGroups := dict -}}
{{- if and (ne $versionID "") (hasKey $versions $versionID) -}}
{{-   $versionPackageGroups = get $versions $versionID -}}
{{- else if and (ne $majorVersion "") (hasKey $versions $majorVersion) -}}
{{-   $versionPackageGroups = get $versions $majorVersion -}}
{{- end -}}
{{- if hasKey $versionPackageGroups $group -}}
{{-   $systemPackages = get $versionPackageGroups $group | default (list) -}}
{{- end -}}
{{- $pipxGroups := get $linuxPackages "pipx" | default (dict) -}}
{{- $pipxPackages := get $pipxGroups $group | default (list) -}}
{{- if and (hasPrefix "linux-" $root.osid) (not $root.nopackages) (ne $packageManager "") -}}
#!/bin/sh

set -eu

{{ if gt (len $systemPackages) 0 -}}
package_manager={{ $packageManager | quote }}

if [ "$(id -u)" -eq 0 ]; then
    sudo_cmd=""
elif command -v sudo >/dev/null 2>&1; then
    sudo_cmd="sudo"
else
    printf 'sudo is required to install %s packages as %s\n' "$package_manager" "$(id -un)" >&2
    exit 1
fi

run_as_root() {
    if [ -n "$sudo_cmd" ]; then
        "$sudo_cmd" "$@"
    else
        "$@"
    fi
}

install_system_packages() {
    missing_packages=""

    for package do
        case "$package_manager" in
            apt)
                if dpkg-query -W -f='${db:Status-Abbrev}' "$package" 2>/dev/null | grep -q '^ii '; then
                    printf 'apt: %s is already installed\n' "$package"
                    continue
                fi
                ;;
            dnf)
                if rpm --query "$package" >/dev/null 2>&1; then
                    printf 'dnf: %s is already installed\n' "$package"
                    continue
                fi
                ;;
            pacman)
                if pacman --query "$package" >/dev/null 2>&1; then
                    printf 'pacman: %s is already installed\n' "$package"
                    continue
                fi
                ;;
        esac

        missing_packages="${missing_packages}${missing_packages:+ }$package"
    done

    if [ -z "$missing_packages" ]; then
        return
    fi

    # Package names come from repository data and do not contain shell metacharacters.
    # shellcheck disable=SC2086
    case "$package_manager" in
        apt)
            printf 'apt: updating package index\n'
            run_as_root apt-get update
            run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends --no-upgrade $missing_packages
            ;;
        dnf)
            run_as_root dnf install --assumeyes $missing_packages
            ;;
        pacman)
            run_as_root pacman --sync --needed --noconfirm $missing_packages
            ;;
    esac
}

install_system_packages{{ range ($systemPackages | sortAlpha | uniq) }} {{ . | quote }}{{ end }}

{{ end -}}
{{ if gt (len $pipxPackages) 0 -}}
if ! command -v pipx >/dev/null 2>&1; then
    printf 'pipx is required to install the {{ $group }} Python applications\n' >&2
    exit 1
fi

{{ range $entry := $pipxPackages -}}
package={{ $entry.name | quote }}

printf 'pipx: checking %s\n' "$package"
if ! pipx list --short | awk '{ print $1 }' | grep -Fqx "$package"; then
    printf 'pipx: installing %s\n' "$package"
    pipx install --include-deps "$package"
else
    printf 'pipx: %s is already installed\n' "$package"
fi

{{ range (get $entry "inject" | default (list) | sortAlpha | uniq) -}}
dependency={{ . | quote }}

printf 'pipx: checking %s injection in %s\n' "$dependency" "$package"
if ! pipx runpip "$package" show "$dependency" >/dev/null 2>&1; then
    printf 'pipx: injecting %s into %s\n' "$dependency" "$package"
    pipx inject --include-deps "$package" "$dependency"
else
    printf 'pipx: %s is already available in %s\n' "$dependency" "$package"
fi
{{ end -}}
{{ end -}}

{{ end -}}
{{ if .setShell -}}
if command -v zsh >/dev/null 2>&1; then
    zsh_path="$(command -v zsh)"
    if [ "${SHELL:-}" != "$zsh_path" ]; then
        chsh -s "$zsh_path"
    fi
fi

{{ end -}}
{{ end -}}
