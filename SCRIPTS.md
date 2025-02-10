# Project Scripts

## RPCs

Mainnet: https://mainnet.evm.nodes.onflow.org
Testnet: https://testnet.evm.nodes.onflow.org

## Scripts

### Deploy KittyMathOptimized3

forge script ./script/01_KittyMathOptimized3Deploy.s.sol:KittyMathOptimized3DeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy KittyViewOptimized3

forge script ./script/02_KittyViewOptimized3Deploy.s.sol:KittyViewOptimized3DeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy TriKittyOptimized

forge script ./script/03_TriKittyOptimizedDeploy.s.sol:TriKittyOptimizedDeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy KittyLiquidityGaugeV6 (Optional)

forge script ./script/04_KittyLiquidityGaugeV6Deploy.s.sol:KittyLiquidityGaugeV6DeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy TriKittyFactory

forge script ./script/05_TriKittyFactoryDeploy.s.sol:TriKittyFactoryDeployScript --rpc-url <rpc-url> -vvv --broadcast

### Set TriKittyFactory Implementations

forge script ./script/06_TriKittyFactorySetImplementations.s.sol:TriKittyFactorySetImplementationsScript --rpc-url <rpc-url> -vvv --slow --legacy --broadcast

### Deploy Pool

npx ts-node ./script/07_TriKittyFactoryDeployPool.ts

### Add Liquidity

forge script ./script/08_TriKittyFactoryAddLiquidity.s.sol:TriKittyFactoryAddLiquidityScript --rpc-url <rpc-url> -vvv --slow --legacy --broadcast
