{
  den.aspects.desktop =
    { user, ... }:
    {
      hjem =
        { config, pkgs, ... }:
        let
          theme = config.local.theme.base16;
          hex = theme.helpers.hex;
          themeFile = ''
            # vim:ft=kitty
            ## name: ${theme.scheme}
            ## generated from modules/desktop/theme.nix

            foreground                      ${hex theme.base06}
            background                      ${hex theme.base00}
            selection_foreground            ${hex theme.base05}
            selection_background            ${hex theme.base04}

            cursor                          ${hex theme.base06}
            cursor_text_color               ${hex theme.base02}

            url_color                       ${hex theme.base0D}

            active_border_color             ${hex theme.base0B}
            inactive_border_color           ${hex theme.base03}
            bell_border_color               ${hex theme.base09}
            visual_bell_color               none

            wayland_titlebar_color          system
            macos_titlebar_color            system

            active_tab_background           ${hex theme.base00}
            active_tab_foreground           ${hex theme.base06}
            inactive_tab_background         ${hex theme.base03}
            inactive_tab_foreground         ${hex theme.base05}
            tab_bar_background              ${hex theme.base02}
            tab_bar_margin_color            none

            mark1_foreground                ${hex theme.base00}
            mark1_background                ${hex theme.base0D}
            mark2_foreground                ${hex theme.base00}
            mark2_background                ${hex theme.base06}
            mark3_foreground                ${hex theme.base00}
            mark3_background                ${hex theme.base0E}

            #: black
            color0                          ${hex theme.base02}
            color8                          ${hex theme.base04}

            #: red
            color1                          ${hex theme.base08}
            color9                          ${hex theme.base08}

            #: green
            color2                          ${hex theme.base0B}
            color10                         ${hex theme.base0B}

            #: yellow
            color3                          ${hex theme.base0A}
            color11                         ${hex theme.base0A}

            #: blue
            color4                          ${hex theme.base0D}
            color12                         ${hex theme.base0D}

            #: magenta
            color5                          ${hex theme.base0E}
            color13                         ${hex theme.base0E}

            #: cyan
            color6                          ${hex theme.base0C}
            color14                         ${hex theme.base0C}

            #: white
            color7                          ${hex theme.base04}
            color15                         ${hex theme.base05}
          '';
        in
        {
          packages = [
            pkgs.kitty
          ];
          xdg.config.files = {
            "kitty/dark-theme.auto.conf".text = themeFile;
            "kitty/no-preference-theme.auto.conf".text = themeFile;
            "kitty/kitty.conf".text = ''
              font_family      Lilex
              bold_font        auto
              italic_font      auto
              bold_italic_font auto
              font_size 16.0
              modify_font cell_height 110%

              cursor_shape block
              cursor_blink_interval -1
              cursor_stop_blinking_after 15.0

              # cursor_trail 10
              # cursor_trail_decay 0.1 0.4
              # cursor_trail_start_threshold 2

              scrollback_lines 10000

              mouse_hide_wait -3.0

              enabled_layouts *

              window_padding_width 8 8

              tab_bar_edge top

              background_opacity 1.0

              shell fish

              allow_remote_control yes
              listen_on unix:@mykitty

              shell_integration no-cursor

              notify_on_cmd_finish invisible

              kitty_mod ctrl+shift

              map ctrl+a>t launch --type=background kitten quick-access-terminal
              map ctrl+a>g launch --cwd=current --type=background kitten quick-access-terminal --instance-group lazygit fish -c 'lazygit'
            '';
          };
        };
    };
}
