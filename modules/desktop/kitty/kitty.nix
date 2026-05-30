{
  den.aspects.desktop =
    { user, ... }:
    {
      hjem =
        { pkgs, ... }:
        {
          packages = [
            pkgs.kitty
          ];
          xdg.config.files = {
            "kitty/dark-theme.auto.conf".source = ./dark-theme.conf;
            "kitty/no-preference-theme.auto.conf".source = ./light-theme.conf;
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
