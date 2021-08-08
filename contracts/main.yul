object "Contract" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            if iszero(calledByOwner()) { revert(0, 0) }
            switch selector()
            case 0x00 {
                let tokenIn := shr(0x60, calldataload(0x01))
                let tokenOut := shr(0x60, calldataload(0x15))
                let amountIn := decodeAsUint112(0x29)

                let pair := getPair(tokenIn, tokenOut)
                let reserveOut, reserveIn := getReserves(pair)
                let amountOut := getAmountOut(amountIn, reserveIn, reserveOut)

                mstore(0x300, shl(0xe0, 0xa9059cbb)) mstore(add(0x300, 0x04), pair) mstore(add(0x300, 0x24), amountIn)
                if iszero(call(gas(), tokenIn, 0, 0x300, 0x44, 0, 0)) { revert(0, 0) }
                mstore(0x400, shl(0xe0, 0x022c0d9f)) mstore(add(0x400, 0x04), amountOut) 
                mstore(add(0x400, 0x44), address()) mstore(add(0x400, 0x64), 0x80)
                if iszero(call(gas(), pair, 0, 0x400, 0x84, 0, 0)) { revert(0, 0) }
            }
            case 0x01 {
                let tokenIn := shr(0x60, calldataload(0x01))
                let tokenOut := shr(0x60, calldataload(0x15))
                let amountIn := decodeAsUint112(0x29)
                
                let pair := getPair(tokenIn, tokenOut)
                let reserveIn, reserveOut := getReserves(pair)
                let amountOut := getAmountOut(amountIn, reserveIn, reserveOut)

                mstore(0x300, shl(0xe0, 0xa9059cbb)) mstore(add(0x300, 0x04), pair) mstore(add(0x300, 0x24), amountIn)
                if iszero(call(gas(), tokenIn, 0, 0x300, 0x44, 0, 0)) { revert(0, 0) }
                mstore(0x400, shl(0xe0, 0x022c0d9f)) mstore(add(0x400, 0x24), amountOut) 
                mstore(add(0x400, 0x44), address()) mstore(add(0x400, 0x64), 0x80)
                if iszero(call(gas(), pair, 0, 0x400, 0x84, 0, 0)) { revert(0, 0) }
            }
            case 0x02 { revert(0, 0) } // Withdraw
            default {
                revert(0, 0)
            }
            function calledByOwner() -> cbo {
                cbo := eq(0x0000000000bc14115F9F67fde839f285667437bC, caller())
            }
            function selector() -> s { // 1 byte
                s := shr(0xf8, calldataload(0))
            }
            function decodeAsUint112(_pos) -> v { // max is 2^112-1; 14 bytes; allocated on demand w/o zeros
                // 0x100-(dataSize-0x29)*8
                v := shr(sub(0x100, mul(8, sub(calldatasize(), _pos))), calldataload(_pos))
            }
                        // ↓ This sucks and should be deprecated
            function getPair(token0, token1) -> p {
                mstore(0, shl(0xe0, 0xe6a43905)) mstore(add(0, 0x04), token0) mstore(add(0, 0x24), token1)
                if iszero(staticcall(gas(), 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f, 0, 0x44, 0x44, 0x20)) { revert(0, 0) }
                p := mload(0x44)
            }
            function getAmountOut(amountIn, reserveIn, reserveOut) -> v {
                let aiwf := mul(amountIn, 9970)
                v := div(mul(reserveOut, aiwf), add(mul(reserveIn,10000), aiwf))
            }
            function getReserves(pair) -> r0, r1 {
                mstore(0, shl(0xe0, 0x0902f1ac))
                if iszero(staticcall(gas(), pair, 0, 0x04, 0x04, 0x40)) { revert(0, 0) }
                r0 := mload(0x04)
                r1 := mload(0x24)
            }
            /* ---------- Staging functions ---------- */
            // getPair w/o direct call, using formula
            function getPairNew(token0, token1) -> p { revert(0, 0) } 
            function sortTokens(tokenA, tokenB) -> token0, token1 { revert(0, 0) }
            //     if lt(tokenA, tokenB) {
            //         token0 := tokenA
            //         token1 := tokenB
            //     }
            //     if gt(tokenA, tokenB) {
            //         token0 := tokenB
            //         token1 := tokenA
            //     }
            // }
        }
    }
}