#add_custom_target(all_ql_tests)

# Tests for packing and placing primitives. Not to be run on actual HW !
add_subdirectory(wire)
add_subdirectory(lut)
add_subdirectory(consts)

# Test designs controlled by buttons
add_subdirectory(btn_xor)
add_subdirectory(btn_ff)
add_subdirectory(btn_counter)

