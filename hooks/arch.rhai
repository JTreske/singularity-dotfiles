let kl = "";

fn pre_backup() {
  if !info.update {
    kl = api::utility::select("Choose your keyboard layout", "de", [["us", "us", ""], ["de", "de", ""]]);
    api::log::step(`Setting X11 keymap to ``${kl}``...`);
    api::runner::run_command(runner, "localectl", ["set-x11-keymap", kl], false, false, #{});
    api::log::success("X11 keymap set!");
  }
}

// fn post_backup_pre_deps() {}

// fn post_deps_pre_install() {}

fn fix_qt_settings(info, name) {
  api::log::step(`Fixing ``${name}.conf``...`);
  let qt_config = `${info.dotfiles_dir}/.config/${name}/${name}.conf`;
  let qt_content = api::utility::read_file(qt_config);
  let absolute_home = api::utility::resolve_home("~");

  let pattern = #"(color_scheme_path=)~/(.*)"#;

  let replace = "${1}" + absolute_home + "${2}";
  qt_content = api::utility::regex_replace(qt_content, pattern, replace);

  api::utility::write_file(qt_config, qt_content, false);
  api::log::success(```${name}.conf``fixed!`);
}

fn post_install_pre_restore() {
  // resolve home in qt5ct.conf and qt6ct.conf
  fix_qt_settings(info, "qt5ct");
  fix_qt_settings(info, "qt6ct");
}

fn post_restore_pre_link() {
  if !info.update {
    api::log::step("Setting Hyprland keyboard layout...");
    let kl_config = `${info.dotfiles_dir}/.config/hypr/conf/keyboard-layout.conf`;
    let kl_content = api::utility::read_file(kl_config);

    let pattern = #"(# variant #\s+source = ~/.config/hypr/conf/keyboard-layout/).*"#;
    let replace = "${1}" + `${kl}.conf`;
    kl_content = api::utility::regex_replace(kl_content, pattern, replace);

    api::utility::write_file(kl_config, kl_content, false);
    api::log::success("Hyprland keyboard layout set!");
  }

  api::log::step("Setting up fontconfig cache...");
  api::runner::run_command(runner, "fc-cache", ["-f"], false, false, #{});
  api::log::success("Fontconfig cache set up!");

  api::log::step("Installing ml4w-dotfiles-settings app...");
  api::runner::run_command(runner, "bash", ["-c", "bash <(curl -s https://raw.githubusercontent.com/mylinuxforwork/ml4w-dotfiles-settings/main/setup.sh)"], false, true, #{});
  api::log::success("ML4W settings installed!");

  api::log::step("Setting up user default folders");
  api::runner::run_command(runner, "xdg-user-dirs-update", [], false, false, #{});
  api::log::success("User folders created!");

  api::log::step("Installing singularity default wallpaper to expected location...");

  let wp = `${info.dotfiles_dir}/.config/singularity/singularity.jpg`;
  let wp_target = "/etc/xdg/quickshell/noctalia-shell/Assets/Wallpaper/singularity.jpg";
  api::runner::run_command(runner, "sudo", ["cp", wp, wp_target], false, true, #{});

  api::log::success("Singularity wallpaper installed!");
}

fn finalize() {
  api::log::step("Applying GTK settings from '~/.local/share/nwg-look/gsettings'...");
  api::runner::run_command(runner, "nwg-look", ["-a"], false, false, #{});
  api::log::success("GTK settings applied!");

  api::log::step("Setting up Noctalia Shell...");

  let nr = api::utility::resolve_home("~/.config/noctalia");
  let pr = `${nr}/plugins`;
  let pfp = `${nr}/plugins.json`;

  let pfp_content = api::utility::read_file(pfp);
  let plugins_json = api::utility::parse_json(pfp_content);

  let states = plugins_json.states;
  for plugin_id in states.keys() {
    let repo_url = states[plugin_id].sourceUrl;

    let plugin_dir = `${pr}/${plugin_id}`;
    let manifest = `${plugin_dir}/manifest.json`;

    if api::utility::path_exists(manifest) {
      continue;
    }

    api::log::step(`Installing plugin ``${plugin_id}``...`);

    let tmp_dir = api::utility::create_tmp_dir();
    let tmp_dir_path = api::utility::get_tmp_path(tmp_dir);

    api::runner::run_command(runner, "git", ["clone", "--filter=blob:none", "--sparse", "--depth=1", "--quiet", repo_url, tmp_dir_path], false, false, #{"GIT_TERMINAL_PROMPT": "0"});
    api::runner::run_command(runner, "git", ["sparse-checkout", "set", plugin_id], false, false, #{}, tmp_dir_path);

    api::utility::ensure_dir(plugin_dir);

    let sf = `${tmp_dir_path}/${plugin_id}/settings.json`;
    if api::utility::path_exists(sf) {
      api::utility::remove_file(sf);
    }

    api::utility::copy_recursive(`${tmp_dir_path}/${plugin_id}`, plugin_dir);
  }

  api::log::success("Noctalia Shell set up!");

  api::log::step("Applying Starship theme...");

  // This is needed because on update the starship.toml with the palette applied will be overwritten
  // but noctalia still thinks the template is applied
  let sp = api::utility::resolve_home("~/.cache/noctalia/starship-palette.toml");
  if api::utility::path_exists(sp) {
    api::runner::run_command(runner, "/etc/xdg/quickshell/noctalia-shell/Scripts/bash/template-apply.sh", ["starship"], false, false, #{"PALETTE_FILE": `${sp}`});
    api::log::success("Starship theme applied!");
  } else {
    api::log::info("Applying theme skipped!");
  }

  api::log::step("Installing `sigularity` scripts...");

  let sp = `${info.profile_dir}/install.sh`;
  let st_parent = api::utility::resolve_home("~/.local/bin");
  let st = `${st_parent}/singularity`;
  api::utility::ensure_dir(st_parent);
  api::runner::run_command(runner, "install", ["-m", "755", sp, st], false, false, #{});
  sp = `${info.profile_dir}/system-upgrade.sh`;
  st = `${st_parent}/singularity-system-upgrade`;
  api::runner::run_command(runner, "install", ["-m", "755", sp, st], false, false, #{});
  sp = `${info.profile_dir}/update-count.sh`;
  st = `${st_parent}/singularity-update-count`;
  api::runner::run_command(runner, "install", ["-m", "755", sp, st], false, false, #{});

  api::log::success("Scripts installed!");

  api::utility::note("Next Steps", "\
    ## Setup\n\
    - After successful installation reboot your system, also reboot after installing applications from the currated app list\n\
    - You may need to enable SDDM and bluetooth services by running: `sudo systemctl enable --now sddm` and `sudo systemctl enable --now bluetooth`\n\
    - Run `singularity --shell` to setup your default shell (zsh recommended)\n\
    - Run `singularity --theme` to setup the singularity SDDM (login) theme\n\
    \n\
    ## Customization\n\
    - Set your preferred wallpaper in Noctalia settings and run `singularity --wallpaper` to select a wallpaper for SDDM\n\
    - You may want to make changes to the SDDM theme here `/usr/share/sddm/themes/silent/configs/singularity.conf`\n\
    - Run `singularity --avatar` to set your profile picture\n\
    - Create Hyprland configuration files in the subdirectories of `~/.config/hypr/conf`\n\
    - Run `settings` or `settings-gui` to enable your Hyprland settings and set your default apps\n\
    \n\
    ## Apps\n\
    - Run `singularity --multilib` to install 32 bit applications like Steam\n\
    - Make sure all drivers are installed, e.g., Nvidia GPU drivers\n\
    - Run `singularity --apps` to install apps from the currated app list\
  ");
}
