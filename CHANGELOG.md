# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [5.3.0] - 2026-10-28

### Changed

- `enableNotebookTableClipboard` workspace configuration (copy of notebook table results to the clipboard) now follows `user_and_jobs_are_unrestricted`: enabled on restricted workspaces (`false`, the default), disabled on unrestricted ones (`true`). It was always disabled before

## [5.2.0] - 2026-10-27

### Changed

- `enableResultsDownloading` workspace configuration (the Download button on notebook cell results) now follows `user_and_jobs_are_unrestricted`: enabled on restricted workspaces (`false`, the default), disabled on unrestricted ones (`true`). It was always disabled before

## [5.1.0] - 2026-10-21

### Changed

- `dbus_per_hour` limit of the restricted job and notebook policies (runtimes 15, 17 and 18, applied when `user_and_jobs_are_unrestricted` is `false`) raised from 10 to 20 DBU per hour, allowing larger clusters

## [5.0.0] - 2026-10-12

### Changed

- **Breaking**: new DCS image naming convention `<acr_url>/databricks-<access mode>-<contract>:<tag>`. The access mode (`dedicated` or `standard`) and the contract are in the repository name, the tag only carries the release: the build version (pushed by the CI) or the environment (`dev`, `int`, `prd`...) the build is released on. The `-current` suffix is dropped
  - the contract is the DBR major in dedicated mode, and the [serverless environment version](https://docs.databricks.com/aws/en/release-notes/serverless/environment-version/) in standard mode (Python and Databricks Connect version), so the same runtime can one day have both a dedicated and a standard image side by side
  - runtime 15: `databricks15:<env>-current` → `databricks-dedicated-15:<env>`
  - runtime 17: `databricks17:<env>-current` → `databricks-dedicated-17:<env>`
  - runtime 18: `databricks:<env>-v5-standard-current` → `databricks-standard-v5:<env>` (environment version 5, Databricks Connect 18)
- Migration: build, push and release the images under the new repository names and tags before applying this version, the policies and the pools reference them

## [4.2.0] - 2026-10-05

### Added

- `spark_env_vars.APPLICATIONINSIGHTS_CONTROLPLANE_DISABLED = "true"` fixed in every job and notebook policy (runtimes 15, 17 and 18). It turns off the OneSettings control plane of the Python Azure Monitor exporter (`azure-monitor-opentelemetry-exporter`, pulled in by `azure-monitor-opentelemetry`). That control plane periodically calls `https://settings.sdk.monitor.azure.com` to fetch the SDK's remote feature settings (SDK stats, live metrics, local storage); the call is blocked by the corporate firewall and crashed the applications. With the variable set the exporter uses its built-in defaults instead. Telemetry is unchanged: it still goes to the `IngestionEndpoint` and `LiveEndpoint` of the Application Insights connection string

## [4.1.1] - 2026-10-01

### Fixed

- `current_policy_spark_version` and `current_policy_docker_image_url` no longer depend on `additional_allowed_instance_pool_ids`: instance pools built from these outputs can now be given back as allowed pools (pool mode of the job policy) without a dependency cycle

## [4.1.0] - 2026-10-01

### Added

- `current_policy_spark_version` and `current_policy_docker_image_url` outputs exposing the runtime and docker image shared by the current job and notebook policies, for dependent modules (e.g. instance pools)

### Changed

- Renamed outputs `job_policy_id` to `current_job_policy_id` and `notebook_policy_id` to `current_notebook_policy_id`

## [4.0.0] - 2026-09-29

### Added

New module organisation to follow databricks standard

## [3.0.0] - 2024-05-10

### Added

Add a metadata store to hold the project trigram and the runtime environment.

### How to migrate

Add the `environment` and `trigram` variables containing the environment and the project trigram to the module.


## [2.2.0] - 2024-03-04

### Fixed

- Databricks policies now allow all values and are not restricted to only spot azure


## [2.1.0] - 2024-19-03

### Added

- Databricks 14 inside policies


## [2.0.1] - 2024-01-22

### Fixed

- readme display is fixed

## [2.0.0] - 2024-01-18

### Added

- You can now specify whether or not you wish to use PAT tokens for configuration, by using the `allow_pat_config` variable

### Changed

- WebTerminal is now disabled, was not specified previously
- FileStore Endpoint is now disabled, was not specified previously

## [1.0.0] - 2024-01-08

### Added

- Initial Release to open source
