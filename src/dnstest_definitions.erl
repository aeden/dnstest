-module(dnstest_definitions).

-include("dns.hrl").

-export([definitions/0]).

definitions() ->
  [
    % 1	example.com.	IN	SOA	86400	ns1.example.com. ahu.example.com. 2000081501 28800 7200 604800 86400
    % 2	.	IN	OPT	32768	
    % Rcode: 3, RD: 0, QR: 1, TC: 0, AA: 1, opcode: 0
    % Reply to question for qname='nxdomain.example.com.', qtype=ANY

    {any_nxdomain, {
        {question, {"nxdomain.example.com", ?DNS_TYPE_ANY}},
        {header, #dns_message{rc=?DNS_RCODE_NXDOMAIN, rd=false, qr=true, tc=false, aa=true, oc=?DNS_OPCODE_QUERY}},
        {records, {
            {answers, []},
            {authority, [
                {<<"example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_SOA, 86400, #dns_rrdata_soa{mname = <<"ns1.example.com">>, rname = <<"ahu.example.com">>, serial=2000081501, refresh=28800, retry=7200, expire=604800, minimum = 86400}}
              ]},
            {additional, [
                %{<<".">>, ?DNS_CLASS_IN, ?DNS_TYPE_OPT, 32768}
              ]}
          }}}},

    % 0	example.com.	IN	MX	120	10 smtp-servers.example.com.
    % 0	example.com.	IN	MX	120	15 smtp-servers.test.com.
    % 0	example.com.	IN	NS	120	ns1.example.com.
    % 0	example.com.	IN	NS	120	ns2.example.com.
    % 0	example.com.	IN	SOA	100000	ns1.example.com. ahu.example.com. 2000081501 28800 7200 604800 86400
    % 2	.	IN	OPT	0	
    % 2	ns1.example.com.	IN	A	120	192.168.1.1
    % 2	ns2.example.com.	IN	A	120	192.168.1.2
    % 2	smtp-servers.example.com.	IN	A	120	192.168.0.2
    % 2	smtp-servers.example.com.	IN	A	120	192.168.0.3
    % 2	smtp-servers.example.com.	IN	A	120	192.168.0.4
    % Rcode: 0, RD: 0, QR: 1, TC: 0, AA: 1, opcode: 0
    % Reply to question for qname='example.com.', qtype=ANY

    {any_query, {
        {question, {"example.com", ?DNS_TYPE_ANY}},
        {header, #dns_message{rc=?DNS_RCODE_NOERROR, rd=false, qr=true, tc=false, aa=true, oc=?DNS_OPCODE_QUERY}},
        {records, {
            {answers, [
                {<<"example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_MX, 120, #dns_rrdata_mx{preference=10, exchange = <<"smtp-servers.example.com">>}},
                {<<"example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_MX, 120, #dns_rrdata_mx{preference=15, exchange = <<"smtp-servers.test.com">>}},
                {<<"example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_NS, 120, #dns_rrdata_ns{dname = <<"ns1.example.com">>}},
                {<<"example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_NS, 120, #dns_rrdata_ns{dname = <<"ns2.example.com">>}},
                {<<"example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_SOA, 100000, #dns_rrdata_soa{mname = <<"ns1.example.com">>, rname = <<"ahu.example.com">>, serial=2000081501, refresh=28800, retry=7200, expire=604800, minimum = 86400}}
              ]},
            {authority, []},
            {additional, [
                %{<<".">>, ?DNS_CLASS_IN, ?DNS_TYPE_OPT, 0},
                {<<"ns1.example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 120, #dns_rrdata_a{ip = {192,168,1,1}}},
                {<<"ns2.example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 120, #dns_rrdata_a{ip = {192,168,1,2}}},
                {<<"smtp-servers.example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 120, #dns_rrdata_a{ip = {192,168,0,2}}},
                {<<"smtp-servers.example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 120, #dns_rrdata_a{ip = {192,168,0,3}}},
                {<<"smtp-servers.example.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 120, #dns_rrdata_a{ip = {192,168,0,4}}}
              ]}
          }}}},

    % 0	www.something.wtest.com.	IN	A	3600	4.3.2.1
    % Rcode: 0, RD: 0, QR: 1, TC: 0, AA: 1, opcode: 0
    % Reply to question for qname='www.something.wtest.com.', qtype=ANY

    {any_wildcard, {
        {question, {"www.something.wtest.com", ?DNS_TYPE_ANY}},
        {header, #dns_message{rc=?DNS_RCODE_NOERROR, rd=false, qr=true, tc=false, aa=true, oc=?DNS_OPCODE_QUERY}},
        {records, {
            {answers, [
                {<<"www.something.wtest.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 3600, #dns_rrdata_a{ip = {4,3,2,1}}}
              ]},
            {authority, []},
            {additional, []}
          }}
      }},

    % 1	test.com.	IN	SOA	3600	ns1.test.com. ahu.example.com. 2005092501 28800 7200 604800 86400
    % Rcode: 0, RD: 0, QR: 1, TC: 0, AA: 1, opcode: 0
    % Reply to question for qname='test.com.', qtype=A

    {apex_level_a_but_no_a, {
        {question, {"test.com", ?DNS_TYPE_A}},
        {header, #dns_message{rc=?DNS_RCODE_NOERROR, rd=false, qr=true, tc=false, aa=true, oc=?DNS_OPCODE_QUERY}},
        {records, {
            {answers, []},
            {authority, [
                {<<"test.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_SOA, 3600, #dns_rrdata_soa{mname = <<"ns1.test.com">>, rname = <<"ahu.example.com">>, serial=2005092501, refresh=28800, retry=7200, expire=604800, minimum = 86400}}
              ]},
            {additional, []}
          }}
      }},

    % 0	wtest.com.	IN	A	3600	9.9.9.9
    % Rcode: 0, RD: 0, QR: 1, TC: 0, AA: 1, opcode: 0
    % Reply to question for qname='wtest.com.', qtype=A

    {apex_level_a, {
        {question, {"wtest.com", ?DNS_TYPE_A}},
        {header, #dns_message{rc=?DNS_RCODE_NOERROR, rd=false, qr=true, tc=false, aa=true, oc=?DNS_OPCODE_QUERY}},
        {records, {
            {answers, [
                {<<"wtest.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_A, 3600, #dns_rrdata_a{ip = {9,9,9,9}}}
              ]},
            {authority, []},
            {additional, []}
          }}
      }},

    % 0	test.com.	IN	NS	3600	ns1.test.com.
    % 0	test.com.	IN	NS	3600	ns2.test.com.
    % Rcode: 0, RD: 0, QR: 1, TC: 0, AA: 1, opcode: 0
    % Reply to question for qname='test.com.', qtype=NS

    {apex_level_ns, {
        {question, {"test.com", ?DNS_TYPE_NS}},
        {header, #dns_message{rc=?DNS_RCODE_NOERROR, rd=false, qr=true, tc=false, aa=true, oc=?DNS_OPCODE_QUERY}},
        {records, {
            {answers, [
                {<<"test.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_NS, 3600, #dns_rrdata_ns{dname = <<"ns1.test.com">>}},
                {<<"test.com">>, ?DNS_CLASS_IN, ?DNS_TYPE_NS, 3600, #dns_rrdata_ns{dname = <<"ns2.test.com">>}}
              ]},
            {authority, []},
            {additional, []}
          }}
      }}

  ].

