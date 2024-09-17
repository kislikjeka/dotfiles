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
}
