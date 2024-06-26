/** @file
 *
 *  RK3588 Clock and Reset Unit (CRU) definition.
 *
 *  Copyright (c) 2024, Shimrra Shai <shimmyshai00@gmail.com>
 *  Copyright (c) 2021, ARM Limited. All rights reserved.
 *
 *  SPDX-License-Identifier: BSD-2-Clause-Patent
 *
 **/
#include "AcpiTables.h"

  Device (CRU_) {
    Name (_HID, "RKCP000F")
    Name (_UID, 0)
    Name (_CCA, 0)

    Method (_CRS, 0x0, Serialized) {
      Name (RBUF, ResourceTemplate() {
        Memory32Fixed (ReadWrite, 0xfd7c0000, 0x5c000)
        ClockInput (1100000000, 1, Hz, Fixed, "CLK0", 0)
        ClockInput (786432000, 1, Hz, Fixed, "CLK1", 0)
        ClockInput (850000000, 1, Hz, Fixed, "CLK2", 0)
        ClockInput (1188000000, 1, Hz, Fixed, "CLK3", 0)
        ClockInput (702000000, 1, Hz, Fixed, "CLK4", 0)
        ClockInput (400000000, 1, Hz, Fixed, "CLK5", 0)
        ClockInput (500000000, 1, Hz, Fixed, "CLK6", 0)
        ClockInput (800000000, 1, Hz, Fixed, "CLK7", 0)
        ClockInput (100000000, 1, Hz, Fixed, "CLK8", 0)
        ClockInput (400000000, 1, Hz, Fixed, "CLK9", 0)
        ClockInput (100000000, 1, Hz, Fixed, "CLKA", 0)
        ClockInput (200000000, 1, Hz, Fixed, "CLKB", 0)
        ClockInput (500000000, 1, Hz, Fixed, "CLKC", 0)
        ClockInput (375000000, 1, Hz, Fixed, "CLKD", 0)
        ClockInput (150000000, 1, Hz, Fixed, "CLKE", 0)
        ClockInput (200000000, 1, Hz, Fixed, "CLKF", 0)
      })
      Return (RBUF)
    }
    
    Name (_DSD, Package () {
      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
      Package () {
        Package (2) { "compatible", "rockchip,rk3588-cru" },
      }
    })

    // PLL_PPLL
    Device (CLK0) {
      Name (_HID, "RKCP0010")
      Name (_UID, 0x0)
    }
    
    // PLL_AUPLL
    Device (CLK1) {
      Name (_HID, "RKCP0011")
      Name (_UID, 0x1)
    }
    
    // PLL_NPLL
    Device (CLK2) {
      Name (_HID, "RKCP0012")
      Name (_UID, 0x2)
    }
    
    // PLL_GPLL
    Device (CLK3) {
      Name (_HID, "RKCP0013")
      Name (_UID, 0x3)
    }
    
    // ACLK_CENTER_ROOT
    Device (CLK4) {
      Name (_HID, "RKCP0014")
      Name (_UID, 0x4)
    }
    
    // HCLK_CENTER_ROOT
    Device (CLK5) {
      Name (_HID, "RKCP0015")
      Name (_UID, 0x5)
    }
    
    // ACLK_CENTER_LOW_ROOT
    Device (CLK6) {
      Name (_HID, "RKCP0016")
      Name (_UID, 0x6)
    }
    
    // ACLK_TOP_ROOT
    Device (CLK7) {
      Name (_HID, "RKCP0017")
      Name (_UID, 0x7)
    }
    
    // PCLK_TOP_ROOT
    Device (CLK8) {
      Name (_HID, "RKCP0018")
      Name (_UID, 0x8)
    }
    
    // ACLK_LOW_TOP_ROOT
    Device (CLK9) {
      Name (_HID, "RKCP0019")
      Name (_UID, 0x9)
    }
    
    // PCLK_PMU0_ROOT
    Device (CLKA) {
      Name (_HID, "RKCP001A")
      Name (_UID, 0xa)
    }
    
    // HCLK_PMU_CM0_ROOT
    Device (CLKB) {
      Name (_HID, "RKCP001B")
      Name (_UID, 0xb)
    }
    
    // ACLK_VOP
    Device (CLKC) {
      Name (_HID, "RKCP001C")
      Name (_UID, 0xc)
    }
    
    // ACLK_BUS_ROOT
    Device (CLKD) {
      Name (_HID, "RKCP001D")
      Name (_UID, 0xd)
    }
    
    // CLK_150M_SRC
    Device (CLKE) {
      Name (_HID, "RKCP001E")
      Name (_UID, 0xe)
    }
    
    // CLK_GPU
    Device (CLKF) {
      Name (_HID, "RKCP001F")
      Name (_UID, 0xf)
    }
  }
