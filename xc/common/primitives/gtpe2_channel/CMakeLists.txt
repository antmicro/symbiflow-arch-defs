add_file_target(FILE ntemplate.gtpe2_channel_N.model.xml SCANNER_TYPE xml)
add_file_target(FILE ntemplate.gtpe2_channel_N.pb_type.xml SCANNER_TYPE xml)
add_file_target(FILE ntemplate.gtpe2_channel_N_mid_left.model.xml SCANNER_TYPE xml)
add_file_target(FILE ntemplate.gtpe2_channel_N_mid_left.pb_type.xml SCANNER_TYPE xml)
add_file_target(FILE ntemplate.gtpe2_channel_N_mid_right.model.xml SCANNER_TYPE xml)
add_file_target(FILE ntemplate.gtpe2_channel_N_mid_right.pb_type.xml SCANNER_TYPE xml)

n_template(
    NAME gtp_channel_N.pb_type.xml
    PREFIXES 0;1;2;3
    SRCS ntemplate.gtpe2_channel_N.pb_type.xml
    )
n_template(
    NAME gtp_channel_N.model.xml
    PREFIXES 0;1;2;3
    SRCS ntemplate.gtpe2_channel_N.model.xml
    )
n_template(
    NAME gtp_channel_N_mid_left.model.xml
    PREFIXES 0;1;2;3
    SRCS ntemplate.gtpe2_channel_N_mid_left.model.xml
    )
n_template(
    NAME gtp_channel_N_mid_left.pb_type.xml
    PREFIXES 0;1;2;3
    SRCS ntemplate.gtpe2_channel_N_mid_left.pb_type.xml
    )
n_template(
    NAME gtp_channel_N_mid_right.model.xml
    PREFIXES 0;1;2;3
    SRCS ntemplate.gtpe2_channel_N_mid_right.model.xml
    )
n_template(
    NAME gtp_channel_N_mid_right.pb_type.xml
    PREFIXES 0;1;2;3
    SRCS ntemplate.gtpe2_channel_N_mid_right.pb_type.xml
    )
