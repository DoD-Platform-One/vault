# Vault

## Overview

This package contains an extensible and configurable installation of Hashicorp Vault based on the upstream chart provided by hashicorp.

## Vault

[HashiCorp Vault](https://www.hashicorp.com/en/products/vault) is an identity-based secrets and encryption management system that helps organizations reduce the risk of breaches and data exposure with identity-based security automation and encryption-as-a-service.

## Production/Operational Configuration
Please see the BigBang recommended [production configuration](./production.md) for high availability and auto-unseal.

## How Vault works

A secret within Vault is anything that you want to tightly control access to, such as API encryption keys, passwords, or certificates. Vault provides encryption services that are gated by authentication and authorization methods. Using Vault’s UI, CLI, or HTTP API, access to secrets and other sensitive data can be securely stored and managed, tightly controlled (restricted), and auditable. This is accomplished using Secrets engines, which are Vault components that store, generate or encrypt secrets. Some secrets engines like key/value secrets engine simply store and read data. Other secrets engines connect to other services and generate dynamic credentials on demand. Other secrets engines provide encryption as a service. Secrets written to Vault are encrypted and then written to backend storage. Therefore, the backend storage mechanism never sees the unencrypted value and doesn't have the means necessary to decrypt it without Vault.
