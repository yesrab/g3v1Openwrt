REQUIRE_IMAGE_METADATA=1

platform_do_upgrade() {
  PART_NAME="firmware"
  default_do_upgrade "$1"
}

platform_check_image() {
  return 0
}
