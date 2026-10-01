# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
