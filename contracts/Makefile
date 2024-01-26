-include .env

.PHONY: vouchers deploy env test

info: header

define HEADER    

███████╗ ██████╗██╗  ██╗ ██████╗       ██████╗ ██╗     ██╗   ██╗███████╗      ██████╗ ███████╗██████╗  ██████╗ ██╗     ██╗     
██╔════╝██╔════╝██║  ██║██╔═══██╗      ██╔══██╗██║     ██║   ██║██╔════╝      ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██║     ██║     
█████╗  ██║     ███████║██║   ██║█████╗██████╔╝██║     ██║   ██║███████╗█████╗██║  ██║█████╗  ██████╔╝██║   ██║██║     ██║     
██╔══╝  ██║     ██╔══██║██║   ██║╚════╝██╔═══╝ ██║     ██║   ██║╚════██║╚════╝██║  ██║██╔══╝  ██╔══██╗██║   ██║██║     ██║     
███████╗╚██████╗██║  ██║╚██████╔╝      ██║     ███████╗╚██████╔╝███████║      ██████╔╝███████╗██║  ██║╚██████╔╝███████╗███████╗
╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝       ╚═╝     ╚══════╝ ╚═════╝ ╚══════╝      ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
                                                    
 ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  █████╗  ██████╗████████╗███████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝███████║██║        ██║   ███████╗
██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██╔══██║██║        ██║   ╚════██║
╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╗   ██║   ███████║
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚══════╝

endef

export HEADER

# DEFAULT VARIABLES
START_LOG = @echo "======================================================= START OF LOG ========================================================="
END_LOG = @echo "======================================================== END OF LOG =========================================================="

ifeq ($(NETWORK), "localhost")
  EXECUTED_VOUCHERS := script/ExecutedVouchers.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -v
	DEPLOY_NETWORK_ARGS := script/DeployContracts.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -v
else
	RPC_URL := $(RPC_URL)
	PRIVATE_KEY := $(PRIVATE_KEY)
	EXECUTED_VOUCHERS := script/ExecutedVouchers.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(TESTNET_BLOCKSCAN_API_KEY) -v
	DEPLOY_NETWORK_ARGS := script/DeployContracts.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(TESTNET_BLOCKSCAN_API_KEY) -v
endif

define test_contracts
	$(START_LOG)
	@forge test
	$(END_LOG)
endef

define executed_vouchers
	$(START_LOG)
	@forge script $(EXECUTED_VOUCHERS)
	$(END_LOG)
endef

define deploy_contracts
	$(START_LOG)
	@forge script $(DEPLOY_NETWORK_ARGS)
	$(END_LOG)
endef

setup: .env.tmpl
	forge install
	cp .env.tmpl .env

test:
	@echo "$$HEADER"
	@$(test_contracts)

vouchers:
	@echo "$$HEADER"
	@$(executed_vouchers)

deploy:
	@echo "$$HEADER"
	@$(deploy_contracts)