---
title: Azure JWT Invalid Issuer Error
type: troubleshooting
tags: [azure, authentication, jwt]
summary: JWT token validation fails due to mismatched issuer URL in Azure-protected APIs.
status: stable
last_updated: 2026-03-27
domain: azure
complexity: low
---

## Problem
Bearer error="invalid_token", error_description="The issuer is invalid"

## Context
Occurs when validating JWT tokens in Azure-protected APIs. Typically encountered after changing tenant configuration or deploying to a new environment.

## Cause
The token issuer claim (iss) in the JWT does not match the expected issuer in the API's authentication middleware.

## Solution
1. Decode the JWT at jwt.ms and inspect the iss claim
2. Compare iss against the configured authority URL
3. Verify the tenant ID matches in both
4. Ensure correct metadata endpoint (v2.0 tokens require v2.0 authority)
5. Update authority URL in application settings
6. Redeploy and retest

## Prevention
Use consistent tenant configuration across all environments. Store tenant ID in shared config. Validate authority URLs during deployment.

## Related
- azure-app-registrations