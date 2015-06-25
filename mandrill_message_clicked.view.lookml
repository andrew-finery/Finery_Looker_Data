- view: mandrill_message_clicked
  sql_table_name: atomic.com_mandrill_message_clicked_1
  fields:


  - dimension: ip
    sql: ${TABLE}.ip

  - dimension: locationcity
    sql: ${TABLE}.location.city

  - dimension: locationcountry
    sql: ${TABLE}.location.country

  - dimension: locationcountry_short
    sql: ${TABLE}.location.country_short

  - dimension: locationlatitude
    sql: ${TABLE}.location.latitude

  - dimension: locationlongitude
    sql: ${TABLE}.location.longitude

  - dimension: locationpostal_code
    sql: ${TABLE}.location.postal_code

  - dimension: locationregion
    sql: ${TABLE}.location.region

  - dimension: locationtimezone
    sql: ${TABLE}.location.timezone

  - dimension: message_id
    sql: ${TABLE}."msg._id"

  - dimension: msg_version
    sql: ${TABLE}.msg._version

  - dimension: msgclicks
    sql: ${TABLE}.msg.clicks

  - dimension: msgemail
    sql: ${TABLE}.msg.email

  - dimension: msgmetadata
    sql: ${TABLE}.msg.metadata

  - dimension: msgopens
    sql: ${TABLE}.msg.opens

  - dimension: msgresends
    sql: ${TABLE}.msg.resends

  - dimension: msgsender
    sql: ${TABLE}.msg.sender

  - dimension: msgsmtp_events
    sql: ${TABLE}.msg.smtp_events

  - dimension: msgstate
    sql: ${TABLE}.msg.state

  - dimension: msgsubject
    sql: ${TABLE}.msg.subject

  - dimension: msgtags
    sql: ${TABLE}.msg.tags

  - dimension: msgtemplate
    sql: ${TABLE}.msg.template

  - dimension_group: msgts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.msg.ts

  - dimension: ref_parent
    sql: ${TABLE}.ref_parent

  - dimension: ref_root
    sql: ${TABLE}.ref_root

  - dimension: ref_tree
    sql: ${TABLE}.ref_tree

  - dimension: root_id
    sql: ${TABLE}.root_id

  - dimension_group: root_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp

  - dimension: schema_format
    sql: ${TABLE}.schema_format

  - dimension: schema_name
    sql: ${TABLE}.schema_name

  - dimension: schema_vendor
    sql: ${TABLE}.schema_vendor

  - dimension: schema_version
    sql: ${TABLE}.schema_version

  - dimension_group: ts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ts

  - dimension: url
    sql: ${TABLE}.url

  - dimension: user_agent
    sql: ${TABLE}.user_agent

  - dimension: user_agent_parsedmobile
    sql: ${TABLE}.user_agent_parsed.mobile

  - dimension: user_agent_parsedos_company
    sql: ${TABLE}.user_agent_parsed.os_company

  - dimension: user_agent_parsedos_company_url
    sql: ${TABLE}.user_agent_parsed.os_company_url

  - dimension: user_agent_parsedos_family
    sql: ${TABLE}.user_agent_parsed.os_family

  - dimension: user_agent_parsedos_icon
    sql: ${TABLE}.user_agent_parsed.os_icon

  - dimension: user_agent_parsedos_name
    sql: ${TABLE}.user_agent_parsed.os_name

  - dimension: user_agent_parsedos_url
    sql: ${TABLE}.user_agent_parsed.os_url

  - dimension: user_agent_parsedtype
    sql: ${TABLE}.user_agent_parsed.type

  - dimension: user_agent_parsedua_company
    sql: ${TABLE}.user_agent_parsed.ua_company

  - dimension: user_agent_parsedua_company_url
    sql: ${TABLE}.user_agent_parsed.ua_company_url

  - dimension: user_agent_parsedua_family
    sql: ${TABLE}.user_agent_parsed.ua_family

  - dimension: user_agent_parsedua_icon
    sql: ${TABLE}.user_agent_parsed.ua_icon

  - dimension: user_agent_parsedua_name
    sql: ${TABLE}.user_agent_parsed.ua_name

  - dimension: user_agent_parsedua_url
    sql: ${TABLE}.user_agent_parsed.ua_url

  - dimension: user_agent_parsedua_version
    sql: ${TABLE}.user_agent_parsed.ua_version

  - measure: count
    type: count
    drill_fields: [schema_name, user_agent_parsedos_name, user_agent_parsedua_name]

