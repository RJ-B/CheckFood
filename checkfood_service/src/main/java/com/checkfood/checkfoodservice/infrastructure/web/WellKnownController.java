package com.checkfood.checkfoodservice.infrastructure.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Serves `.well-known` files required for platform integrations.
 *
 * <p>Currently provides only {@code /.well-known/assetlinks.json}, which
 * Android uses to verify that the CheckFood mobile app is allowed to handle
 * HTTPS deep links to {@code checkfood.cz}. Without this file the
 * {@code android:autoVerify="true"} intent-filter on
 * {@code MainActivity} would leave App Links unverified, and any other app
 * declaring the same URL pattern could hijack post-verify redirects.</p>
 *
 * <p>The SHA-256 certificate fingerprints MUST match the signing keys used
 * to produce the Play Store release APK (and any debug/internal variants
 * that need to handle deep links). They are supplied through
 * {@code app.android.signing-sha256} in {@code application-*.properties}
 * (comma-separated).</p>
 *
 * @author CheckFood team, Apr 2026
 */
@RestController
@RequestMapping("/.well-known")
public class WellKnownController {

    private static final String PACKAGE_NAME = "com.checkfood.checkfood_client";

    @Value("${app.android.signing-sha256:}")
    private String signingFingerprintsCsv;

    /**
     * Returns the Android Digital Asset Links JSON used by the Play Store
     * verifier when installing the APK. Format documented at
     * https://developers.google.com/digital-asset-links/v1/getting-started.
     *
     * <p>If no fingerprints are configured (e.g. local dev), the endpoint
     * still returns a valid JSON array with an empty sha256_cert_fingerprints
     * list so that a `404` isn't reported during autoVerify — Android will
     * then simply fail the verification, which is the correct failure mode
     * for an un-provisioned environment.</p>
     */
    @GetMapping(value = "/assetlinks.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<AssetLinkStatement>> assetlinks() {
        List<String> fingerprints = signingFingerprintsCsv.isBlank()
                ? List.of()
                : List.of(signingFingerprintsCsv.split("\\s*,\\s*"));

        AssetLinkStatement statement = new AssetLinkStatement(
                List.of("delegate_permission/common.handle_all_urls"),
                new AssetLinkTarget("android_app", PACKAGE_NAME, fingerprints)
        );

        return ResponseEntity.ok(List.of(statement));
    }

    /** Top-level assetlinks JSON record. */
    public record AssetLinkStatement(List<String> relation, AssetLinkTarget target) {}

    /** Android-app target descriptor. */
    public record AssetLinkTarget(
            String namespace,
            String package_name,
            List<String> sha256_cert_fingerprints
    ) {}
}
