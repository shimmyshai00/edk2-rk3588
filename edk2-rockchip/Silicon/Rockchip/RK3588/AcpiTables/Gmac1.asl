/** @file
 *
 *  Copyright (c) 2022, Jared McNeill <jmcneill@invisible.ca>
 *  Copyright (c) 2023, Mario Bălănică <mariobalanica02@gmail.com>
 *
 *  SPDX-License-Identifier: BSD-2-Clause-Patent
 *
 **/

#include "AcpiTables.h"

// Gigabit Media Access Controller (GMAC1)
Device (MAC1) {
  Name (_HID, "RKCP6543")
  Name (_CID, Package() {
    "PRP0001"
  })
  Name (_UID, 61)
  Name (_CCA, 0)
  Name (_STA, 0xF)

  Method (_CRS, 0x0, Serialized) {
    Name (RBUF, ResourceTemplate() {
      Memory32Fixed (ReadWrite, 0xfe1c0000, 0x10000)
      Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 266, 265 }
    })
    Return (RBUF)
  }

  Name (_DSD, Package () {
    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package () {
      Package () { "compatible", Package () { "snps,dwmac-4.20a", "snps,dwmac" } },
      Package () { "interrupt-names", Package () { "macirq", "eth_wake_irq" } },
      Package () { "snps,mixed-burst", 1 },
      Package () { "snps,tso", 1 },
      Package () { "snps,axi-config", "AXIC" },
#ifdef GMAC1_CONFIGURE_PHY
      Package () { "phy-mode", GMAC1_PHY_MODE },
      Package () { "phy-handle", GMAC1_PHY_HANDLE },
#endif // GMAC1_CONFIGURE_PHY
    }
  })

  Name (AXIC, Package () {
    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package () {
      Package () { "snps,wr_osr_lmt", 4 },
      Package () { "snps,rd_osr_lmt", 8 },
      Package () { "snps,blen", Package () { 0, 0, 0, 0, 16, 8, 4 } },
    }
  })

  Method (_DSM, 4, Serialized) {
    // PHP_GRF_CLK_CON1
    OperationRegion (PGRF, SystemMemory, 0xfd5b0070, 0x4)
    Field (PGRF, DWordAcc, NoLock, Preserve) {
      CON1, 32
    }

    // Check the UUID
    If (Arg0 == ToUUID ("d637828d-556c-4829-966a-237072f00ff1")) {
      // Check the revision
      If (Arg1 >= 0) {
        // Check the function index
        Switch (ToInteger (Arg2)) {
          //
          // Supported functions:
          // Bit 0 - Indicates support for functions other than 0
          // Bit 1 - Indicates support for setting the MII speed
          //
          Case (0) {
            Return (Buffer () { 0x03 })
          }

          //
          // Function Index 1: Set MII speed
          //
          Case (1) {
            Local0 = DerefOf (Arg3[0])

            Switch (ToInteger (Local0)) {
              Case (1000) {
                CON1 = 0x01800000
              }
              Case (100) {
                CON1 = 0x01800180
              }
              Case (10) {
                CON1 = 0x01800100
              }
            }
            Return (Buffer () { 0x00 })
          }
        } // Function index check
      } // Revision check
    } // UUID check
    Return (Buffer () { 0x0 })
  } // _DSM
  
  Device (MDIO) {
    Name (_ADR, 0x1)
    Name (_DSD, Package () {
      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
      Package () {
        Package () { "compatible", "snps,dwmac-mdio" },
      }
    })
  }
}
