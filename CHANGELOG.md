# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.7] - 2026-04-07
### :bug: Bug Fixes
- [`64d17fe`](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/commit/64d17fe96f3ebd1a48531bca8419d5c6e958f058) - private_dns_group_id of pe *(PR [#27](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/pull/27) by [@ashekhawat-cd](https://github.com/ashekhawat-cd))*


## [v1.0.6] - 2026-04-06
### :bug: Bug Fixes
- [`9df3e4b`](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/commit/9df3e4b84a993b9edd76e3442a68eeaeec6085e8) - consolidate versions.tf, remove provider_meta, upgrade to azurerm >= 4.0 *(commit by [@anmolnagpal](https://github.com/anmolnagpal))*
- [`12ffb89`](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/commit/12ffb898989ade9a1e5d4db1638c15faa32d49b0) - replace version placeholder in example versions.tf with >= 4.0 *(commit by [@anmolnagpal](https://github.com/anmolnagpal))*
- [`91fa5ea`](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/commit/91fa5ea3234a5ebbda3e11621e2f6e40b27d70e6) - updated workflows and added location variable in pe of server *(PR [#26](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/pull/26) by [@ashekhawat-cd](https://github.com/ashekhawat-cd))*

### :wrench: Chores
- [`ef68464`](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/commit/ef68464259440568742678b8b27e5b839c33cbee) - add provider_meta for API usage tracking *(PR [#24](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/pull/24) by [@clouddrove-ci](https://github.com/clouddrove-ci))*
- [`c1b225f`](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/commit/c1b225ff79fefaf215a3b215cc9b38fccb3ff885) - polish module with basic example, changelog, and version fixes *(PR [#25](https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/pull/25) by [@clouddrove-ci](https://github.com/clouddrove-ci))*


## [1.0.5] - 2026-03-20

### Changes
- Add provider_meta for API usage tracking
- Add terraform tests and pre-commit CI workflow
- Add SECURITY.md, CONTRIBUTING.md, .releaserc.json
- Standardize pre-commit to antonbabenko v1.105.0
- Set provider: none in tf-checks for validate-only CI
- Bump required_version to >= 1.10.0
[v1.0.6]: https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/compare/v1.0.5...v1.0.6
[v1.0.7]: https://github.com/terraform-az-modules/terraform-azurerm-flexible-postgresql/compare/v1.0.6...v1.0.7
