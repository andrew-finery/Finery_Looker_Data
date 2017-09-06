- dashboard: web_traffic_trends
  title: Web Traffic Trends
  layout: static
  tile_size: 100

  filters:

  elements:

# All Time SIte Visits

  - name: site_visits_by_month_all_time
    title: Site Visits by Month - All Time
    model: finery_data
    explore: sessions
    type: looker_area
    fields: [sessions.count, session_start_calendar.calendar_date_month]
    fill_fields: [session_start_calendar.calendar_date_month]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
      session_start_calendar.calendar_date_month: before 0 months ago
    sorts: [session_start_calendar.calendar_date_month desc]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
        type: linear, unpinAxis: false, valueFormat: '###, "k"', series: [{id: sessions.count,
            name: Visits Total}]}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    top: 0
    left: -1
    height: 4
    width: 5


  - name: site_visits_by_month_yoy_graph
    title: Site Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016'}, {id: '2017', name: '2017'}]}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 0
    left: 4
    height: 4
    width: 5


  - name: site_visits_by_month_yoy_table
    title: Site Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: yoy
      label: YoY
      expression: "(${sessions.count} - pivot_offset(${sessions.count}, -1))/pivot_offset(${sessions.count},\
        \ -1)"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016'}, {id: '2017', name: '2017'}]}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"]}, bold: false, italic: false, strikethrough: false}]
    top: 0
    left: 9
    height: 4
    width: 5

# Stats by Device

  - name: all_time_traffic_by_device
    title: Traffic by Device - All Time
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month, sessions.device_type]
    pivots: [sessions.device_type]
    fill_fields: [session_start_calendar.calendar_date_month]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.device_type: "-Other/Unknown"
    sorts: [session_start_calendar.calendar_date_month desc, sessions.device_type]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '####,"k"', series: [{id: Desktop,
            name: Desktop, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 51}, {id: Tablet, name: Tablet}, {id: Mobile, name: Mobile}],
        __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 49}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 4
    left: -1
    height: 4
    width: 5


  - name: mobile_site_visits_yoy
    title: Mobile Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.device_type: Mobile
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 108},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 109}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 106}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 4
    left: 4
    height: 4
    width: 5

  - name: mobile_visits_yoy_table
    title: Mobile Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.device_type: Mobile
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: yoy
      label: YoY
      expression: "(${sessions.count} - pivot_offset(${sessions.count}, -1))/pivot_offset(${sessions.count},\
        \ -1)"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 181},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 182}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 179}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
          __LINE_NUM: 189}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 188}]
    top: 4
    left: 9
    height: 4
    width: 5

# Row 3

  - name: cr_by_device_all_time
    title: Conversion Rate by Device - All Time
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [session_start_calendar.calendar_date_month, sessions.device_type, sessions.conversion_rate]
    pivots: [sessions.device_type]
    fill_fields: [session_start_calendar.calendar_date_month]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.device_type: "-Other/Unknown"
    sorts: [session_start_calendar.calendar_date_month desc, sessions.device_type]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Conversion Rate, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: 0.0%, series: [{id: Desktop, name: Desktop,
            __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 242},
          {id: Tablet, name: Tablet, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 244}, {id: Mobile, name: Mobile, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 244}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 240}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 8
    left: -1
    height: 4
    width: 5


  - name: desktop_and_able_visits_yoy
    title: Desktop & Tablet Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.device_type: Desktop,Tablet
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 108},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 109}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 106}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 8
    left: 4
    height: 4
    width: 5

  - name: desktop_visits_yoy_table
    title: Desktop Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.device_type: Tablet,Desktop
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: yoy
      label: YoY
      expression: "(${sessions.count} - pivot_offset(${sessions.count}, -1))/pivot_offset(${sessions.count},\
        \ -1)"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 181},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 182}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 179}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
          __LINE_NUM: 189}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 188}]
    top: 8
    left: 9
    height: 4
    width: 5

# row 4

  - name: all_time_traffic_by_uk_non_uk
    title: Traffic by Country - All Time
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month, sessions.geography_country_uk_flag]
    pivots: [sessions.geography_country_uk_flag]
    fill_fields: [session_start_calendar.calendar_date_month]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
      session_start_calendar.calendar_date_month: before 0 months ago
    sorts: [session_start_calendar.calendar_date_month desc, sessions.geography_country_uk_flag]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '####,"k"', series: [{id: Desktop,
            name: Desktop, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 51}, {id: Tablet, name: Tablet}, {id: Mobile, name: Mobile}],
        __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 49}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 12
    left: -1
    height: 4
    width: 5


  - name: uk_site_visits_yoy
    title: UK Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.geography_country_uk_flag: UK
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 108},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 109}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 106}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 12
    left: 4
    height: 4
    width: 5

  - name: uk_visits_yoy_table
    title: UK Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.geography_country_uk_flag: UK
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: yoy
      label: YoY
      expression: "(${sessions.count} - pivot_offset(${sessions.count}, -1))/pivot_offset(${sessions.count},\
        \ -1)"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 181},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 182}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 179}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
          __LINE_NUM: 189}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 188}]
    top: 12
    left: 9
    height: 4
    width: 5

# Row 5

  - name: cr_by_country_all_time
    title: Conversion Rate by Country - All Time
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [session_start_calendar.calendar_date_month, sessions.geography_country_uk_flag, sessions.conversion_rate]
    pivots: [sessions.geography_country_uk_flag]
    fill_fields: [session_start_calendar.calendar_date_month]
    filters:
      session_start_calendar.calendar_date_date: after 2015/02/01
      session_start_calendar.calendar_date_month: before 0 months ago
    sorts: [session_start_calendar.calendar_date_month desc, sessions.geography_country_uk_flag]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Conversion Rate, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: 0.0%, series: [{id: Desktop, name: Desktop,
            __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 242},
          {id: Tablet, name: Tablet, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 244}, {id: Mobile, name: Mobile, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 244}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 240}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 16
    left: -1
    height: 4
    width: 5


  - name: non_uk_visits_yoy
    title: Non-UK Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: looker_line
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.geography_country_uk_flag: Non-UK
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 108},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 109}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 106}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    top: 16
    left: 4
    height: 4
    width: 5

  - name: non_uk_visits_yoy_table
    title: Non-UK Visits by Month - YoY
    model: finery_data
    explore: sessions
    type: table
    fields: [sessions.count, session_start_calendar.calendar_date_month_num, sessions.start_year]
    pivots: [sessions.start_year]
    fill_fields: [session_start_calendar.calendar_date_month_num, sessions.start_year]
    filters:
      session_start_calendar.calendar_date_date: after 1 years ago
      session_start_calendar.calendar_date_month: before 0 months ago
      sessions.geography_country_uk_flag: Non-UK
    sorts: [sessions.start_year 0, session_start_calendar.calendar_date_month_num]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: yoy
      label: YoY
      expression: "(${sessions.count} - pivot_offset(${sessions.count}, -1))/pivot_offset(${sessions.count},\
        \ -1)"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hide_legend: false
    y_axes: [{label: Site Visits, maxValue: !!null '', minValue: !!null '', orientation: left,
        showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: !!null '',
        type: linear, unpinAxis: false, valueFormat: '###,"k"', series: [{id: '2016',
            name: '2016', __FILE: finery_data/web_traffic_trends.dashboard.lookml, __LINE_NUM: 181},
          {id: '2017', name: '2017', __FILE: finery_data/web_traffic_trends.dashboard.lookml,
            __LINE_NUM: 182}], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 179}]
    trend_lines: []
    reference_lines: []
    x_axis_label: Month
    colors: ['palette: Santa Cruz']
    series_colors: {}
    conditional_formatting: [{type: low to high, value: !!null '', background_color: !!null '',
        font_color: !!null '', palette: {name: Red to Yellow to Green, colors: ["#F36254",
            "#FCF758", "#4FBC89"], __FILE: finery_data/web_traffic_trends.dashboard.lookml,
          __LINE_NUM: 189}, bold: false, italic: false, strikethrough: false, __FILE: finery_data/web_traffic_trends.dashboard.lookml,
        __LINE_NUM: 188}]
    top: 16
    left: 9
    height: 4
    width: 5
