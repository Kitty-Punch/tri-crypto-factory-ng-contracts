// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Consts} from "./Consts.sol";
import {ITriKittyFactory} from "../src/interfaces/ITriKittyFactory.sol";

/*
    forge script ./script/05_TriKittyFactoryDeploy.s.sol:TriKittyFactoryDeployScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract TriKittyFactoryDeployScript is Script, Consts {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address _owner = address(0x0);
        address _feeReceiver = address(0x0);
        string memory contractName = TRI_KITTY_FACTORY;

        console.log("Fee receiver:  ", _feeReceiver);
        console.log("Owner:         ", _owner);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        address instance = deployCode(
            contractName,
            abi.encode(_feeReceiver, _owner)
        );

        vm.stopBroadcast();
        console.log(string.concat(contractName, ":  "), instance);
    }
}
