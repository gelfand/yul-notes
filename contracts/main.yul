// WETH 0xc778417e063141139fce010982780140aa0cd5ab
// DAI  0xad6d458402f60fd3bd25163575031acdce07538d
// ffff ffff ffff ffff ffff ffff ffff_16
// ffff ffff ffff ffff ffff ffff ffff_16
// Uniswap Factory - 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f
// Uniswap Router - 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
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
                let tokenIn := shr(0x60, calldataload(0x01))
                let tokenOut := shr(0x60, calldataload(0x15))
                let amountIn := decodeAsUint112(0x29)

                // let pair := getPair(inputToken, outputToken)
                // let r0, r1 := getReserves(getPair(inputToken, outputToken))
                // mstore(0, r0)
                // mstore(add(0, 0x20), r1)
                // return(0, 0x40)

                let pair := getPair(tokenIn, tokenOut)
                let reserveIn, reserveOut := getReserves(pair)
                let amountOut := getAmountOut(amountIn, reserveIn, reserveOut)

                mstore(0x300, shl(0xe0, 0xa9059cbb)) mstore(add(0x300, 0x04), pair) mstore(add(0x300, 0x24), amountIn)
                if iszero(call(gas(), tokenIn, 0, 0x300, 0x44, 0, 0)) { revert(0, 0) }
                mstore(0x400, shl(0xe0, 0x022c0d9f)) mstore(add(0x400, 0x04), amountOut) 
                mstore(add(0x400, 0x44), address()) mstore(add(0x400, 0x64), 0)
                if iszero(call(gas(), pair, 0, 0x400, 0x84, 0, 0)) { revert(0, 0) }
                // mstore(0, amountOut)
                // return(0x400, 0x84)


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
            default {
                // revert(0, 0)
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
            // ↓ This sucks and should be deprecated
            function getPair(token0, token1) -> p {
                mstore(0x100, shl(0xe0, 0xe6a43905)) mstore(add(0x100, 0x04), token0) mstore(add(0x100, 0x24), token1)
                if iszero(staticcall(gas(), 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, 0x100, 0x44, 0x144, 0x20)) { revert(0, 0) }
                p := mload(0x144)
            }
            function getAmountOut(amountIn, reserveIn, reserveOut) -> v {
                let aiwf := mul(amountIn, 9970)
                v := div(mul(reserveOut,aiwf), add(mul(reserveIn,10000), aiwf))
            }
            function getReserves(pair) -> r0, r1 {
                mstore(0x200, shl(0xe0, 0x0902f1ac))
                if iszero(staticcall(gas(), pair, 0x200, 0x04, 0x204, 0x40)) { revert(0, 0) }
                r0 := mload(0x204)
                r1 := mload(0x224)
            }
            /* ---------- Staging functions ---------- */
            // getPair w/o direct call, using formula
            function getPairNew(token0, token1) -> p { revert(0, 0) } 
        }
    }
}