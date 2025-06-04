self: super: {
  gpu-screen-recorder-ui = self.callPackage ./package.nix { };
  gpu-screen-recorder-notification = self.callPackage ./notification.nix { };
}