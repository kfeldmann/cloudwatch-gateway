cwg: The CloudWatch gateway for custom metrics
============================

## Install on your instances

- Spin up instaces with an instance role that grants
  access to: `cloudwatch:PutMetricData`
- Install Python 2.7 (it might already be installed)
- Install [aws-cli](https://aws.amazon.com/cli/)
- [Download the latest cloudwatch-gateway release
  archive](https://github.com/kfeldmann/cloudwatch-gateway/releases)
- As root:
  - `tar xvzPf cloudwatch-gateway-*tgz`
  - ```/opt/bin/github.com/kfeldmann/cloudwatch-gateway/bin/setup.sh
       <region> <appname> <environment> <tier>``` (substitute your
    particulars for the four arguments)
- Take a look at the monitors in
  `cloudwatch-gateway/monitors/<OS>/enabled`
- To disable any monitors, jut move them outside
  of the `enabled` directory

## Reap the benefits

- The metrics will be written to CloudWatch under the
  namespace `<appname>-<environment>-<tier>`
- The metrics will aslo be written to syslog with tag `cwg`,
  and priority `local1.info`

## Publish your own custom metrics

Once CloudWatch Gateway's daemon (`cwg`) is running, you can easily
send your own custom metrics to CloudWatch, either directly
from your application or from a script or helper app.

First take a look at
[the units that CloudWatch supports](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Unit)
and choose the appropriate one for your metric. All you have to
do is periodically write a three-word line to the named pipe,
`/var/opt/cloudwatch-gateway`.

The format is:
```
<MetricName> <NumericValue> <Unit>
```

Example:
```
#!/bin/sh
A=$(/bin/grep MemAvailable /proc/meminfo | /bin/awk '{print $2}')
T=$(/bin/grep MemTotal /proc/meminfo | /bin/awk '{print $2}')
AP=$(/bin/echo "scale=1; 100-(${A}*100)/${T}" | /usr/bin/bc)
/bin/echo "MemUsagePct ${AP} Percent"
```

Take a look at the included monitors for more examples.
