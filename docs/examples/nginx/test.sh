#!/bin/sh
set -eu

cd "$(dirname "$0")"

compose() {
    docker compose -f compose.yaml "$@"
}

cleanup() {
    compose down --volumes --remove-orphans >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

compose config --quiet
compose up --detach --wait alfresco share
compose run --rm proxy nginx -t
compose up --detach --wait proxy

assert_response() {
    expected_status="$1"
    expected_body="$2"
    path="$3"
    response_file="$(mktemp)"
    status="$(curl --path-as-is --silent --show-error --output "$response_file" --write-out '%{http_code}' "http://127.0.0.1:18080${path}")"

    if [ "$status" != "$expected_status" ]; then
        printf 'Expected %s for %s, got %s\n' "$expected_status" "$path" "$status" >&2
        cat "$response_file" >&2
        rm -f "$response_file"
        exit 1
    fi

    if ! grep -Fq "$expected_body" "$response_file"; then
        printf 'Expected body containing %s for %s\n' "$expected_body" "$path" >&2
        cat "$response_file" >&2
        rm -f "$response_file"
        exit 1
    fi

    if [ "$expected_status" = "403" ] && grep -Fq 'alice' "$response_file"; then
        printf 'Blocked response disclosed upstream content for %s\n' "$path" >&2
        rm -f "$response_file"
        exit 1
    fi

    rm -f "$response_file"
}

for alias in service s wcservice wcs; do
    for operation in get has list listall listpattern lastmodified; do
        assert_response 403 Forbidden "/alfresco/${alias}/remoteadm/${operation}/alfresco/site-data/components?s=workspace://SpacesStore"
    done
done

assert_response 403 Forbidden /alfresco/wcs/%72emoteadm/listall/alfresco/site-data/components
assert_response 403 Forbidden /alfresco/wcs/ignored/../remoteadm/listall/alfresco/site-data/components
assert_response 403 Forbidden //alfresco//wcs//remoteadm/listall/alfresco/site-data/components
assert_response 403 Forbidden '/alfresco;v=1/s;session=x/remoteadm;x/listall/alfresco/site-data/components'
assert_response 403 Forbidden '/alfresco%3Bv=1/s%3Bsession=x/remoteadm%3Bx/listall/alfresco/site-data/components'
assert_response 200 'repository upstream' /alfresco/wcs/remoteadministrator/listall

assert_response 403 Forbidden /share/proxy/alfresco/remoteadm/listall/alfresco/site-data/components
assert_response 403 Forbidden /share/service/proxy/alfresco-noauth/remoteadm/listall/alfresco/site-data/components
assert_response 403 Forbidden '/share;x/service;y/proxy;z/alfresco-noauth;a/remoteadm;b/listall/alfresco/site-data/components'

for alias in service s wcservice wcs; do
    assert_response 403 Forbidden "/alfresco/${alias}/api/solr/aclchangesets"
    assert_response 403 Forbidden "/alfresco/${alias}/prometheus"
done
assert_response 403 Forbidden /share/proxy/alfresco/api/solr/aclchangesets
assert_response 403 Forbidden /share/service/proxy/alfresco/-default-/proxy/something/api/nodes
assert_response 403 Forbidden '/alfresco;x/wcservice;y/api;z/solr;a/aclchangesets'
assert_response 403 Forbidden '/share;x/service;y/proxy;z/alfresco-feed;a/api;b/solr;c/aclchangesets'
assert_response 403 Forbidden '/share;x/service;y/proxy;z/alfresco;a/-default-;b/proxy;c/something/api;d/nodes'
assert_response 403 Forbidden '/alfresco;x/wcs;y/prometheus;z'
assert_response 200 'repository upstream' /alfresco/wcs/prometheus-exporter

assert_response 200 'repository upstream' /alfresco/
assert_response 200 'repository upstream' /alfresco/api/-default-/public/alfresco/versions/1/nodes/-root-
assert_response 200 'repository upstream' /alfresco/api/-default-/public/cmis/versions/1.1/browser
assert_response 200 'repository upstream' /alfresco/aos
assert_response 200 'share upstream' /share/

internal_response="$(compose run --rm internal-client)"
printf '%s' "$internal_response" | grep -Fq 'alice-user-dashboard.xml'

printf 'NGINX security example tests passed.\n'
