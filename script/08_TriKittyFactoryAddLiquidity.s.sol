// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ITriKittyOptimized} from "../src/interfaces/ITriKittyOptimized.sol";
import {MockToken} from "../test/mocks/MockToken.sol";
import {Consts} from "./Consts.sol";

/*
    
    forge script ./script/08_TriKittyFactoryAddLiquidity.s.sol:TriKittyFactoryAddLiquidityScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract TriKittyFactoryAddLiquidityScript is Script, Consts {
    uint256 _token0Amount = 10000e18;
    uint256 _token1Amount = 20000e18;
    uint256 _token2Amount = 40000e18;

    address uptober = address(0x0);
    address moonvember = address(0x0);
    address bullcember = address(0x0);

    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address _creator = vm.envAddress(PARAM_OWNER);
        ITriKittyOptimized _pool = ITriKittyOptimized(address(0x0));

        MockToken _token0 = MockToken(uptober);
        MockToken _token1 = MockToken(moonvember);
        MockToken _token2 = MockToken(bullcember);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        _token0.mint(_creator, _token0Amount);
        _token1.mint(_creator, _token1Amount);
        _token2.mint(_creator, _token2Amount);

        _token0.approve(address(_pool), _token0Amount);
        _token1.approve(address(_pool), _token1Amount);
        _token2.approve(address(_pool), _token2Amount);

        console.log("Gamma: ", _pool.gamma());
        console.log("A: ", _pool.A());

        uint256[3] memory _amounts = [
            _token0Amount,
            _token1Amount,
            _token2Amount
        ];

        console.log("Adding liquidity...");
        uint256 _poolShares = _pool.add_liquidity(_amounts, 0);
        console.log("New pool shares:   ", _poolShares);

        console.log("Getting dy...");
        uint256 _dx = 10e18;
        uint256 _dy = _pool.get_dy(0, 1, _dx);
        console.log("Dx:            ", _dx);
        console.log("Dy:            ", _dy);

        console.log("Approving tokens...");
        _token0.mint(_creator, _dx);
        _token0.approve(address(_pool), _dx);
        console.log("Exchanging tokens...");
        uint256 _dySwapped = _pool.exchange(0, 1, _dx, _dy);

        console.log("Dy swapped:    ", _dySwapped);

        console.log("Removing liquidity...");

        uint256 lpToBurn = (_poolShares * 10) / 100; // Burn 10% of the pool shares
        console.log("LP to burn: ", lpToBurn);
        uint256[3] memory _removeAmounts;
        _removeAmounts[0] =
            (((lpToBurn * _token0Amount) / _pool.totalSupply()) * 90) /
            100;
        _removeAmounts[1] =
            (((lpToBurn * _token1Amount) / _pool.totalSupply()) * 90) /
            100;
        _removeAmounts[2] =
            (((lpToBurn * _token2Amount) / _pool.totalSupply()) * 90) /
            100;
        console.log("Amount Token 0 to remove: ", _removeAmounts[0]);
        console.log("Amount Token 1 to remove: ", _removeAmounts[1]);
        console.log("Amount Token 2 to remove: ", _removeAmounts[2]);

        uint256[3] memory _poolSharesRemoved = _pool.remove_liquidity(
            lpToBurn,
            _removeAmounts
        );
        console.log("_poolSharesRemoved.length: ", _poolSharesRemoved.length);
        console.log("Amount Token 0 Removed: ", _poolSharesRemoved[0]);
        console.log("Amount Token 1 Removed: ", _poolSharesRemoved[1]);
        console.log("Amount Token 2 Removed: ", _poolSharesRemoved[2]);

        vm.stopBroadcast();
    }
}
