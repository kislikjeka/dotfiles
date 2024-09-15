{ pkgs, ... }:
{
  enable = true;
  settings = {
    k9s = {
      logger = {
        buffer = 5000;
        textWrap = true;
        tail = 1000;
      };
    };
  };
  aliases = {
    alias = {
      pp = "v1/pods";
      dep = "apps/v1/deployments";
    };
  };
  plugin = {
    # Defines a plugin to provide a `ctrl-l` shortcut to
    # tail the logs while in pod view.
    fred = {
      shortCut = "Ctrl-L";
      description = "Pod logs";
      scopes = [ "po" ];
      command = "kubectl";
      background = false;
      args = [
        "logs"
        "-f"
        "$NAME"
        "-n"
        "$NAMESPACE"
        "--context"
        "$CLUSTER"
      ];
    };
  };
}
