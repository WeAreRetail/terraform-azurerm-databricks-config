# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
