cwg: CloudWatch Gateway
=======================

## Install

- Install Python 2.7 (it might already be installed)
- Install [aws-cli](https://aws.amazon.com/cli/)
- [Download the latest cloudwatch-gateway release
  archive](https://github.com/kfeldmann/cloudwatch-gateway/releases)
- Spin up your instaces with an instance role that grants
  access to: `cloudwatch:PutMetricData`
- On your instance, run the following as root:
  - `tar xvzPf cloudwatch-gateway-*tgz`
  - ```/opt/bin/github.com/kfeldmann/cloudwatch-gateway/bin/setup.sh \
       region appname environment tier```
  - Take a look at the monitors in
    `cloudwatch-gateway/monitors/<OS>/enabled`
  - To disable any monitors, jut move them outside
    of the `enabled` directory
