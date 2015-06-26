- view: mandrill_message_opened
  sql_table_name: atomic.com_mandrill_message_opened_1
  fields:

  - dimension: event_id
    sql: ${TABLE}.root_id

  - dimension_group: message_opened
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.root_tstamp

  - dimension: email_id
    sql: ${TABLE}."msg._id"

  - dimension: ip
    sql: ${TABLE}."ip"

  - dimension: location_city
    sql: ${TABLE}."location.city"

  - dimension: location_country
    sql: ${TABLE}."location.country"

  - dimension: location_country_short
    sql: ${TABLE}."location.country_short"

  - dimension: location_latitude
    sql: ${TABLE}."location.latitude"

  - dimension: location_longitude
    sql: ${TABLE}."location.longitude"

  - dimension: location_postal_code
    sql: ${TABLE}."location.postal_code"

  - dimension: location_region
    sql: ${TABLE}."location.region"

  - dimension: location_timezone
    sql: ${TABLE}."location.timezone"

  - dimension: email_sent_to
    sql: ${TABLE}."msg.email"
    hidden: true

  - dimension: email_sender
    sql: ${TABLE}."msg.sender"
    hidden: true

  - dimension: email_state
    sql: ${TABLE}."msg.state"
    hidden: true

  - dimension: user_agent
    sql: ${TABLE}.user_agent

  - dimension: user_agent_parsedmobile
    sql: ${TABLE}."user_agent_parsed.mobile"
    hidden: true

  - dimension: user_agent_parsedos_company
    sql: ${TABLE}."user_agent_parsed.os_company"
    hidden: true

  - dimension: user_agent_parsedos_company_url
    sql: ${TABLE}."user_agent_parsed.os_company_url"
    hidden: true

  - dimension: user_agent_parsedos_family
    sql: ${TABLE}."user_agent_parsed.os_family"
    hidden: true

  - dimension: user_agent_parsedos_icon
    sql: ${TABLE}."user_agent_parsed.os_icon"
    hidden: true

  - dimension: user_agent_parsedos_name
    sql: ${TABLE}."user_agent_parsed.os_name"
    hidden: true

  - dimension: user_agent_parsedos_url
    sql: ${TABLE}."user_agent_parsed.os_url"
    hidden: true

  - dimension: user_agent_parsedtype
    sql: ${TABLE}."user_agent_parsed.type"
    hidden: true

  - dimension: user_agent_parsedua_company
    sql: ${TABLE}."user_agent_parsed.ua_company"
    hidden: true

  - dimension: user_agent_parsedua_company_url
    sql: ${TABLE}."user_agent_parsed.ua_company_url"
    hidden: true

  - dimension: user_agent_parsedua_family
    sql: ${TABLE}."user_agent_parsed.ua_family"
    hidden: true

  - dimension: user_agent_parsedua_icon
    sql: ${TABLE}."user_agent_parsed.ua_icon"
    hidden: true

  - dimension: user_agent_parsedua_name
    sql: ${TABLE}."user_agent_parsed.ua_name"
    hidden: true

  - dimension: user_agent_parsedua_url
    sql: ${TABLE}."user_agent_parsed.ua_url"
    hidden: true

  - dimension: user_agent_parsedua_version
    sql: ${TABLE}."user_agent_parsed.ua_version"
    hidden: true

  - measure: count_opens
    type: count_distinct
    sql: ${event_id}
  
  - measure: count_unique_opens
    type: count_distinct
    sql: ${email_id}

