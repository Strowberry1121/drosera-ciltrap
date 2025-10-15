// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.13;   

import {IERC20} from "forge-std/interfaces/IERC20.sol";

interface ITrap {
    function collect() external view returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory);
}

contract CILTrap is ITrap {
    address public constant SILBAL_TOKEN_ADDRESS = 0x7919Ca40B3F38791fe61Dc864f633a93478b2810;
    address public constant WATCHED_ADDRESS = 0xc9e1c01f8a67e850BCa0178599F968d48B2A43e4;

    IERC20 private constant SILBAL = IERC20(SILBAL_TOKEN_ADDRESS);

    struct Action {
        uint256 watchedBalance;
    }

    function collect() external view override returns (bytes memory) {
        Action memory snapshot = Action({
            watchedBalance: SILBAL.balanceOf(WATCHED_ADDRESS)
        });
        return abi.encode(snapshot);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) {
            return (false, bytes("Insufficient historical data"));
        }
        Action memory current = abi.decode(data[0], (Action));
        Action memory previous = abi.decode(data[1], (Action));

        if (previous.watchedBalance > current.watchedBalance &&
            previous.watchedBalance - current.watchedBalance > 10_000_000) // 10 tokens threshold
        {
            return (true, bytes("Detected decrease > 10 SILBAL"));
        }
        return (false, bytes(""));
    }
}
