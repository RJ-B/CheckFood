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

    /**
     * Apple Universal Links appID = "<TEAM_ID>.<BUNDLE_ID>".
     *
     * <p>Team R7SG76KN9Y is the CheckFood Apple Developer team; bundle
     * com.checkfood.checkfoodClient matches PRODUCT_BUNDLE_IDENTIFIER in
     * checkfood_client/ios/Runner.xcodeproj/project.pbxproj. If either
     * changes (e.g. App Store transfer or rebrand), the AASA file
     * served below will silently stop working — iOS caches the file
     * aggressively per install, so the symptom is "verification email
     * link opens Safari instead of the app" which is exactly Bug #2
     * from the Apr 2026 iPhone test session.</p>
     */
    private static final String IOS_APP_ID = "R7SG76KN9Y.com.checkfood.checkfoodClient";

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

    // =========================================================================
    // iOS Universal Links — apple-app-site-association
    // =========================================================================

    /**
     * Returns the Apple App Site Association (AASA) JSON used by iOS
     * to decide whether a tapped HTTPS link should open the CheckFood
     * app instead of Safari. Format documented at
     * https://developer.apple.com/documentation/xcode/supporting-associated-domains
     *
     * <p>Note: the path is intentionally <em>without</em> the {@code .json}
     * extension — Apple's CDN strips it and the {@code on-demand-install-web}
     * verifier checks an exact filename. Spring routes both
     * {@code /.well-known/apple-app-site-association} and
     * {@code /.well-known/apple-app-site-association.json} so that
     * curl-based debugging from a desktop also works.</p>
     *
     * <p>The {@code paths} list is constrained to the verification deep
     * link only — we deliberately do <em>not</em> claim {@code /} or
     * {@code /api/*}, otherwise iOS would intercept every backend HTTPS
     * request the user makes from Safari (e.g. signed-image URLs in the
     * private bucket) and try to open the app, which is both confusing
     * and a soft DoS for the browser.</p>
     */
    @GetMapping(
            value = {"/apple-app-site-association", "/apple-app-site-association.json"},
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    public ResponseEntity<AppleAppSiteAssociation> appleAppSiteAssociation() {
        AppleAppLinkDetail detail = new AppleAppLinkDetail(
                List.of(IOS_APP_ID),
                List.of("/api/auth/verify", "/api/auth/verify*", "/api/auth/reset-password", "/api/auth/reset-password*")
        );
        AppleAppLinks applinks = new AppleAppLinks(List.of(), List.of(detail));
        return ResponseEntity.ok(new AppleAppSiteAssociation(applinks));
    }

    /** Top-level AASA record. */
    public record AppleAppSiteAssociation(AppleAppLinks applinks) {}

    /** AASA "applinks" payload. */
    public record AppleAppLinks(List<String> apps, List<AppleAppLinkDetail> details) {}

    /** Per-app AASA details entry — modern (iOS 13+) "appIDs" form. */
    public record AppleAppLinkDetail(List<String> appIDs, List<String> paths) {}
}
