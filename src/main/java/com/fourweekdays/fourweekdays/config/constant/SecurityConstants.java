package com.fourweekdays.fourweekdays.config.constant;

public final class SecurityConstants {

    private SecurityConstants() {}

    public static final String LOGIN_URL = "/api/login";

    public static final String[] API_WHITE_LIST = {
            "/api/asn/**", "/api/vendor/asn/**", "/api/actuator/**", "/api/auth/reissue"
    };

    public static final String[] ADMIN_POST_LIST = {
            "/api/announcement", "/api/franchises", "/api/products",
            "/api/vendors", "/api/warehouses", "/api/category",
            "/api/member/signup", "/api/purchase-orders"
    };

    public static final String[] ADMIN_PATCH_LIST = {
            "/api/announcement/**", "/api/franchises/**", "/api/products/**",
            "/api/vendors/**", "/api/warehouses/**", "/api/member/**",
            "/api/inbounds/**", "/api/outbounds/**", "/api/purchase-orders/**"
    };

    public static final String[] ADMIN_DELETE_LIST = {
            "/api/announcement/**", "/api/franchises/**", "/api/products/**",
            "/api/vendors/**", "/api/warehouses/**", "/api/inbounds/**",
            "/api/purchase-orders/**"
    };

    public static final String[] ADMIN_ONLY_LIST = { "/api/admin/**" };

    public static final String[] WORKER_LIST = { "/api/tasks/**", "/api/inbound-tasks/**" };

    public static final String[] MANAGER_GET_LIST = {
            "/api/announcement/**", "/api/franchises/**", "/api/products/**",
            "/api/vendors/**", "/api/warehouses/**", "/api/category/**",
            "/api/member/**", "/api/purchase-orders/**", "/api/inbounds/**",
            "/api/outbounds/**", "/api/inventories/**", "/api/locations/**"
    };

    public static final String[] EXTERNAL_API_LIST = {
            "/api/vendor/asn/**", "/api/franchise/order/**"
    };
}