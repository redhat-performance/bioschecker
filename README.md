# bioschecker

In Network Function Virtualization (NFV) environments, to achieve zero packet loss and network performance determinism a very specific setup should be done in the hardware BIOS/UEFI.
This setup includes enabling NUMA optimizations, disabling C power states, disabling turbo boost, setting a specific CPU power and performance profile, etc.
A complete list of recomendations can be found [here](https://www.redhat.com/en/blog/tuning-zero-packet-loss-red-hat-openstack-platform-part-1) and [here](https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/17.1-beta/html-single/configuring_network_functions_virtualization/index#ref_nfv-bios-settings_nfv).

This script receives a specific BIOS configuration (i.e.: gathered via the Redfish protocol) and analyzes it against a set of well known telco profiles recommendations. To gather the BIOS configuration in JSON format through Redfish:
```
$ curl -k -u user:pwd -X GET https://mgmt-server.com/redfish/v1/Systems/System.Embedded.1/Bios
```

## Usage

1. Option 1:

    Pass the JSON BIOS config directly to `bioschecker`, i.e.:
    ```
    $ curl -k -u user:pwd -X GET https://mgmt-server.com/redfish/v1/Systems/System.Embedded.1/Bios | bioschecker
    DynamicCoreAllocation Disabled
    SriovGlobalEnable Disabled
    ProcTurboMode Enabled
    ```

2. Option 2:
    
    Save the JSON BIOS config first and then pass it as a parameter to `bioschecker`, i.e.:
    ```
    $ curl -k -u user:pwd -X GET https://mgmt-server.com/redfish/v1/Systems/System.Embedded.1/Bios > biosconfig.json

    $ bioschecker biosconfig.json
    DynamicCoreAllocation Disabled
    SriovGlobalEnable Disabled
    ProcTurboMode Enabled
    ```

## Build and run instructions

Build the program:
```
$ dune build
```

Run the program:
```
$ dune exec bioschecker
```

Or, alternatively:
```
$ dune exec ./bin/main.exe
```

