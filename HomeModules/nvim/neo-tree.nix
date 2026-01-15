{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      settings = {
        use_default_mappings = true;
      };
    };
  };
}
