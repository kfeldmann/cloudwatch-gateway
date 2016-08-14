cwg: Metrics -0-> CloudWatch
============================

## Install

- Install Python 2.7 (it might already be installed)
- Install [aws-cli](https://aws.amazon.com/cli/)
- [Download the latest cloudwatch-gateway release
  archive](https://github.com/kfeldmann/cloudwatch-gateway/releases)
- Spin up your instaces with an instance role that grants
  access to: `cloudwatch:PutMetricData`
- On your instances, run the following as root:
  - `tar xvzPf cloudwatch-gateway-*tgz`
  - ```/opt/bin/github.com/kfeldmann/cloudwatch-gateway/bin/setup.sh
       region appname environment tier```
  - Take a look at the monitors in
    `cloudwatch-gateway/monitors/<OS>/enabled`
  - To disable any monitors, jut move them outside
    of the `enabled` directory

## Send your own custom metrics

Once CloudWatch Gateway's daemon (`cwg`) is running, you can easily
send your own custom metrics to CloudWatch, either from your application
or from a script.

First take a look at
[the units that CloudWatch supports](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Unit)
and choose the appropriate one for your metric. All you have to
do is periodically write a three-word line to the named pipe,
`/var/opt/cloudwatch-gateway`.

The format is:
```
MetricName NumericValue Unit
```

Take a look at the included monitors for examples.
