{lib, ...}:
with lib; {
  options.wKeyList = mkOption {type = types.listOf types.attrs;};
  options.nvix = {
    mkKey = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
