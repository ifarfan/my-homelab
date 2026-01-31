# Unbound

Set-up `Unbound` as a DoT (DNS over TLS) resolver

### Goals:
  - Setup self-sufficient DoT daemon (no docker) listening locally ONLY
  - Run on alternate port, since `AdGuard` will be the daemon answering to clients' request
  - AdGuard will then be the ONLY Unbound client
  - Install root.key file via `unbound-anchor` daemon and have a self-generating systemd timer that will take care of keeping it up-to-date
  - Install `dns-root-data` to find root DNS servers to communicate with
  - Harden and optimize config files, no remote access
  - Keep commented out copy of a `forwards` conf file, in case we ever want to forward DoT requests to `Cloudflare` or `Quad9` securely

### Post Installation
  - Check that config is valid:
    ```shell
    > unbound-checkconf
    unbound-checkconf: no errors in /etc/unbound/unbound.conf
    ```
  - Check that DNSSEC is actually working (from within unbound server):
    ```shell
    # Look for the "ad" (Authenticated Data) flag in the response:
    dig @127.0.0.1 -p <UNBOUND_PORT> example.com A

    # Test against know Good DNSSEC zone,
    #   - "ad" flag
    #   - "RRSIG" record on response
    dig @127.0.0.1 -p <UNBOUND_PORT> dnssec-tools.org A +dnssec

    # Test DNSSEC failure, check for "status: SERVFAI"
    dig @127.0.0.1 -p <UNBOUND_PORT> dnssec-failed.org A

    # Verbose test
    dig @127.0.0.1 -p <UNBOUND_PORT> example.com A +dnssec +multiline
    ```

### How-Tos:
  - [https://oneuptime.com/blog/post/2026-01-15-unbound-dnssec-validating-resolver/view](https://oneuptime.com/blog/post/2026-01-15-unbound-dnssec-validating-resolver/view)
  - [https://www.reddit.com/r/linuxadmin/comments/gf72e1/seeking_minimal_unbound_dns_config_examples_for/](https://www.reddit.com/r/linuxadmin/comments/gf72e1/seeking_minimal_unbound_dns_config_examples_for/)
  - [https://nlnetlabs.nl/documentation/unbound/howto-anchor/](https://nlnetlabs.nl/documentation/unbound/howto-anchor/)
  - [https://github.com/NLnetLabs/unbound/blob/master/doc/example.conf.in](https://github.com/NLnetLabs/unbound/blob/master/doc/example.conf.in)
  - [https://www.linuxbabe.com/ubuntu/set-up-unbound-dns-resolver-on-ubuntu-20-04-server](https://www.linuxbabe.com/ubuntu/set-up-unbound-dns-resolver-on-ubuntu-20-04-server)
