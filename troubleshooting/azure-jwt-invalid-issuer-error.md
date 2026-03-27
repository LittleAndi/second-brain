---
title: Azure JWT invalid issuer error
type: troubleshooting
tags: [azure, authentication, jwt]
summary: JWT token validation fails due to mismatched issuer URL in Azure-protected APIs.
status: stable
last_updated: 2026-03-28
category: azure
complexity: low
related: [azure-app-registrations]
---

## Problem

`Bearer error="invalid_token", error_description="The issuer is invalid"`

## Context

Occurs when validating JWT tokens in Azure-protected APIs. Typically encountered after changing tenant configuration, deploying to a new environment, or switching between Azure AD v1.0 and v2.0 endpoints. The API's authentication middleware rejects the token before the request reaches application code, returning a 401 Unauthorized response.

## Cause

The `iss` (issuer) claim in the JWT does not match the expected issuer configured in the API's authentication middleware. Azure AD v1.0 tokens carry an issuer in the form `https://sts.windows.net/{tenant-id}/`, while v2.0 tokens use `https://login.microsoftonline.com/{tenant-id}/v2.0`. If the authority URL in the application is configured for one version but the token is issued by the other, validation fails. A mismatched or incorrect tenant ID in either the token or the application config produces the same error.

## Solution

1. Decode the JWT at [jwt.ms](https://jwt.ms) and inspect the `iss` claim value.
2. Compare the `iss` value against the authority URL configured in the application's authentication middleware.
3. Verify the tenant ID is identical in both the token issuer and the configured authority.
4. Check the token version: if `iss` ends in `/v2.0`, the authority URL must also include `/v2.0`; if it ends in `/{tenant-id}/`, use the v1.0 authority format.
5. Update the authority URL in application settings to match the token's issuer format.
6. Redeploy the application and retest with a freshly acquired token.

## Prevention

Use consistent tenant configuration across all environments by storing the tenant ID and authority URL in shared configuration or a key vault reference. Validate authority URLs as part of the deployment pipeline by comparing the configured issuer against the identity provider's OpenID Connect discovery document. When upgrading authentication libraries or moving to MSAL, explicitly verify whether v2.0 endpoints are required and update authority URLs accordingly.

## Related

- azure-app-registrations
