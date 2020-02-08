import ./make-test.nix ({ pkgs, lib, ...} : {
  name = "initrd-network";

  meta.maintainers = [ pkgs.stdenv.lib.maintainers.eelco ];

  machine = { ... }: {
    imports = [ ../modules/profiles/minimal.nix ];
    boot.initrd.network.enable = true;
    boot.initrd.network.postCommands =
      ''
        ip addr show
        ip route show
        ip addr | grep 10.0.2.15 || exit 1
        ping -c1 10.0.2.2 || exit 1
      '';
    # Check if cleanup was done correctly
    boot.initrd.postMountCommands = lib.mkAfter
      ''
        ip addr show
        ip route show
        ip addr | grep 10.0.2.15 && exit 1
        ping -c1 10.0.2.2 && exit 1
      '';
  };

  testScript =
    ''
      startAll;
      $machine->waitForUnit("multi-user.target");
      $machine->succeed("ip addr show >&2");
      $machine->succeed("ip route show >&2");
    '';
})
