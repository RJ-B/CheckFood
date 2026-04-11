package com.checkfood.checkfoodservice.testsupport;

import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.repository.DeviceRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;

import static org.mockito.Mockito.mock;

/**
 * Shared {@link TestConfiguration} that supplies stub beans for the
 * security + exception-handler infrastructure that {@code @WebMvcTest}
 * slice tests would otherwise be missing.
 *
 * <p>Spring's {@code @WebMvcTest} slice scans the application package for
 * {@code Filter}, {@code @ControllerAdvice}, {@code @RestControllerAdvice}
 * and similar web-tier beans, but does NOT pull in their non-web
 * dependencies (services, repositories, loggers). The CheckFood
 * application has both:
 *
 * <ul>
 *   <li>{@code JwtAuthenticationFilter} (a Filter) which depends on
 *       {@code JwtService}, {@code UserService}, {@code JwtLogger},
 *       and {@code DeviceRepository}.</li>
 *   <li>{@code DiningContextExceptionHandler} (a {@code @RestControllerAdvice})
 *       which depends on {@code ErrorResponseBuilder}.</li>
 * </ul>
 *
 * <p>Without this config, every WebMvcTest in the project blows up at
 * application-context refresh with {@code NoSuchBeanDefinitionException},
 * which masks the actual test assertions and turns the slice into a
 * full {@code @SpringBootTest}.
 *
 * <p>Each individual test still mocks the controller's own service
 * dependencies via {@code @MockitoBean} as usual; this config is
 * purely the slice-wide infrastructure scaffold.
 *
 * <p>Usage: add {@code @Import(WebMvcSliceTestConfig.class)} to your
 * {@code @WebMvcTest} class.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@TestConfiguration
public class WebMvcSliceTestConfig {

    @Bean
    public JwtService jwtService() {
        return mock(JwtService.class);
    }

    @Bean
    public JwtLogger jwtLogger() {
        return mock(JwtLogger.class);
    }

    @Bean
    public DeviceRepository deviceRepository() {
        return mock(DeviceRepository.class);
    }

    @Bean
    public ErrorResponseBuilder errorResponseBuilder() {
        return mock(ErrorResponseBuilder.class);
    }

    /**
     * UserService mock — required by JwtAuthenticationFilter (and many slice
     * tests that resolve the authenticated principal). Marked {@code @Primary}
     * so individual tests can still override it with their own
     * {@code @MockitoBean private UserService userService;} declaration when
     * they need to stub specific behaviour. The default no-stub mock from
     * this config is fine for tests that just need the bean to exist.
     */
    @Bean
    @Primary
    public UserService userService() {
        return mock(UserService.class);
    }
}
