// WETH 0xc778417e063141139fce010982780140aa0cd5ab
// DAI  0xad6d458402f60fd3bd25163575031acdce07538d
// ffff ffff ffff ffff ffff ffff ffff_16
// ffff ffff ffff ffff ffff ffff ffff_16
object "Assembly" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {

            // 0xC00 - out

            // mstore(0, shl(0xe0, 0xe6a43905))
            // mstore(add(0, 0x04), 0xad6d458402f60fd3bd25163575031acdce07538d)
            // mstore(add(0, 0x24), 0xc778417e063141139fce010982780140aa0cd5ab)

            // pop(staticcall(gas(), 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, 0, 0x44, 0xC00, 0x20))
            // return(0xC00, 0x20)

            let pair := getPair(0xad6d458402f60fd3bd25163575031acdce07538d, 0xc778417e063141139fce010982780140aa0cd5ab)
            // mstore(0, pair)
            // return(0, 0x20)

            




            // // let test2 := add(add(shl(0xe0, 0xe6a43905), 0x3693d8d86845d08343b376fd81cbebe63115c6cd), shr(0x90,0xc778417e063141139fce010982780140aa0cd5ab))
            // mstore(0, add(shl(0xe0, 0xe6a43905), 0xc778417e063141139fce010982780140aa0cd5ab))
            // let _tmp := mload(0)
            // mstore(0, add(_tmp, 0x20))
            // mstore(add(_tmp, 0x00), add(0x3693d8d86845d08343b376fd81cbebe63115c6cd))
            // // mstore(0, add(shl(0xe0,0x3693d8d86845d08343b376fd81cbebe63115c6cd), 0xc778417e063141139fce010982780140aa0cd5ab))
            // // let test := shr(0x10, 0x3693d8d86845d08343b376fd81cbebe63115c6cd)
            // // let test2 := shr(0xe0, 0xc778417e063141139fce010982780140aa0cd5ab)
            // // let test2 := add(test, 0xc778417e063141139fce010982780140aa0cd5ab)// WETH
            // // let test3 := add(test2, shr(0x01,0xad6d458402f60fd3bd25163575031acdce07538d))// DAI
            // return(0, 0x200)

            // let test  := 0xc778417e063141139fce010982780140aa0cd5ab
            // let test1 := shr(0xe0, test)
            // mstore(0, 0xe6a43905)
            // mstore(0, 0xe6a43905)
            // mstore(0, 0x0902f1ac00000000000000000000000000000000000000000000000000000000)

            // mstore(0, shl(0xe0, 0xe6a43905))
            // mstore(0x04, 0xc778417e063141139fce010982780140aa0cd5ab)
            // mstore(0x28, 0x1f2d886741c25c492495d4eac959152be60d7271)

            // mstore(0, add(, 0xc778417e063141139fce010982780140aa0cd5ab))
            // mstore(0x20, 0x1f2d886741c25c492495d4eac959152be60d7271)
            // mstore(0x10, )
            // mstore(0x10, )
            // mstore(add(0, 32), 0xc778417e063141139fce010982780140aa0cd5ab)
            // mstore(0, )
            // let test2 := add(test, 0x3693d8d86845d08343b376fd81cbebe63115c6cd)

            // let test := shr(0x10, 0x3693d8d86845d08343b376fd81cbebe63115c6cd)
            // let test2 := shr(0xe0, 0xc778417e063141139fce010982780140aa0cd5ab)
            // let test2 := add(test, 0xc778417e063141139fce010982780140aa0cd5ab)// WETH
            // let test3 := add(test2, shr(0x01,0xad6d458402f60fd3bd25163575031acdce07538d))// DAI
            // mstore(0, test2)
            // mstore(0, verbatim_0i_1o(hex"48"))
            return(0, 0x64)

            function getPair(token0, token1) -> p {
                mstore(0x100, shl(0xe0, 0xe6a43905)) mstore(add(0x100, 0x04), token0) mstore(add(0x100, 0x24), token1)
                if iszero(staticcall(gas(), 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, 0x100, 0x44, 0x144, 0x20)) { revert(0, 0) }
                p := mload(0x144)
            }
        }
    }
}