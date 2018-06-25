## ACS Helm Chart versioning guide

Based on [Semantic Versioning](https://semver.org)

As an addition to Semantic Versioning the following list describes ACS specific extensions:
* Once a chart has been released, the contents of that version MUST NOT be modified. Any modifications MUST be released as a new version. Stable chart version starts with 1.0.0
* The major version of a chart is defined by major ACS release version. For instance: chart 1.0.0 (ACS 6.0.0), chart 2.0.0 (ACS 6.1.0), chart 3.0.0 (ACS 6.2.0), chart 4.0.0 (ACS 7.0), chart 5.0.0 (ACS 7.1).
* The minor version must be incremented if ACS version is incremented within a Service Pack. For instance: chart 1.0.0 (ACS 6.0.0), chart 1.1.0 (ACS 6.0.1), chart 2.0.0 (ACS 6.1.0), chart 2.1.0 (ACS 6.1.1)
* The patch version of the chart must be incremented if ACS version is incremented within a HotFix or the chart was modified. For instance: chart 1.0.0 (ACS 6.0.0), chart 1.0.1 (ACS 6.0.0, chart modifications), chart 1.0.2 (ACS 6.0.0.1), chart 1.0.3 (ACS 6.0.0.2 and chart modifications), chart 1.0.4 (ACS 6.0.0.2, chart modifications).
* The "appVersion" label must always specify the exact ACS release version, like 6.0.0, 6.1.0, 6.1.1.1, 6.1.1.2. If the "appVersion" was incremented between charts, downgrading to a previous chart is not possible.
