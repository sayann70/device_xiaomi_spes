# ROM source patches

color="\033[0;32m"
end="\033[0m"

echo -e "${color}Applying patches${end}"
sleep 1

# Remove pixel headers to avoid conflicts
rm -rf hardware/google/pixel/kernel_headers/Android.bp

# Remove hardware/lineage/compat to avoid conflicts
rm -rf hardware/lineage/compat/Android.bp

# Kernel & Vendor Sources
git clone --depth=1 https://github.com/halt-spesn/vendor_xiaomi_spes-16 -b 16 vendor/xiaomi/spes
git clone --depth=1 https://github.com/halt-spesn/kernel_xiaomi_spes-16 -b 16 kernel/xiaomi/sm6225

# Hardware/Xiaomi
rm -fr hardware/xiaomi
git clone https://github.com/spes-development/hardware_xiaomi hardware/xiaomi
rm -fr hardware/xiaomi/vibrator/effect/Android.bp
rm -fr hardware/xiaomi/hidl/touch/Android.bp

# Debug Tools
#git clone https://github.com/spes-development/hardware_samsung-extra_interfaces -b lineage-22 hardware/samsung-ext/interfaces

# Sepolicy fix for imsrcsd
echo -e "${color}Switch back to legacy imsrcsd sepolicy${end}"
rm -rf device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/imsservice.te
cp device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/legacy-ims/hal_rcsservice.te device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/hal_rcsservice.te

# Rename conflicting qti_kernel_headers in source
sed -i 's/"qti_kernel_headers"/"qti_kernel_headers_old"/g' vendor/lineage/build/soong/Android.bp
