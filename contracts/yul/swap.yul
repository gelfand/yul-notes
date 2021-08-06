// WETH 0xc778417e063141139fce010982780140aa0cd5ab
// DAI  0xad6d458402f60fd3bd25163575031acdce07538d
// ffff ffff ffff ffff ffff ffff ffff_16
// ffff ffff ffff ffff ffff ffff ffff_16
object "Contract" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            // require(iszero(callvalue()))
            switch selector()
            case 0x00 {
                let inputToken := shr(0x60, calldataload(0x01))
                let outputToken := shr(0x60, calldataload(0x15))
                let inputAmount := decodeAsUint112(0x29)

                let pair := getPair(inputToken, outputToken)
                mstore(0, pair)
                return(0, 0x20)

                // let pair := getPair(inputToken, outputToken)
                // let pair := 0xffff
                // mstore(0, pair)
                // return(0, 0x64)

                // mstore(0xB00, add(shl(0xe0, 0xe6a43905), inputToken))
                // let signCall := 0xe6a4390500000000000000000000000000000000000000000000000000000000
                // let newValue := shl(224, signCall)

                // let memPos := allocate_unbounded()
                // let signPos := add(memPos, 0x20)
                
                // mstore(signPos, newValue)

                // let pairAddr := staticcall(gas(), 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, )
                // let inputAmount := shr(0x90, calldataload(0x29))
                // pop(call(gas(), addr, 0x1, 0, 0, 0, 0))
                // pop(call(gas(), addr1, 0x1, 0, 0, 0, 0))
                // pop(call(gas(), addr1, inputAmount, 0, 0, 0, 0))
                // selfdestruct(inputAmount)
            }
            case 0x01 {
                // let addr := shr(0x60, calldataload(0x01))\
                // let addr1 := shr(0x60, calldataload(0x15))
                // mstore(0, calldataload(0))
                return(0, 0x40)
            }
            case 0x02 {
                let inputToken := shr(0x60, calldataload(0x01))
                mstore(0, inputToken)
                return(0, 0x20)
            }
            case 0x03 {

                // let test  := 0xc778417e063141139fce010982780140aa0cd5ab
                // let test1 := shr(0xe0, test)
                mstore(0, 0xe6a43905)
                mstore(0x32, 0x3693d8d86845d08343b376fd81cbebe63115c6cd)
                // let test2 := add(test, 0x3693d8d86845d08343b376fd81cbebe63115c6cd)

                // let test := shr(0x10, 0x3693d8d86845d08343b376fd81cbebe63115c6cd)
                // let test2 := shr(0xe0, 0xc778417e063141139fce010982780140aa0cd5ab)
                // let test2 := add(test, 0xc778417e063141139fce010982780140aa0cd5ab)// WETH
                // let test3 := add(test2, shr(0x01,0xad6d458402f60fd3bd25163575031acdce07538d))// DAI
                // mstore(0, test2)
                return(0, 0x20)
            }
            default {
                revert(0, 0)
            }
            // function calledByOwner() -> cbo {
            //     cbo := eq(0x0000000000bc14115F9F67fde839f285667437bC, caller())
            // }
            function selector() -> s { // 1 byte
                s := shr(0xf8, calldataload(0))
            }
            function decodeAsUint112(_pos) -> v { // max is 2^112-1; 14 bytes; allocated on demand w/o zeros
                // 0x100-(dataSize-0x29)*8
                v := shr(sub(0x100, mul(8, sub(calldatasize(), _pos))), calldataload(_pos))
            } 
            function getPair(token0, token1) -> p {
                mstore(0x100, shl(0xe0, 0xe6a43905)) mstore(add(0x100, 0x04), token0) mstore(add(0x100, 0x24), token1)
                if iszero(staticcall(gas(), 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, 0x100, 0x44, 0x144, 0x20)) { revert(0, 0) }
                p := mload(0x144)
            }
            // Uses Router address and should be deprecated
            // In favor getReserves -> getAmountOut
            function getAmountOut(tokenIn, tokenOut, inputAmount) -> v { revert(0, 0) }

            /* ---------- Staging functions ---------- */
            function getReserves(pair) -> r {
                mstore(0x200, shl(0xe0, 0x0902f1ac))
                if iszero(staticcall(gas(), pair, 0x200, 0x04, 0x204, 0x40)) { revert(0, 0) }
                r := mload(0x204)
            }
            // getPair w/o direct call, using formula
            function getPairNew(token0, token1) -> p { revert(0, 0) } 
            // getAmountOut w/o direct call, using reserves
            function getAmountOutNew(amountIn, reserveIn, reserveOut) -> v { revert(0, 0) } 
        }
    }
}