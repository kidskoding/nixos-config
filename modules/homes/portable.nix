# apply with `home-manager switch --impure --flake ~/home-manager#portable`
{self, ...}: {
  flake.homeConfigurations.portable = self.lib.mkHome {
    modules = [
      self.homeModules.dev
      self.homeModules.agents
    ];
  };
}
